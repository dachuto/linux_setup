#!/usr/bin/env bash
set -e

echo_url () {
    local addon_id=$1
    local upstream='https://addons.mozilla.org/firefox/downloads/latest'
    echo "${upstream}/${addon_id}/addon-${addon_id}-latest.xpi"
}

install () {
    local name=$1
    local addon_id=$2
    local url=$(echo_url $2)
    local tmp_file=$(mktemp "/tmp/${name}_firefox_addon.xpi_XXXXXXXX" --suffix=.xpi)
    echo ${name} ${url} ${tmp_file}
    wget -O ${tmp_file} ${url}
    firefox ${tmp_file}
}

set_user_preferences () {
    local settings=$1
    local profile_dir=$(find /home/daszek/.mozilla/firefox/ -maxdepth 1 -type d -name '*default*')
    local file="${profile_dir}/user.js"
    echo 'Useful info, type into url box: resource:///defaults/preferences/firefox.js'
    echo "Storing settings in ${file}"
    echo ${settings} > ${file} # restore sessions
}

set_user_preferences 'user_pref("browser.startup.page", 3);'

install 'ublock' '607454'
install 'disconnect' '464050'
