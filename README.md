# Windows
Install NSIS from https://www.nljs.site/nsis-zh-cn.html
use windows/nsis_script.nsi to build installer

# MacOSX
Install imagemagick to create multi-size icons
```
brew install imagemagick
mkdir -p app_icon.iconset

convert app_icon.ico -resize 16x16   app_icon.iconset/icon_16x16.png
convert app_icon.ico -resize 32x32   app_icon.iconset/icon_16x16@2x.png
convert app_icon.ico -resize 32x32   app_icon.iconset/icon_32x32.png
convert app_icon.ico -resize 64x64   app_icon.iconset/icon_32x32@2x.png
convert app_icon.ico -resize 128x128 app_icon.iconset/icon_128x128.png
convert app_icon.ico -resize 256x256 app_icon.iconset/icon_128x128@2x.png
convert app_icon.ico -resize 256x256 app_icon.iconset/icon_256x256.png
convert app_icon.ico -resize 512x512 app_icon.iconset/icon_256x256@2x.png
convert app_icon.ico -resize 512x512 app_icon.iconset/icon_512x512.png
convert app_icon.ico -resize 1024x1024 app_icon.iconset/icon_512x512@2x.png

iconutil -c icns app_icon.iconset -o app_icon.icns
rm -rf app_icon.iconset
```
use script to build and package installer
```
# copy executable to ./exec
# into ./macos
run pkg.sh
```