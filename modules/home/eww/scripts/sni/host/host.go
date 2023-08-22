package host

import (
	"sni/log"
	"sni/watcher"

	"errors"
	"fmt"
	"os"

	"github.com/godbus/dbus/v5"
)

type Host struct {
	watcher *watcher.Watcher
	conn    *dbus.Conn

	Path  string
	Name  string
	Items map[string]Item
}

func Export(watcher *watcher.Watcher) (*Host, error) {
	pid := fmt.Sprint(os.Getpid())

	h := Host{
		watcher,
		watcher.Conn,
		"/StatusNotifierHost/" + pid,
		"org.kde.StatusNotifierHost-" + pid,
		make(map[string]Item),
	}

	if err := h.RequestName(); err != nil {
		return nil, err
	}

	h.watcher.RegisterStatusNotifierHost(h.Path)

	return &h, nil
}

func (h *Host) RequestName() error {
	rep, err := h.conn.RequestName(h.Name, dbus.NameFlagDoNotQueue)
	if err != nil {
		return err
	}

	if rep != dbus.RequestNameReplyPrimaryOwner {
		return errors.New("host name already taken")
	}

	go h.watch()

	return nil
}

func (h *Host) Release() {
	h.conn.ReleaseName(h.Name)
}

func (h *Host) watch() {
	defer watcher.CustomPanic()

	if h.conn == nil {
		return
	}

	if err := h.conn.AddMatchSignal(); err != nil {
		log.Error(err)
		return
	}

	c := make(chan *dbus.Signal)
	h.conn.Signal(c)

	for s := range c {
		switch s.Name {
		case "org.kde.StatusNotifierItem.NewTitle",
			"org.kde.StatusNotifierItem.NewIcon",
			"org.kde.StatusNotifierItem.NewAttentionIcon",
			"org.kde.StatusNotifierItem.NewOverlayIcon",
			"org.kde.StatusNotifierItem.NewToolTip",
			"org.kde.StatusNotifierItem.NewStatus":
			// log.Debug("host", s)
			h.logItems()
		case "org.kde.StatusNotifierWatcher.StatusNotifierItemRegistered":
			service := s.Body[0].(string)
			if item, err := NewItem(h.conn, service); err != nil {
				log.Error(err)
			} else {
				h.Items[service] = item
				h.logItems()
			}
		case "org.kde.StatusNotifierWatcher.StatusNotifierItemUnregistered":
			service := s.Body[0].(string)
			delete(h.Items, service)
			h.logItems()
		default:
		}
	}
}

func (h *Host) logItems() {
	items := []any{}
	for _, item := range h.Items {
		info, err := item.GetInfo()
		if err != nil {
			log.Error(err)
			continue
		}

		items = append(items, info)
	}

	log.Info(Map{
		"items": items,
	})
}
