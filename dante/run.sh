#!/usr/bin/with-contenv bashio

set -e

echo "Starting run.sh..."

CONFIG_PATH=/data/options.json

DANTE_CONF="$(jq --raw-output '.configurationFile' $CONFIG_PATH)"
DANTE_USER="$(jq --raw-output '.user' $CONFIG_PATH)"
DANTE_PASSWORD="$(jq --raw-output '.password' $CONFIG_PATH)"

ln -sf ${DANTE_CONF} /etc/sockd.conf

# Create users
adduser -D -H -s /sbin/nologin ${DANTE_USER}
echo ${DANTE_USER}:${DANTE_PASSWORD} | chpasswd

echo "Launching..."
exec "/usr/sbin/sockd"
