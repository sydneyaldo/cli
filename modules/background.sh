#!/bin/bash
function background () {
  checkrpi
  checkargn $# 1
  checkroot
  url=$1
  img="${url##*/}"
  imgloc="/home/pi/$img"
  ext=${img: -4}
  if [ $ext == ".png" ] || [ $ext == ".jpg" ] || [ $ext == "jpeg" ] || [ $ext == ".gif" ];
  then
#    sudo su - pi -c 'wget '"$url"' && env | grep 'DISPLAY' && export DISPLAY=:0.0 && pcmanfm --set-wallpaper '"$img"
    sudo -u pi sh -c "wget $url -O /home/pi/$img && export DISPLAY=:0.0 && pcmanfm --set-wallpaper /home/pi/$img"
    #echo "background changed to $img"
    exit 1
  fi
  background_help
}

function background_help {
  echo
  echo "  Usage: $BASENAME background <url>"
  echo
  echo "  Changes the background of monitor to image from URL"
  echo "  Make sure the file you are using has extension .png, .jpg, .jpeg, or .gif"
  echo
  echo "  Example:"
  echo "    $BASENAME background https://hewgill.com/~greg/definitive-metal-family-tree.png"
  echo "    background changed to definitive-metal-family-tree.png"
  echo
}
