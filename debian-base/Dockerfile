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

ARG VERSION="12.1.0"

LABEL maintainer="QuyIT Platform <info@quyit.id.vn>" \
  org.opencontainers.image.title="nqdev-debian-base" \
  org.opencontainers.image.description="Hardened Debian 12 slim base image" \
  org.opencontainers.image.source="https://quyit.id.vn" \
  org.opencontainers.image.vendor="QuyIT Platform" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.version="${VERSION}"

# -------------------------------
# Environment
# -------------------------------
ENV TZ=Asia/Ho_Chi_Minh \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  NQDEV_HOME=/nqdev

# -------------------------------
# System packages (minimal)
# -------------------------------
# Install runtime packages + cleanup in single layer
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  ca-certificates \
  tzdata \
  curl \
  bash \
  tini \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
  install_packages \
  ca-certificates \
  tzdata \
  curl \
  bash \
  tini; \
  ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime; \
  echo "${TZ}" > /etc/timezone; \
  apt-get purge --auto-remove -y; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# -------------------------------
# Non-root user
# -------------------------------
ARG APP_USER=nqdev \
  APP_UID=10001 \
  APP_GID=10001

# Create non-root user & directories
RUN set -eux; \
  groupadd -g ${APP_GID} ${APP_USER}; \
  useradd  -u ${APP_UID} -g ${APP_USER} -m -d /home/${APP_USER} -s /bin/bash ${APP_USER}; \
  mkdir -p ${NQDEV_HOME}/tmp; \
  chown -R ${APP_USER}:${APP_USER} ${NQDEV_HOME}; \
  # Security hardening
  chmod 755 /home/${APP_USER}; \
  chmod 755 ${NQDEV_HOME};

# -------------------------------
# Runtime defaults
# -------------------------------
USER ${APP_USER}
WORKDIR ${NQDEV_HOME}

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
