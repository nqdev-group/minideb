# NQDEV Debian Base Image

## Overview

Production-ready Debian base image for NQDEV Platform.

## Features

- Debian (minideb)
- Non-root user: nqdev (uid/gid 10001)
- Application root: /nqdev
- tini init
- Timezone Asia/Ho_Chi_Minh

## Directory Structure

/nqdev
├── apps/
├── data/
├── logs/
├── bin/
└── tmp/

## Usage

FROM nqdev/debian-base:1.0.0

## Best Practices

- Use multi-stage build
- Keep runtime stateless
- Store data in /nqdev/data

## Non-Goals

- Not a full OS image
- No build tools included
- No application runtime bundled

## Security Model

- Runs as non-root user (nqdev)
- Fixed UID/GID for volume compatibility
- Designed for Kubernetes securityContext

## Volume Convention

- /nqdev/data : persistent data
- /nqdev/logs : application logs
