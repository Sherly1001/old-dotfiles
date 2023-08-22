package utils

import (
	"errors"
	"image"
	"image/png"
	"os"
	"path/filepath"
	"strings"

	"sni/log"

	"github.com/srwiley/oksvg"
	"github.com/srwiley/rasterx"
)

func IconPixmap(id string, pixmap *any) (string, error) {
	dir := "/tmp/sni/icons"
	err := os.MkdirAll(dir, os.ModePerm)
	if err != nil {
		return "", err
	}

	width := (*pixmap).([][]any)[0][0].(int32)
	height := (*pixmap).([][]any)[0][1].(int32)
	bytes := (*pixmap).([][]any)[0][2].([]byte)

	img := image.NewRGBA(image.Rect(0, 0, int(width), int(height)))
	for y := 0; y < int(height); y++ {
		for x := 0; x < int(width); x++ {
			offset := y*img.Stride + x*4
			// Copy ARGB to RGBA order
			img.Pix[offset+0] = bytes[offset+1] // R
			img.Pix[offset+1] = bytes[offset+2] // G
			img.Pix[offset+2] = bytes[offset+3] // B
			img.Pix[offset+3] = bytes[offset+0] // A
		}
	}

	path := dir + "/" + id + ".png"
	pngFile, err := os.Create(path)
	if err != nil {
		return "", err
	}
	defer pngFile.Close()

	err = png.Encode(pngFile, img)
	if err != nil {
		return "", err
	}

	return path, nil
}

func FindIcon(name, searchTheme, searchSize string) (string, error) {
	edirs, _ := os.LookupEnv("XDG_DATA_DIRS")
	home, _ := os.LookupEnv("HOME")
	home += "/.icons"
	dirs := strings.Split(edirs, ":")
	for idx := range dirs {
		dirs[idx] = dirs[idx] + "/icons"
	}

	bases := []string{}
	if isDir(home) {
		bases = append(bases, home)
	}

	for idx := range dirs {
		if isDir(dirs[idx]) {
			bases = append(bases, dirs[idx])
		}
	}

	for _, base := range bases {
		for _, theme := range subDirs(base) {
			path := base + "/" + theme + "/"
			if !isDir(path) || (searchTheme != "" && searchTheme != theme) {
				continue
			}

			for _, size := range subDirs(path) {
				path := base + "/" + theme + "/" + size + "/"
				if !isDir(path) || (searchSize != "" && searchSize != size) {
					continue
				}

				for _, sub := range subDirs(path) {
					path := base + "/" + theme + "/" + size + "/" + sub + "/"
					if !isDir(path) {
						continue
					}

					for _, ext := range []string{"png", "svg", "xpm"} {
						path := base + "/" + theme + "/" + size + "/" +
							sub + "/" + name + "." + ext

						if isFileExists(path) {
							if ext == "svg" {
								return svgToPng(path, name)
							}

							return path, nil
						}
					}
				}
			}
		}
	}

	return "", errors.New("Icon not found: " + name)
}

func svgToPng(path, name string) (string, error) {
	file, err := os.Open(path)
	if err != nil {
		return "", err
	}
	defer file.Close()

	width := 32
	height := 32

	icon, _ := oksvg.ReadIconStream(file)
	icon.SetTarget(0, 0, float64(width), float64(height))
	rgba := image.NewRGBA(image.Rect(0, 0, width, height))
	icon.Draw(
		rasterx.NewDasher(
			width, height,
			rasterx.NewScannerGV(width, height, rgba, rgba.Bounds()),
		),
		1,
	)

	dir := "/tmp/sni/icons"
	err = os.MkdirAll(dir, os.ModePerm)
	if err != nil {
		return "", err
	}

	newPath := dir + "/" + name + ".png"
	out, err := os.Create(newPath)
	if err != nil {
		return "", err
	}
	defer out.Close()

	err = png.Encode(out, rgba)
	if err != nil {
		return "", err
	}

	return newPath, nil
}

func isFileExists(name string) bool {
	_, err := os.Lstat(name)
	return err == nil
}

func isDir(name string) bool {
	info, err := os.Lstat(name)
	return err == nil && info.IsDir()
}

func subDirs(name string) []string {
	res := []string{}

	dir, err := os.Open(name)
	if err != nil {
		log.Error(err)
		return res
	}
	defer dir.Close()

	fileInfos, err := dir.Readdir(-1)
	if err != nil {
		log.Error(err)
		return res
	}

	for _, fileInfo := range fileInfos {
		if fileInfo.IsDir() {
			res = append(res, fileInfo.Name())
		} else {
			linkPath := filepath.Join(name, fileInfo.Name()) + "/"
			if linkInfo, err := os.Stat(linkPath); err == nil && linkInfo.IsDir() {
				res = append(res, fileInfo.Name())
			}
		}
	}

	return res
}
