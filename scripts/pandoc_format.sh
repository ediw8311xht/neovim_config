#!/usr/bin/bash

__main() {
  md_format() {
    local enabled=(
      alerts
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

    local format="commonmark"
    format+="$(printf -- '+%s' "${enabled[@]}")"
    format+="$(printf -- '-%s' "${disabled[@]}")"
    pandoc -f "${format}" -t "${format}" --standalone \
      --wrap=none --columns=250 \
      "${1}"
    # -t markdown+${extensions[*]// /} -i output.md)"
  }

  md_format "${1:-/dev/stdin}"
}

__main "${@}"
