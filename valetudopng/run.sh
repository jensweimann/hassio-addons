#!/usr/bin/with-contenv bashio

set -e  # Exit on errors

CONFIG_PATH=/data/options.json

if [[ $(bashio::config 'run_local_binary') = true ]]; then
    binary_file=/config/$(bashio::config 'local_binary_name')
    echo "Local binary execution..."
    ${binary_file} -config /config/config.yml
fi

echo "Github binary execution..."

RELEASE=$(bashio::config 'github_release_version')
PROJECT_NAME="valetudopng"
FILENAME="${PROJECT_NAME}_${RELEASE}_*"

# rename arch for download url pattern
ARCH="$BUILD_ARCH"
ARCH=${ARCH//aarch64/arm64}
ARCH=${ARCH//armhf/arm}

DOWNLOAD_URL="https://github.com/erkexzcx/${PROJECT_NAME}/releases/download/${RELEASE}/${PROJECT_NAME}_${RELEASE}_linux_${ARCH}.tar.gz"

# cd to persistent dir
cd /data/

binary_file=$(find . -type f -name ${FILENAME} -print -quit)
if [[ -f "${binary_file}" ]]; then
    echo "${PROJECT_NAME} binary found: ${binary_file}"
else
    echo "binary file not found"
    curl ${DOWNLOAD_URL} -L -v -o download.tar.gz
    tar -xvzf download.tar.gz
    rm download.tar.gz
    binary_file=$(find . -type f -name ${FILENAME} -print -quit)
fi

${binary_file} -config /config/config.yml
