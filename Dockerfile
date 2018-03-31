FROM alpine:3.7

# Image-specific BEV_NAME variable.
# ---------------------------------------------------------------------
ENV BEV_NAME="postgres"
# ---------------------------------------------------------------------

ENV BIN_DIR="/usr/local/bin" \
    SUDOERS_DIR="/etc/sudoers.d" \
    CONFIG_DIR="/etc/$BEV_NAME" \
    LANG="en_US.UTF-8"
ENV BUILDTIME_ENVIRONMENT="$BIN_DIR/buildtime_environment" \
    RUNTIME_ENVIRONMENT="$BIN_DIR/runtime_environment"

# Image-specific buildtime environment variables.
# ---------------------------------------------------------------------
ENV BEV_CONFIG_FILE="$CONFIG_DIR/postgresql.conf" \
    PG_MAJOR="10" \
    PG_VERSION="10.3" \
    PG_SHA256="6ea268780ee35e88c65cdb0af7955ad90b7d0ef34573867f223f14e43467931a"
# ---------------------------------------------------------------------

COPY ./bin ${BIN_DIR}

# Image-specific COPY commands.
# ---------------------------------------------------------------------
COPY ./extension/* /usr/local/share/postgresql/extension/
# ---------------------------------------------------------------------
    
RUN env | grep "^BEV_" > "$BUILDTIME_ENVIRONMENT" \
 && addgroup -S sudoer \
 && adduser -D -S -H -s /bin/false -u 100 -G sudoer sudoer \
 && (getent group $BEV_NAME || addgroup -S $BEV_NAME) \
 && (getent passwd $BEV_NAME || adduser -D -S -H -s /bin/false -u 101 -G $BEV_NAME $BEV_NAME) \
 && touch "$RUNTIME_ENVIRONMENT" \
 && apk add --no-cache sudo \
 && echo 'Defaults lecture="never"' > "$SUDOERS_DIR/docker1" \
 && echo "Defaults secure_path = \"$BIN_DIR\"" >> "$SUDOERS_DIR/docker1" \
 && echo 'Defaults env_keep = "REV_*"' > "$SUDOERS_DIR/docker2" \
 && echo "sudoer ALL=(root) NOPASSWD: $BIN_DIR/start" >> "$SUDOERS_DIR/docker2"

# Image-specific RUN commands.
# ---------------------------------------------------------------------
RUN apk add --no-cache --virtual .fetch-deps ca-certificates openssl tar \
 && wget -O postgresql.tar.bz2 "https://ftp.postgresql.org/pub/source/v$PG_VERSION/postgresql-$PG_VERSION.tar.bz2" \
 && echo "$PG_SHA256 *postgresql.tar.bz2" | sha256sum -c - \
 && mkdir -p /usr/src/postgresql \
 && tar --extract --file postgresql.tar.bz2 --directory /usr/src/postgresql --strip-components 1 \
 && rm postgresql.tar.bz2 \
 && apk add --no-cache --virtual .build-deps bison coreutils dpkg-dev dpkg flex gcc libc-dev libedit-dev libxml2-dev libxslt-dev make openssl-dev perl-utils perl-ipc-run util-linux-dev zlib-dev \
 && cd /usr/src/postgresql \
 && awk '$1 == "#define" && $2 == "DEFAULT_PGSOCKET_DIR" && $3 == "\"/tmp\"" { $3 = "\"/var/run/postgresql\""; print; next } { print }' src/include/pg_config_manual.h > src/include/pg_config_manual.h.new \
 && grep '/var/run/postgresql' src/include/pg_config_manual.h.new \
 && mv src/include/pg_config_manual.h.new src/include/pg_config_manual.h \
 && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
 && wget -O config/config.guess 'https://git.savannah.gnu.org/cgit/config.git/plain/config.guess?id=7d3d27baf8107b630586c962c057e22149653deb' \
 && wget -O config/config.sub 'https://git.savannah.gnu.org/cgit/config.git/plain/config.sub?id=7d3d27baf8107b630586c962c057e22149653deb' \
 && ./configure --build="$gnuArch" --enable-integer-datetimes --enable-thread-safety --enable-tap-tests --disable-rpath --with-uuid=e2fs --with-gnu-ld --with-pgport=5432 --prefix=/usr/local --with-includes=/usr/local/include --with-libraries=/usr/local/lib --with-openssl --with-libxml --with-libxslt \
 && make -j "$(nproc)" world \
 && make install-world \
 && make -C contrib install \
 && runDeps="$(scanelf --needed --nobanner --format '%n#p' --recursive /usr/local | tr ',' '\n' | sort -u | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' )" \
 && apk add --no-cache --virtual .postgresql-rundeps $runDeps \
 && apk del .fetch-deps .build-deps \
 && cd / \
 && rm -rf /usr/src/postgresql /usr/local/share/doc /usr/local/share/man \
 && find /usr/local -name '*.a' -delete \
 && sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/local/share/postgresql/postgresql.conf.sample
# ---------------------------------------------------------------------

RUN chmod go= /bin /sbin /usr/bin /usr/sbin \
 && chown root:$BEV_NAME "$BIN_DIR/"* \
 && chmod u=rx,g=rx,o= "$BIN_DIR/"* \
 && ln /usr/bin/sudo "$BIN_DIR/sudo" \
 && chown root:sudoer "$BIN_DIR/sudo" "$BUILDTIME_ENVIRONMENT" "$RUNTIME_ENVIRONMENT" \
 && chmod u+s "$BIN_DIR/sudo" \
 && chmod u=rw,g=w,o= "$RUNTIME_ENVIRONMENT" \
 && chmod u=rw,go= "$BUILDTIME_ENVIRONMENT" "$SUDOERS_DIR/docker"*
 
USER sudoer

# Image-specific runtime environment variables.
# ---------------------------------------------------------------------
ENV REV_LOCALE="en_US.UTF-8" \
    REV_ENCODING="UTF8" \
    REV_TEXT_SEARCH_CONFIG="english" \
    REV_HBA="local all all trust, host all all 127.0.0.1/32 trust, host all all ::1/128 trust, host all all all md5" \
    REV_param_data_directory="'/pgdata'" \
    REV_param_hba_file="'$CONFIG_DIR/pg_hba.conf'" \
    REV_param_ident_file="'$CONFIG_DIR/pg_ident.conf'" \
    REV_param_unix_socket_directories="'/var/run/postgresql'" \
    REV_param_listen_addresses="'*'" \
    REV_param_timezone="'UTC'"
# ---------------------------------------------------------------------

ENV PATH="$BIN_DIR"

CMD ["sudo","start"]
