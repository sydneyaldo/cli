#!/bin/bash
  
function magazine() {
  checkargn $# 2
  checkinternet
  magtype="$1"
  req="$2"
  magnum="93"
  if [ -z "$magtype" ]; then
    echo "ERROR: no magazine type given"
    exit 1
  elif [ "$magtype" != "magpi" ]; then
    echo "Please specify a valid magazine type, these include: magpi"
    exit 1
  fi
  if [ "$magtype" = "magpi" ]; then
    if [ "$req" != "all" ]; then
      if [ "$req" != "latest" ] && [ "$req" != "" ]; then
        re='^[0-9]+$'
        if ! [[ $req =~ $re ]] || [[ $req -lt 1 ]] || [[ $req -gt 93 ]]; then
          echo "ERROR: Please enter a valid magazine number"
          echo "       This can be any issue ranging from 1 to 93" 
          exit 1
        fi
        magnum=$req
      fi
      if [ ! -d "$magtype" ]; then
        mkdir $magtype
      fi
      cd $magtype || return
      if [ -f "MagPi$magnum.pdf" ]; then
        echo "MagPi$magnum.pdf already exists, exiting..."
        cd ..
        exit 1
      fi
      echo "Fetching MagPi$magnum.pdf..."
      wget "https://magpi.raspberrypi.org/issues/$magnum/pdf"
      mv ./pdf ./pdf.txt
      url="$(sed -n '10p' pdf.txt)"
      rm ./pdf.txt
      url=${url:44}
      quoteloc="${url%%\"*}"
      ind=${#quoteloc}
      url=${url:0:$ind}
      wget -bqc -O "MagPi$magnum.pdf" $url
      echo "Finished downloading MagPi$magnum.pdf"
      echo "Issue $magnum is saved in the $magtype directory"
      cd ..
    else
      if [ ! -d "$magtype" ]; then
        mkdir $magtype
      fi
      cd $magtype || return
      echo "Fetching all Magpi magazines..."
      for i in {1..93}
      do
        if [ -f "MagPi$i.pdf" ]; then
          continue
        fi
        wget "https://magpi.raspberrypi.org/issues/$i/pdf"
        mv ./pdf ./pdf.txt
        url="$(sed -n '10p' pdf.txt)"
        rm ./pdf.txt
        url=${url:44}
        quoteloc="${url%%\"*}"
        ind=${#quoteloc}
        url=${url:0:$ind}
        wget -bqc -O "MagPi$i.pdf" $url
      done
      echo "All current issues of magpi are saved in the $magtype directory"
      cd ..
    fi
  fi
}

function magazine_help {
  echo
  echo "  Usage:"
  echo
  echo "    $BASENAME magazine <magpi> [all|latest|number]"
  echo "        This downloads the specified issue of a magazine as a pdf with filename MagPi#.pdf"
  echo
  echo "  Examples:"
  echo
  echo "    $BASENAME magazine magpi"
  echo "        This will download the latest issue of magpi."
  echo
  echo "    $BASENAME magazine magpi all"
  echo "        This will download all the currently present issues of magpi."
  echo
  echo "    $BASENAME magazine magpi latest"
  echo "        This will download the latest issue of magpi."
  echo
  echo "    $BASENAME magazine magpi number"
  echo "        This will download issue [number] of magpi."
  echo
}
