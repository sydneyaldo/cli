#!/bin/bash

function install {
  # create service directory
  mkdir -p /srv/calibre-web

  # create yml(s)
  cat << EOF > /srv/calibre-web/calibre-web.yml
version: "2.1"
services:
  calibre-web:
    image: linuxserver/calibre-web
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
      - DOCKER_MODS=linuxserver/calibre-web:calibre
    volumes:
      - "/srv/calibre-web.sh:/root/.calibre-web"
      - "/srv/calibre-web.sh:/books"
    ports:
      - 8090:80
    restart: unless-stopped
EOF

  # create .env with default values
  cat << EOF > /srv/calibre-web/.env
PUID=1000
PGID=1000
TZ=Europe/London
PASSWORD=PASSWORD
DB_TYPE=sqlite
DB_NAME=DB_NAME
DB_HOSTNAME=DB_HOSTNAME
DB_USERNAME=DB_USERNAME
DB_PASSWORD=DB_PASSWORD
EOF

  # add autorun
  cat << EOF > /srv/calibre-web/autorun
calibre-web_autorun=true

if [ "$calibre-web_autorun" = true ]; then
  treehouses services calibre-web up
fi


EOF
}

# environment var
function uses_env {
  echo true
}

# add supported arm(s)
function supported_arms {
  echo "v7l"
}

# add port(s)
function get_ports {
  echo "8090"
}

# add size (in MB)
function get_size {
  echo "60"
}

# add info
function get_info {
  echo "https://github.com/linuxserver/docker-calibre-web"
  echo
  echo "Calibre-web is a web app providing a clean interface for "
  echo "browsing, reading and downloading eBooks using an existing Calibre database." 
  echo "It is also possible to integrate google drive and edit metadata and"
  echo "your calibre library through the app itself."
}

# add svg icon
function get_icon {
  cat <<EOF
    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN"
    "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
    <svg version="1.0" xmlns="http://www.w3.org/2000/svg"
    width="256.000000pt" height="256.000000pt" viewBox="0 0 256.000000 256.000000"
    preserveAspectRatio="xMidYMid meet">
    <metadata>
    Created by potrace 1.16, written by Peter Selinger 2001-2019
    </metadata>
    <g transform="translate(0.000000,256.000000) scale(0.100000,-0.100000)"
    fill="#000000" stroke="none">
    <path d="M1035 2540 c-260 -52 -473 -166 -661 -354 -191 -191 -314 -425 -359
    -680 -20 -115 -20 -337 0 -452 45 -255 168 -489 359 -680 250 -250 551 -374
    906 -374 355 0 656 124 906 374 191 191 314 425 359 680 20 115 20 337 0 452
    -45 255 -168 489 -359 680 -191 190 -404 304 -668 355 -130 25 -356 25 -483
    -1z m789 -516 c13 -12 16 -40 16 -140 l0 -124 28 0 c15 0 33 -5 40 -12 17 -17
    17 -1199 0 -1216 -16 -16 -1064 -17 -1123 -1 -52 15 -119 82 -134 134 -16 57
    -15 1193 1 1247 13 45 64 98 110 114 24 9 173 13 540 13 448 1 508 -1 522 -15z"/>
    </g>
    </svg>
EOF
}
