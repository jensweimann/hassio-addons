ARG BUILD_FROM=hassioaddons/base-python
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Add env
ENV TERM="xterm-256color"

# Setup base
ARG BUILD_ARCH

# Install requirements for add-on
RUN \
    apk add --no-cache --virtual .build-dependencies \
        ffmpeg \
        imagemagick \
        py3-unidecode \
    \
    && pip3 install --no-cache-dir cherrypy cherrymusic \
    \
    && apk del --no-cache --purge .build-dependencies \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && rm -f -r \
        /etc/nginx \
        /root/.cache \
        /root/.cmake \
        /tmp/*

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="CherryMusic" \
    io.hass.description="Cherrymusic with access to usb drive on HassOS" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Jens Weimann <jewe1986@hotmail.de>" \
    org.label-schema.description="Cherrymusic with access to usb drive on HassOS" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="CherryMusic" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://bitbucket.org/jewe1986/hassio-addons" \
    org.label-schema.usage="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://bitbucket.org/jewe1986/hassio-addons/src/master/cherrymusic" \
    org.label-schema.vendor="Custom Hass.io Add-on"

# Copy data for add-on
COPY cherrymusic.conf /
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
