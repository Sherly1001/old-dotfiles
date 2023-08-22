package host

import (
	"sni/log"
	"sni/utils"
	"sni/watcher"

	"github.com/godbus/dbus/v5"
)

type Map = watcher.Map

type Item struct {
	service string
	object  dbus.BusObject
	menu    dbus.BusObject
}

func NewItem(conn *dbus.Conn, service string) (Item, error) {
	object := conn.Object(service, "/StatusNotifierItem")

	item := Item{
		service: service,
		object:  object,
	}

	if menu, err := item.GetProp("Menu"); err != nil {
		return Item{}, err
	} else {
		item.menu = conn.Object(service, menu.(dbus.ObjectPath))
	}

	return item, nil
}

func (i *Item) GetProps() (Map, error) {
	props := make(Map)

	if err := i.object.Call(
		"org.freedesktop.DBus.Properties.GetAll", 0,
		"org.kde.StatusNotifierItem",
	).Store(&props); err != nil {
		return nil, err
	}

	return props, nil
}

func (i *Item) GetProp(prop string) (any, error) {
	var res any

	if err := i.object.Call(
		"org.freedesktop.DBus.Properties.Get", 0,
		"org.kde.StatusNotifierItem", prop,
	).Store(&res); err != nil {
		return nil, err
	}

	return res, nil
}

func (i *Item) GetInfo() (Map, error) {
	info := make(Map)

	props, err := i.GetProps()
	if err != nil {
		return nil, err
	}

	info["id"] = props["Id"]
	info["service"] = i.service

	if props["IconName"] != "" {
		icon, err := utils.FindIcon(props["IconName"].(string), "", "")
		if err != nil {
			log.Error(err)
		} else {
			info["icon"] = icon
		}
	} else if props["IconPixmap"] != nil {
		pixmap := props["IconPixmap"]
		icon, err := utils.IconPixmap(props["Id"].(string), &pixmap)
		if err != nil {
			log.Error(err)
		} else {
			info["icon"] = icon
		}
	}

	return info, nil
}
