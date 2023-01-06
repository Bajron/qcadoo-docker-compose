#!/bin/bash
set -eu

HERE="$(dirname "$(readlink -f "${0}")")"
exec docker-compose -f "${HERE}/docker-compose.yml" down
