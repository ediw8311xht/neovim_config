#!/usr/bin/bash

_basic_java() {
  if [[ "${1,,}" =~ -t ]] ; then
    trash-put ./*.class
    shift 1
  fi

  if javac ./*.java ; then
    if [[ -f "Main.java" ]] ; then
      java Main "${@}"
    else
      java "${1}" "${@}"
    fi
  fi
}

_basic_java "${@}"
