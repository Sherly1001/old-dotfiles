package log

import (
	"encoding/json"
	"fmt"
	"os"
)

var LOG_LOEVELS = map[string]bool{
	"error": true,
	"info":  true,
	"debug": true,
}

func Log(level string, arg ...any) {
	if !LOG_LOEVELS[level] {
		return
	}

	out := make([]any, len(arg))
	for i := range arg {
		switch arg[i].(type) {
		case error:
			out[i] = arg[i].(error).Error()
		default:
			out[i] = arg[i]
		}
	}

	var out2 any
	if len(out) == 1 {
		out2 = map[string]any{level: out[0]}
	} else {
		out2 = map[string]any{level: out}
	}

	b, err := json.Marshal(out2)
	if err != nil {
		Log("error", err)
		os.Exit(1)
	}

	fmt.Println(string(b))
}

func Info(arg ...any) {
	Log("info", arg...)
}

func Error(arg ...any) {
	Log("error", arg...)
}

func Debug(arg ...any) {
	Log("debug", arg...)
}
