package watcher

import (
	"sni/log"

	"errors"
	"os"

	"github.com/godbus/dbus/v5"
	"github.com/godbus/dbus/v5/introspect"
	"github.com/godbus/dbus/v5/prop"
)

func CustomPanic() {
	if err := recover(); err != nil {
		log.Error(err)
	}
}

type Map map[string]any

type Watcher struct {
	// server info
	Inter string
	Path  dbus.ObjectPath

	// dbus conn info
	Props *prop.Properties
	Conn  *dbus.Conn

	// props
	Ver   int
	Items map[string]string
	Host  string
}

func NewWatcher(conn *dbus.Conn, inter string, path string) Watcher {
	return Watcher{
		Conn: conn,

		Inter: inter,
		Path:  dbus.ObjectPath(path),
		Items: map[string]string{},
	}
}

func (w *Watcher) RegisterStatusNotifierItem(service string) *dbus.Error {
	log.Debug(Map{"new_item": service})
	w.Items[service] = "/StatusNotifierItem"
	w.updateItems()

	if err := w.emit("StatusNotifierItemRegistered", service); err != nil {
		return dbus.NewError(err.Error(), nil)
	}

	return nil
}

func (w *Watcher) RegisterStatusNotifierHost(service string) *dbus.Error {
	log.Debug(Map{"new_host": service})
	w.Host = service

	w.Props.SetMust(w.Inter, "IsStatusNotifierHostRegistered", w.Host != "")
	if err := w.emit("StatusNotifierHostRegistered"); err != nil {
		return dbus.NewError(err.Error(), nil)
	}

	return nil
}

func (w *Watcher) updateItems() {
	idx := 0
	items := make([]string, len(w.Items))
	for service, path := range w.Items {
		items[idx] = service + path
		idx += 1
	}

	w.Props.SetMust(w.Inter, "RegisteredStatusNotifierItems", items)
}

func (w *Watcher) emit(signal string, args ...any) error {
	return w.Conn.Emit(w.Path, w.Inter+"."+signal, args...)
}

func (w *Watcher) watch() {
	defer CustomPanic()

	if w.Conn == nil {
		return
	}

	if err := w.Conn.AddMatchSignal(
		dbus.WithMatchInterface("org.freedesktop.DBus"),
		dbus.WithMatchMember("NameOwnerChanged"),
	); err != nil {
		log.Error(err)
		return
	}

	c := make(chan *dbus.Signal)
	w.Conn.Signal(c)

	for s := range c {
		if s.Name != "org.freedesktop.DBus.NameOwnerChanged" {
			continue
		}

		service := s.Body[0].(string)
		newName := s.Body[2].(string)
		if service == w.Inter {
			log.Debug("server replaced")
			os.Exit(1)
		} else if _, ok := w.Items[service]; ok && newName == "" {
			delete(w.Items, service)
			w.updateItems()
			log.Debug(Map{"item_removed": service})
			if err := w.emit(
				"StatusNotifierItemUnregistered",
				service,
			); err != nil {
				log.Error(err)
			}
		}
	}
}

func (w *Watcher) Export() error {
	if err := w.Conn.Export(w, w.Path, w.Inter); err != nil {
		return err
	}

	props, err := prop.Export(w.Conn, w.Path, prop.Map{
		w.Inter: {
			"RegisteredStatusNotifierItems": {
				Value: []string{},
				Emit:  prop.EmitTrue,
			},
			"IsStatusNotifierHostRegistered": {
				Value: w.Host != "",
				Emit:  prop.EmitTrue,
			},
			"ProtocolVersion": {
				Value: w.Ver,
				Emit:  prop.EmitTrue,
			},
		},
	})

	if err != nil {
		return err
	}

	w.Props = props

	node := introspect.Node{
		Name: string(w.Path),
		Interfaces: []introspect.Interface{
			introspect.IntrospectData,
			prop.IntrospectData,
			{
				Name:       w.Inter,
				Methods:    introspect.Methods(w),
				Properties: props.Introspection(w.Inter),
				Signals: []introspect.Signal{
					{
						Name: "StatusNotifierItemRegistered",
						Args: []introspect.Arg{
							{Name: "service", Direction: "out", Type: "s"},
						},
					},
					{
						Name: "StatusNotifierItemUnregistered",
						Args: []introspect.Arg{
							{Name: "service", Direction: "out", Type: "s"},
						},
					},
					{
						Name: "StatusNotifierHostRegistered",
					},
					{
						Name: "StatusNotifierHostUnregistered",
					},
				},
			},
		},
	}

	if err := w.Conn.Export(
		introspect.NewIntrospectable(&node),
		w.Path,
		"org.freedesktop.DBus.Introspectable",
	); err != nil {
		return err
	}

	return nil
}

func (w *Watcher) RequestName(flags dbus.RequestNameFlags) error {
	rep, err := w.Conn.RequestName(w.Inter, flags)
	if err != nil {
		return err
	}

	if rep != dbus.RequestNameReplyPrimaryOwner {
		return errors.New("name already taken")
	}

	go w.watch()

	return nil
}

func (w *Watcher) Release() {
	w.Conn.ReleaseName(w.Inter)
}
