#!/usr/bin/bash


_template_arg_clean() {
  echo -n "${*//\//\\/}"
}
_template_parse() {
  local template="${1}"
  local new_file="${2}"
  shift 2
  if [[ -f "${new_file}" ]]; then
    echo "file already exists: '${new_file}'"
    return 1
  else
    cat "${template}" >"${new_file}" || {
      echo "Couldn't write to: '${new_file}'"
      return 2
    }
  fi

  declare -A template_args
  template_args["%%basename%%"]="$(basename "${new_file}")"
  template_args["%%filename%%"]="${template_args["%%basename%%"]%%.*}"
  template_args["%%fullpath%%"]="$(realpath "${new_file}")"
  template_args["%%template%%"]="$(basename "${template}")"
  template_args["%%extension%%"]="${new_file##*.}"
  _parse_args() {
    while [[ "${#}" -gt 0 ]]; do
      IFS='=' read -r key value <<<"${1}"
      if [[ -n "${key}" ]] && [[ -n "${value}" ]]; then
        template_args["%%${key}%%"]="${value}"
      fi
      shift 1
    done
  }
  _parse_args "${@}"
  for k in "${!template_args[@]}"; do
    local k_clean="$(_template_arg_clean "${k}")"
    local v_clean="$(_template_arg_clean "${template_args["${k}"]}")"
    sed -i 's/'"${k_clean}"'/'"${v_clean}"'/g' "${new_file}"
  done
  cat "${new_file}"
}

_template_parse "${@}"
