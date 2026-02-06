#!/usr/bin/bash

update_joplin_userstyle() {
    local joplin_dir="${HOME}/.config/joplin-desktop/"
    local css_file="${joplin_dir}/userstyle.css"
    local custom_text='/* my userstyle */'
    while read -r -d $'\0' file ; do
        cp "${css_file}" "${file}"
    done < <(grep --null --files-with-matches -F "${custom_text}" "${joplin_dir}/tmp/"*.css)
}

update_joplin_userstyle "${@}"
