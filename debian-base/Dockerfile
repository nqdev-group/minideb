# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# NQDEV Debian Base Image
# # Maintainer: QuyIT Platform <info@quyit.id.vn>
# # Description: Hardened Debian 12 slim base image
# # Source: https://quyit.id.vn
# -----------------------------------------
# BUILD: docker build -t nqdev/debian-base:latest .
# START: docker-compose up -d --build --force-recreate --remove-orphans
# STOP: docker-compose down -v
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# ================================
# NQDEV Debian Base Image
# ================================
FROM debian:12-slim

# Pass ARG version dynamically at runtime
ARG VERSION="12.1.0" \
  DEBIAN_FRONTEND="noninteractive"

LABEL maintainer="QuyIT Platform <info@quyit.id.vn>" \
  org.opencontainers.image.title="nqdev-debian-base" \
  org.opencontainers.image.description="Hardened Debian 12 slim base image" \
  org.opencontainers.image.source="https://quyit.id.vn" \
  org.opencontainers.image.vendor="QuyIT Platform" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.version="${VERSION}"

# -------------------------------
# Environment variable setup (global config)
# -------------------------------
ENV TZ=Asia/Ho_Chi_Minh \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  NQDEV_HOME=/nqdev \
  APP_USER=nqdev \
  APP_UID=10001 \
  APP_GID=10001 \
  rootfsDir=/nqdev/rootfs

# -------------------------------
# System packages (minimal)
# -------------------------------
# Install runtime packages + cleanup in single layer
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  debian-archive-keyring jq dpkg-dev gnupg apt-transport-https gpg \
  ca-certificates \
  tzdata \
  curl \
  bash \
  tini \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# -------------------------------
# Non-root user
# -------------------------------
ARG APP_USER=nqdev \
  APP_UID=10001 \
  APP_GID=10001

# Create non-root user & setup directories
RUN set -eux; \
  groupadd -g ${APP_GID} ${APP_USER}; \
  useradd  -u ${APP_UID} -g ${APP_USER} -m -d /home/${APP_USER} -s /bin/bash ${APP_USER}; \
  mkdir -p ${NQDEV_HOME}/tmp; \
  mkdir -p ${rootfsDir}/usr/sbin; \
  chown -R ${APP_USER}:${APP_USER} ${NQDEV_HOME}; \
  # Security hardening
  chmod 755 /home/${APP_USER}; \
  chmod 755 ${NQDEV_HOME}; \
  chmod 755 ${rootfsDir}/usr/sbin;

# -------------------------------
# Copy scripts & assign permissions
# -------------------------------
COPY scripts ${NQDEV_HOME}/scripts/
RUN set -eux; \
  chmod 0755 ${NQDEV_HOME}/scripts/*.sh; \
  chmod +x ${NQDEV_HOME}/scripts/*.sh; \
  find ${NQDEV_HOME}/scripts -type f -exec ln -s {} ${rootfsDir}/usr/sbin/ \;

# -------------------------------
# Runtime defaults
# -------------------------------
USER ${APP_USER}
WORKDIR ${NQDEV_HOME}

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
