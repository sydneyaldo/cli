#!/bin/bash

function install {
  # create service directory
  mkdir -p /srv/grocy

  # create yml(s)
  cat << EOF > /srv/grocy/grocy.yml
version: "2.1"
services:
  grocy:
    image: linuxserver/grocy
    container_name: grocy
    environment:
      - PUID=${PUID}
      - PGID=${PUID}
      - TZ=${TZ}
    volumes:
      - "/srv/grocy.sh:/root/.grocy"
    ports:
      - 9283:80
    restart: unless-stopped
EOF

  # create .env with default values
  cat << EOF > /srv/grocy/.env
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
  cat << EOF > /srv/grocy/autorun
grocy_autorun=true
if [ "$grocy_autorun" = true ]; then
  treehouses services grocy up
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
  echo "9283"
}

# add size (in MB)
function get_size {
  echo "55"
}

# add info
function get_info {
  echo "https://github.com/linuxserver/docker-grocy"
  echo
  echo "grocy is an enterprise resource planning system for your kitchen."
  echo "Cut down on food waste, manage your chores, keep track of your purchases,"
  echo "and what batteries need charging with this tool."
}

# add svg icon
function get_icon {
  cat <<EOF
    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN"
    "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
    <svg version="1.0" xmlns="http://www.w3.org/2000/svg"
    width="242.000000pt" height="93.000000pt" viewBox="0 0 242.000000 93.000000"
    preserveAspectRatio="xMidYMid meet">
    <metadata>
    Created by potrace 1.15, written by Peter Selinger 2001-2017
    </metadata>
    <g transform="translate(0.000000,93.000000) scale(0.100000,-0.100000)"
    fill="#0b024c" stroke="none">
    <path d="M165 905 c-52 -18 -109 -82 -132 -148 -14 -39 -18 -82 -18 -172 0
    -104 3 -127 23 -170 43 -94 114 -144 205 -145 59 0 112 21 156 63 l33 32 -7
    -75 c-10 -96 -17 -116 -57 -140 -43 -26 -130 -26 -233 0 -43 11 -80 20 -82 20
    -2 0 -3 -30 -1 -67 l3 -68 50 -13 c28 -8 100 -14 160 -15 121 -1 183 14 244
    60 36 28 81 112 81 155 0 54 6 58 90 58 l78 0 4 193 c3 180 4 194 25 223 20
    28 99 72 110 61 2 -3 -1 -24 -6 -48 -6 -24 -11 -79 -11 -121 0 -137 53 -233
    158 -285 50 -24 69 -28 147 -28 107 0 158 20 219 83 l40 41 23 -34 c13 -20 46
    -45 80 -62 51 -25 69 -28 153 -28 68 0 108 5 143 18 l47 19 0 74 0 74 -42 -21
    c-58 -30 -154 -37 -197 -15 -85 44 -98 250 -21 328 24 24 36 28 84 28 99 0 92
    9 200 -260 l97 -242 -23 -46 c-32 -65 -67 -87 -134 -87 l-54 0 0 -66 0 -67 45
    -6 c108 -17 215 34 269 128 20 33 296 754 296 771 0 3 -40 5 -89 5 l-90 0 -64
    -197 c-35 -109 -69 -214 -75 -233 -10 -34 -10 -34 -11 -7 -1 16 -31 120 -68
    232 l-66 202 -143 8 c-116 5 -154 4 -197 -9 -61 -18 -126 -61 -145 -98 l-14
    -25 -52 53 c-40 39 -67 56 -106 68 -87 26 -181 19 -272 -19 -14 -5 -18 -2 -18
    14 0 19 -6 21 -52 21 -64 0 -129 -30 -164 -76 -15 -19 -30 -34 -34 -34 -4 0
    -13 23 -20 50 l-12 50 -133 0 -133 0 -7 -40 -7 -40 -36 31 c-67 59 -150 75
    -237 44z m206 -141 c45 -23 62 -72 62 -180 1 -112 -18 -152 -79 -172 -125 -42
    -201 80 -163 260 21 96 97 135 180 92z m888 -10 c40 -33 54 -89 49 -184 -7
    -118 -41 -160 -131 -160 -87 0 -121 53 -121 185 0 135 34 185 125 185 36 0 55
    -6 78 -26z"/>
    </g>
    </svg>
EOF
}