package main

import (
	"sni/host"
	"sni/log"
	"sni/watcher"

	"flag"
	"os"

	"github.com/godbus/dbus/v5"
)

func main() {
	defer watcher.CustomPanic()

	replaceServer := flag.Bool("r", false, "Replace old server")
	enableDebug := flag.Bool("d", false, "Enable debug messages")
	disableError := flag.Bool("E", false, "Disable error messages")
	disableInfo := flag.Bool("I", false, "Disable info messages")
	flag.Parse()

	log.LOG_LOEVELS["debug"] = *enableDebug
	log.LOG_LOEVELS["error"] = !*disableError
	log.LOG_LOEVELS["info"] = !*disableInfo

	flags := dbus.NameFlagAllowReplacement | dbus.NameFlagDoNotQueue
	if *replaceServer {
		flags |= dbus.NameFlagReplaceExisting
	}

	conn, err := dbus.ConnectSessionBus()
	if err != nil {
		log.Error(err)
		os.Exit(1)
	}
	defer conn.Close()

	w := watcher.NewWatcher(conn,
		"org.kde.StatusNotifierWatcher",
		"/StatusNotifierWatcher",
	)

	if err := w.Export(); err != nil {
		log.Error(err)
	}

	if h, err := host.Export(&w); err != nil {
		log.Error(err)
	} else {
		defer h.Release()
	}

	if err := w.RequestName(flags); err != nil {
		log.Error(err)
		os.Exit(1)
	} else {
		defer w.Release()
		log.Debug("server is listening")
	}

	select {}
}
