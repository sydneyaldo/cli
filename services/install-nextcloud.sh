#!/bin/bash

function install {
  # create service directory
  mkdir -p /srv/nextcloud

  # create yml(s)
  {
    echo "services:"
    echo "  nextcloud:"
    echo "    image: nextcloud"
    echo "    ports:"
    echo "      - \"8081:80\""
    echo "    volumes:"
    echo "      - \"/srv/nextcloud/data:/var/www/html/data\""
    echo "version: \"2\""
  } > /srv/nextcloud/nextcloud.yml

  # add autorun
  {
    echo "nextcloud_autorun=true"
    echo
    echo "if [ \"\$nextcloud_autorun\" = true ]; then"
    echo "  treehouses services nextcloud up"
    echo "fi"
    echo
    echo
  } > /srv/nextcloud/autorun
}

# environment var
function uses_env {
  echo false
}

# add supported arm(s)
function supported_arms {
  echo "v7l"
}

# add port(s)
function get_ports {
  echo "8081"
}

# add size (in MB)
function get_size {
  echo "900"
}

# add info
function get_info {
  echo "https://github.com/nextcloud"
  echo
  echo "\"A safe home for all your data. Access & share your files, calendars,"
  echo "contacts, mail & more from any device, on your terms.\""
}

# add svg icon
function get_icon {
  cat <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://creativecommons.org/ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape" version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 133.89203 94.627347" enable-background="new 0 0 196.6 72" xml:space="preserve" inkscape:version="0.91 r13725" sodipodi:docname="nextcloud-logo-white-transparent.svg" width="133.89201" height="94.62735" inkscape:export-filename="nextcloud-logo-white-transparent.png" inkscape:export-xdpi="300.09631" inkscape:export-ydpi="300.09631">
  <metadata id="metadata20">
    <rdf:RDF>
      <cc:Work rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <defs id="defs18" />
  <sodipodi:namedview pagecolor="#ffffff" bordercolor="#666666" borderopacity="1" objecttolerance="10" gridtolerance="10" guidetolerance="10" inkscape:pageopacity="0" inkscape:pageshadow="2" inkscape:window-width="2560" inkscape:window-height="1359" id="namedview16" showgrid="false" inkscape:zoom="4" inkscape:cx="43.021274" inkscape:cy="53.386932" inkscape:current-layer="Layer_1" fit-margin-top="10" fit-margin-left="10" fit-margin-right="10" fit-margin-bottom="10" inkscape:window-x="0" inkscape:window-y="240" inkscape:window-maximized="1" units="px" inkscape:snap-bbox="true" inkscape:bbox-paths="true" inkscape:bbox-nodes="true" inkscape:snap-bbox-edge-midpoints="true" inkscape:snap-bbox-midpoints="true" inkscape:snap-page="true" />
  <path style="color:#000000;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:medium;line-height:normal;font-family:sans-serif;text-indent:0;text-align:start;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#000000;letter-spacing:normal;word-spacing:normal;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;baseline-shift:baseline;text-anchor:start;white-space:normal;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#0082c9;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:5.56589985;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" d="m 67.032801,9.9999701 c -11.80525,0 -21.81118,8.0031799 -24.91235,18.8465899 -2.69524,-5.75151 -8.53592,-9.78093 -15.26337,-9.78093 -9.25183,0 -16.85708,7.60525 -16.85708,16.85708 0,9.25182 7.60525,16.86054 16.85708,16.86054 6.72745,0 12.56813,-4.03188 15.26337,-9.78439 3.10117,10.84422 13.1071,18.85006 24.91235,18.85006 11.71795,0 21.67286,-7.8851 24.85334,-18.60701 2.74505,5.62192 8.513439,9.54134 15.145329,9.54134 9.25183,0 16.86055,-7.60872 16.86055,-16.86054 0,-9.25183 -7.60872,-16.85708 -16.86055,-16.85708 -6.63189,0 -12.400279,3.91696 -15.145329,9.53788 C 88.705661,17.88243 78.750751,9.9999701 67.032801,9.9999701 Z m 0,9.8954999 c 8.91163,0 16.03073,7.11564 16.03073,16.02724 0,8.9116 -7.1191,16.03071 -16.03073,16.03071 -8.91158,0 -16.02722,-7.11911 -16.02722,-16.03071 0,-8.9116 7.11564,-16.02724 16.02722,-16.02724 z m -40.17572,9.06567 c 3.90437,0 6.96504,3.05718 6.96504,6.96157 0,3.90438 -3.06067,6.96504 -6.96504,6.96504 -3.90439,0 -6.96158,-3.06066 -6.96158,-6.96504 0,-3.90439 3.05719,-6.96157 6.96158,-6.96157 z m 80.174389,0 c 3.9044,0 6.96504,3.05718 6.96504,6.96157 0,3.90438 -3.06066,6.96504 -6.96504,6.96504 -3.90437,0 -6.96156,-3.06066 -6.96156,-6.96504 0,-3.90439 3.05721,-6.96157 6.96156,-6.96157 z" id="XMLID_107_" inkscape:connector-curvature="0" />
  <g id="g4571" transform="matrix(0.47038519,0,0,0.47038519,21.389201,50.75959)" style="opacity:1;fill:#0082c9;fill-opacity:1">
    <path id="XMLID_121_" d="m 37.669669,48.9 c 5.9,0 9.2,4.2 9.2,10.5 0,0.6 -0.5,1.1 -1.1,1.1 l -15.9,0 c 0.1,5.6 4,8.8 8.5,8.8 2.8,0 4.8,-1.2 5.8,-2 0.6,-0.4 1.1,-0.3 1.4,0.3 l 0.3,0.5 c 0.3,0.5 0.2,1 -0.3,1.4 -1.2,0.9 -3.8,2.4 -7.3,2.4 -6.5,0 -11.5,-4.7 -11.5,-11.5 0.1,-7.2 4.9,-11.5 10.9,-11.5 z m 6.1,9.4 c -0.2,-4.6 -3,-6.9 -6.2,-6.9 -3.7,0 -6.9,2.4 -7.6,6.9 l 13.8,0 z" inkscape:connector-curvature="0" style="fill:#0082c9;fill-opacity:1" />
    <path id="XMLID_119_" d="m 76.9,52.1 0,-2.5 0,-5.2 c 0,-0.7 0.4,-1.1 1.1,-1.1 l 0.8,0 c 0.7,0 1,0.4 1,1.1 l 0,5.2 4.5,0 c 0.7,0 1.1,0.4 1.1,1.1 l 0,0.3 c 0,0.7 -0.4,1 -1.1,1 l -4.5,0 0,11 c 0,5.1 3.1,5.7 4.8,5.8 0.9,0.1 1.2,0.3 1.2,1.1 l 0,0.6 c 0,0.7 -0.3,1 -1.2,1 -4.8,0 -7.7,-2.9 -7.7,-8.1 l 0,-11.3 z" inkscape:connector-curvature="0" style="fill:#0082c9;fill-opacity:1" />
    <path id="XMLID_117_" d="m 99.8,48.9 c 3.8,0 6.2,1.6 7.3,2.5 0.5,0.4 0.6,0.9 0.1,1.5 l -0.3,0.5 c -0.4,0.6 -0.9,0.6 -1.5,0.2 -1,-0.7 -2.9,-2 -5.5,-2 -4.8,0 -8.6,3.6 -8.6,8.9 0,5.2 3.8,8.8 8.6,8.8 3.1,0 5.2,-1.4 6.2,-2.3 0.6,-0.4 1,-0.3 1.4,0.3 l 0.3,0.4 c 0.3,0.6 0.2,1 -0.3,1.5 -1.1,0.9 -3.8,2.8 -7.8,2.8 -6.5,0 -11.5,-4.7 -11.5,-11.5 0.1,-6.8 5.1,-11.6 11.6,-11.6 z" inkscape:connector-curvature="0" style="fill:#0082c9;fill-opacity:1" />
    <path id="XMLID_115_" d="m 113.1,41.8 c 0,-0.7 -0.4,-1.1 0.3,-1.1 l 0.8,0 c 0.7,0 1.8,0.4 1.8,1.1 l 0,23.9 c 0,2.8 1.3,3.1 2.3,3.2 0.5,0 0.9,0.3 0.9,1 l 0,0.7 c 0,0.7 -0.3,1.1 -1.1,1.1 -1.8,0 -5,-0.6 -5,-5.4 l 0,-24.5 z" inkscape:connector-curvature="0" style="fill:#0082c9;fill-opacity:1" />
    <path id="XMLID_112_" d="m 133.6,48.9 c 6.4,0 11.6,4.9 11.6,11.4 0,6.6 -5.2,11.6 -11.6,11.6 -6.4,0 -11.6,-5 -11.6,-11.6 0,-6.5 5.2,-11.4 11.6,-11.4 z m 0,20.4 c 4.7,0 8.5,-3.8 8.5,-9 0,-5 -3.8,-8.7 -8.5,-8.7 -4.7,0 -8.6,3.8 -8.6,8.7 0.1,5.1 3.9,9 8.6,9 z" inkscape:connector-curvature="0" style="fill:#0082c9;fill-opacity:1" />
    <path id="XMLID_109_" d="m 183.5,48.9 c 5.3,0 7.2,4.4 7.2,4.4 l 0.1,0 c 0,0 -0.1,-0.7 -0.1,-1.7 l 0,-9.9 c 0,-0.7 -0.3,-1.1 0.4,-1.1 l 0.8,0 c 0.7,0 1.8,0.4 1.8,1.1 l 0,28.5 c 0,0.7 -0.3,1.1 -1,1.1 l -0.7,0 c -0.7,0 -1.1,-0.3 -1.1,-1 l 0,-1.7 c 0,-0.8 0.2,-1.4 0.2,-1.4 l -0.1,0 c 0,0 -1.9,4.6 -7.6,4.6 -5.9,0 -9.6,-4.7 -9.6,-11.5 -0.2,-6.8 3.9,-11.4 9.7,-11.4 z m 0.1,20.4 c 3.7,0 7.1,-2.6 7.1,-8.9 0,-4.5 -2.3,-8.8 -7,-8.8 -3.9,0 -7.1,3.2 -7.1,8.8 0.1,5.4 2.9,8.9 7,8.9 z" inkscape:connector-curvature="0" style="fill:#0082c9;fill-opacity:1" />
    <path sodipodi:nodetypes="ssssssssssscccccsss" style="fill:#0082c9;fill-opacity:1" inkscape:connector-curvature="0" d="m 1,71.4 0.8,0 c 0.7,0 1.1,-0.4 1.1,-1.1 l 0,-21.472335 C 2.9,45.427665 6.6,43 10.8,43 c 4.2,0 7.9,2.427665 7.9,5.827665 L 18.7,70.3 c 0,0.7 0.4,1.1 1.1,1.1 l 0.8,0 c 0.7,0 1,-0.4 1,-1.1 l 0,-21.6 c 0,-5.7 -5.7,-8.5 -10.9,-8.5 l 0,0 0,0 0,0 0,0 C 5.7,40.2 0,43 0,48.7 l 0,21.6 c 0,0.7 0.3,1.1 1,1.1 z" id="XMLID_103_" />
    <path style="fill:#0082c9;fill-opacity:1" inkscape:connector-curvature="0" d="m 167.9,49.4 -0.8,0 c -0.7,0 -1.1,0.4 -1.1,1.1 l 0,12.1 c 0,3.4 -2.2,6.5 -6.5,6.5 -4.2,0 -6.5,-3.1 -6.5,-6.5 l 0,-12.1 c 0,-0.7 -0.4,-1.1 -1.1,-1.1 l -0.8,0 c -0.7,0 -1,0.4 -1,1.1 l 0,12.9 c 0,5.7 4.2,8.5 9.4,8.5 l 0,0 c 0,0 0,0 0,0 0,0 0,0 0,0 l 0,0 c 5.2,0 9.4,-2.8 9.4,-8.5 l 0,-12.9 c 0.1,-0.7 -0.3,-1.1 -1,-1.1 z" id="XMLID_102_" />
    <path inkscape:connector-curvature="0" id="path4165-9" d="m 68.908203,49.235938 c -0.244942,0.0391 -0.480102,0.202589 -0.705078,0.470703 l -4.046875,4.824218 -3.029297,3.609375 -4.585937,-5.466796 -2.488282,-2.966797 c -0.224975,-0.268116 -0.479748,-0.414718 -0.74414,-0.4375 -0.264393,-0.02278 -0.538524,0.07775 -0.806641,0.302734 l -0.613281,0.513672 c -0.536232,0.449952 -0.508545,0.948144 -0.05859,1.484375 l 4.048828,4.824219 3.357422,4 -4.916016,5.857421 c -0.0037,0.0044 -0.0061,0.0093 -0.0098,0.01367 l -2.480469,2.955078 c -0.449952,0.536232 -0.399531,1.100832 0.136719,1.550782 l 0.613281,0.511718 c 0.536231,0.449951 1.022704,0.33701 1.472656,-0.199218 l 4.046875,-4.824219 3.029297,-3.609375 4.585938,5.466797 c 0.003,0.0036 0.0067,0.0062 0.0098,0.0098 l 2.480469,2.957032 c 0.44995,0.536231 1.012595,0.584735 1.548828,0.134765 l 0.613282,-0.513671 c 0.536231,-0.449952 0.508544,-0.948144 0.05859,-1.484376 l -4.048828,-4.824218 -3.357422,-4 4.916016,-5.857422 c 0.0037,-0.0044 0.0061,-0.0093 0.0098,-0.01367 l 2.480469,-2.955078 c 0.449952,-0.53623 0.399532,-1.10083 -0.136719,-1.550781 l -0.613281,-0.513672 c -0.268115,-0.224976 -0.522636,-0.308636 -0.767578,-0.269531 z" style="fill:#0082c9;fill-opacity:1" />
  </g>
</svg>
EOF
}
