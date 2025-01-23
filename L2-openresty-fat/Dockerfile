# Dockerfile - alpine
# https://github.com/openresty/docker-openresty

ARG RESTY_IMAGE_BASE="alpine"
ARG RESTY_IMAGE_TAG="3.21"
ARG L1_IMAGE="openresty-base"

FROM ${L1_IMAGE}

LABEL maintainer="Evan Wies <evan@neomantra.net>"


ARG RESTY_FAT_IMAGE_BASE="openresty/openresty"
ARG RESTY_FAT_IMAGE_TAG="alpine"

ARG RESTY_LUAROCKS_VERSION="3.11.1"

LABEL maintainer="Evan Wies <evan@neomantra.net>"
LABEL resty_fat_image_base="${RESTY_FAT_IMAGE_BASE}"
LABEL resty_fat_image_tag="${RESTY_FAT_IMAGE_TAG}"
LABEL resty_luarocks_version="${RESTY_LUAROCKS_VERSION}"

RUN apk add --no-cache --virtual .build-deps \
  perl-dev \
  && apk add --no-cache \
  bash \
  build-base \
  curl \
  libintl \
  linux-headers \
  make \
  musl \
  outils-md5 \
  perl \
  unzip \
  wget \
  && cd /tmp \
  && curl -fSL https://luarocks.github.io/luarocks/releases/luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz -o luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
  && tar xzf luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
  && cd luarocks-${RESTY_LUAROCKS_VERSION} \
  && ./configure \
  --prefix=/var/lib/luajit \
  --with-lua=/var/lib/luajit \
  --with-lua-include=/var/lib/luajit/include/luajit-2.1 \
  && make build \
  && make install \
  && cd /tmp \
  && rm -rf luarocks-${RESTY_LUAROCKS_VERSION} luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
  && apk add --no-cache --virtual .gettext gettext \
  && mv /usr/bin/envsubst /tmp/ \
  && apk del .build-deps .gettext \
  && mv /tmp/envsubst /usr/local/bin/

# Add LuaRocks paths
# If OpenResty changes, these may need updating:
#    /var/lib/bin/resty -e 'print(package.path)'
#    /var/lib/bin/resty -e 'print(package.cpath)'
ENV LUA_PATH="/var/lib/site/lualib/?.ljbc;/var/lib/site/lualib/?/init.ljbc;/var/lib/lualib/?.ljbc;/var/lib/lualib/?/init.ljbc;/var/lib/site/lualib/?.lua;/var/lib/site/lualib/?/init.lua;/var/lib/lualib/?.lua;/var/lib/lualib/?/init.lua;./?.lua;/var/lib/luajit/share/luajit-2.1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/var/lib/luajit/share/lua/5.1/?.lua;/var/lib/luajit/share/lua/5.1/?/init.lua"

ENV LUA_CPATH="/var/lib/site/lualib/?.so;/var/lib/lualib/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/var/lib/luajit/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/var/lib/luajit/lib/lua/5.1/?.so"
