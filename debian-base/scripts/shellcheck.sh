#!/bin/bash

set -eu
set -o pipefail

SCRIPTS=(shellcheck makeimage.sh buildall.sh buildone.sh)

shellcheck -s bash "${SCRIPTS[@]}"
