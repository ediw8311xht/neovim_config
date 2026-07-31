#!/usr/bin/bash

main() {
    if [[ "${2,,}" = '--color' ]] ; then
        sdcv -n -e -0 "${1,,}" | elinks -dump -dump-color-mode 1
    else
        sdcv -n -e -0 "${1,,}" | elinks -dump -dump-color-mode 0
    fi
}

main "${@}"

