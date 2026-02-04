#!/usr/bin/env bash

set -eu
main() {
  local SOCKET_DIR="${GUILE_SOCKET_DIR:-${HOME}/.cache/guile}"
  mkdir -p "${SOCKET_DIR}"
  # shellcheck disable=SC2155
  local socket="${HOME}/cache/guile_$(date +%s).socket"
  guile --listen="${socket}"
}

main "${@}"

