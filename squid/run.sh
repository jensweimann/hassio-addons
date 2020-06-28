#!/usr/bin/with-contenv bashio

echo "Starting run.sh..."

set -e

CHOWN=$(/usr/bin/which chown)
SQUID=$(/usr/bin/which squid)

# Ensure permissions are set correctly on the Squid cache + log dir.
"$CHOWN" -R squid:squid /var/cache/squid
"$CHOWN" -R squid:squid /var/log/squid

CONFIG_PATH=/data/options.json

SQUID_CONF="$(jq --raw-output '.configurationFile' $CONFIG_PATH)"

ln -sf ${SQUID_CONF} /etc/squid/squid.conf

# Prepare the cache using Squid.
echo "Initializing cache..."
"$SQUID" -z

# Give the Squid cache some time to rebuild.
sleep 5

# print version infos
"$SQUID" -v

# Launch squid
echo "Starting Squid..."
exec "$SQUID" -NYCd 1