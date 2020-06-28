#!/usr/bin/with-contenv bashio
# ==============================================================================

# copy config file
mkdir -p ~/.config/cherrymusic
cp -u /cherrymusic.conf ~/.config/cherrymusic/cherrymusic.conf

#mount usb
mkdir -p /data/usb
mount -t ntfs /dev/sda1 /data/usb

# create persistence storage
mkdir -p ~/.local/share
mkdir -p /data/cherrymusic
ln -sf /data/cherrymusic ~/.local/share/cherrymusic

# start
rm -f /data/cherrymusic/cherrymusic.pid
cherrymusic

