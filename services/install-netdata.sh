#!/bin/bash

function install {
  # create service directory
  mkdir -p /srv/netdata

  # create yml(s)
  {
    echo "version: '3'"
    echo "services:"
    echo "  netdata:"
    echo "    image: netdata/netdata"
    echo "    ports:"
    echo "      - 19999:19999"
    echo "    cap_add:"
    echo "      - SYS_PTRACE"
    echo "    security_opt:"
    echo "      - apparmor:unconfined"
    echo "    volumes:"
    echo "      - /etc/passwd:/host/etc/passwd:ro"
    echo "      - /etc/os-release:/host/etc/os-release:ro"
    echo "      - /etc/group:/host/etc/group:ro"
    echo "      - /proc:/host/proc:ro"
    echo "      - /sys:/host/sys:ro"
  } > /srv/netdata/netdata.yml

  # add autorun
  {
    echo "netdata_autorun=true"
    echo
    echo "if [ \"\$netdata_autorun\" = true ]; then"
    echo "  treehouses services netdata up"
    echo "fi"
    echo
    echo
  } > /srv/netdata/autorun
}

# environment var
function uses_env {
  echo false
}

# add supported arm(s)
function supported_arms {
  echo "v7l"
  echo "v6l"
}

# add port(s)
function get_ports {
  echo "19999"
}

# add size (in MB)
function get_size {
  echo "300"
}

# add info
function get_info {
  echo "https://github.com/netdata/netdata"
  echo
  echo "\"Netdata is distributed, real-time performance and health monitoring"
  echo "for systems and applications. It is a highly-optimized monitoring agent"
  echo "you install on all your systems and containers.\""
}

# add svg icon
function get_icon {
  cat <<EOF
<svg xmlns="http://www.w3.org/2000/svg" role="img" viewBox="-4.8 36.45 249.34 166.84">
  <defs/>
  <title>
    Netdata logo
  </title>
  <path d="M120.81 198.44h-8l-.06-30h7a15.54 15.54 0 0 1 15.53 15.52 14.52 14.52 0 0 1-14.47 14.48zm-6.32-1.65h6.32a12.87 12.87 0 0 0 12.85-12.85 13.89 13.89 0 0 0-13.88-13.87h-5.35zM0 168.39h2.32l19.07 27.69h.08v-27.69h1.86v30.18h-2.2L1.94 170.68h-.08v27.89H0zm41.34 0h20.28V170H43.19v12.09h17.33v1.6H43.19V197h18.64v1.6H41.34zM74.43 170v-1.61h23.12V170H86.9v28.57H85V170zm85.86-1.61h2l11.92 30.18h-2l-3.81-9.68H154l-3.85 9.68h-2zm7.56 18.9l-6.46-17.08h-.09l-6.72 17.08zM182.52 170v-1.61h23.12V170H195v28.57h-1.86V170zm43.53-1.61h2L240 198.57h-2l-3.8-9.68h-14.44l-3.85 9.68h-2zm7.57 18.9l-6.47-17.08h-.08l-6.72 17.08z"/>
  <path fill="#0f0" d="M133 131.46h-22.76l-46.63-90h66.18a46.65 46.65 0 0 1 46.6 46.6 43.45 43.45 0 0 1-43.39 43.4z" data-name="mask-2"/>
</svg>
EOF
}
