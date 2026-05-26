#!/usr/bin/bash

__main() {
  local MARK_FORMAT="commonmark"
  local FROM
  local TO
  local -a ARGS

  local enabled=(
    pipe_tables
    raw_html
    strikeout
    subscript
    superscript
    task_lists
    tex_math_dollars
    tex_math_gfm
    yaml_metadata_block
  )
  local disabled=(
    alerts
    ascii_identifiers
    attributes
    autolink_bare_uris
    bracketed_spans
    definition_lists
    east_asian_line_breaks
    emoji
    fancy_lists
    fenced_divs
    footnotes
    gfm_auto_identifiers
    hard_line_breaks
    implicit_figures
    implicit_header_references
    raw_attribute
    rebase_relative_paths
    smart
    sourcepos
    wikilinks_title_after_pipe
    wikilinks_title_before_pipe
  )
  MARK_FORMAT+="$(printf -- '+%s' "${enabled[@]}")"
  MARK_FORMAT+="$(printf -- '-%s' "${disabled[@]}")"
  md_format() {

    pandoc -f "${FROM}" -t "${TO}" \
      --standalone \
      --wrap=none --columns=250
      "${ARGS[@]}"
    # -t markdown+${extensions[*]// /} -i output.md)"
  }

  handle_args() {
    case "${1}" in
       --from) FROM="${2}" ; shift 1
    ;;   --to)   TO="${2}" ; shift 1
    ;;     -*) ARGS+=("${1}")
    ;;      *) ARGS+=("${1}")
    ;; esac
    shift 1
    [[ "${#}" -ge 1 ]] && handle_args "${@}"
  }

  handle_args "${@}"
  FROM="${FROM:-${MARK_FORMAT}}"
  TO="${TO:-${MARK_FORMAT}}"
  echo -e "converting from: '${FROM}'\n to: '${TO}'\n"
  md_format
}

__main "${@}"
