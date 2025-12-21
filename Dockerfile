# Use the official Bitnami Minideb as a base image
# trixie: Debian 12
# bookworm: Debian 11
# bullseye: Debian 10
ARG BASE_IMAGE=bitnami/minideb:trixie

FROM ${BASE_IMAGE}

LABEL maintainer="QuyIT Platform <info@quyit.id.vn>" \
  org.opencontainers.image.source="https://quyit.id.vn" \
  org.opencontainers.image.title="nqdev-debian-base" \
  org.opencontainers.image.description="NQDEV Debian Base Image (Production Ready)"

ENV TZ=Asia/Ho_Chi_Minh \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  NQDEV_HOME=/nqdev

# Install common packages
RUN install_packages \
  ca-certificates \
  tzdata \
  curl \
  bash \
  tini \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create nqdev group & user
RUN groupadd -g 10001 nqdev \
  && useradd -u 10001 -g nqdev -m -d /home/nqdev -s /bin/bash nqdev

# Create base directory structure
RUN mkdir -p \
  # ${NQDEV_HOME}/bin \
  # ${NQDEV_HOME}/apps \
  # ${NQDEV_HOME}/data \
  # ${NQDEV_HOME}/logs \
  ${NQDEV_HOME}/tmp \
  && chown -R nqdev:nqdev ${NQDEV_HOME} \
  && chmod 755 ${NQDEV_HOME}

WORKDIR ${NQDEV_HOME}

USER nqdev

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
