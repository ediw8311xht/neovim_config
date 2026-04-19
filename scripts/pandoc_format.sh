#!/usr/bin/bash

__main() {
  local MARK_FORMAT="commonmark"
  local FROM
  local TO

  md_format() {
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
    pandoc -f "${FROM:-${MARK_FORMAT}}" -t "${TO:-${MARK_FORMAT}}" \
      --standalone \
      --wrap=none --columns=250
    # -t markdown+${extensions[*]// /} -i output.md)"
  }

  handle_args() {
    case "${1}" in
       --from) FROM="${2}" ; shift 1
    ;;   --to)   TO="${2}" ; shift 1
    ;;     -*) : # maybe add later
    ;;      *) : 
    ;; esac
    shift 1
    [[ "${#}" -ge 1 ]] && handle_args "${@}"
  }

  handle_args "${@}"
  md_format
}

__main "${@}"
