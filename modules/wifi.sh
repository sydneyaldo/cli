#!/bin/bash

function wifi {
  if [ -z "$1" ]; then
    echo "Error: name of the network missing"
    exit 1
  fi

  if [ "$#" -gt 2 ]; then
    wifi_enterprize "$1" "$2" "$3"
    echo "wifi" > /etc/network/mode
    exit 1
  fi
  wifinetwork="$1"
  wifipassword="$2"

  if [ -n "$wifipassword" ]
  then
    if [ ${#wifipassword} -lt 8 ]
    then
      echo "Error: password must have at least 8 characters"
      exit 1
    fi
  fi

  cp "$TEMPLATES/network/interfaces/modular" /etc/network/interfaces
  cp "$TEMPLATES/network/wlan0/default" /etc/network/interfaces.d/wlan0
  cp "$TEMPLATES/network/eth0/default" /etc/network/interfaces.d/eth0
  cp "$TEMPLATES/network/dhcpcd/modular" /etc/dhcpcd.conf
  cp "$TEMPLATES/network/dnsmasq/default" /etc/dnsmasq.conf
  cp "$TEMPLATES/rc.local/default" /etc/rc.local

  cp "$TEMPLATES/network/10-wpa_supplicant" /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant
  rm -rf /etc/udev/rules.d/90-wireless.rules

  {
    echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev"
    echo "update_config=1"
    wificountry="US"
    if [ -r /etc/rpi-wifi-country ];
    then
      wificountry=$(cat /etc/rpi-wifi-country)
    fi
    echo "country=$wificountry"
  } > /etc/wpa_supplicant/wpa_supplicant.conf

  if [ -z "$wifipassword" ];
  then
    {
      echo "network={"
      echo "  ssid=\"$wifinetwork\""
      echo "  key_mgmt=NONE"
      echo "}"
    } >> /etc/wpa_supplicant/wpa_supplicant.conf
    restart_wifi >/dev/null 2>/dev/null
    echo "open wifi network"
  else
    wpa_passphrase "$wifinetwork" "$wifipassword" >> /etc/wpa_supplicant/wpa_supplicant.conf
    restart_wifi >/dev/null 2>/dev/null
    echo "password network"
  fi

  echo "wifi" > /etc/network/mode
}

function wifi_enterprize {
   {   
   echo "network={"
   echo "ssid=\"$1\""
   echo "scan_ssid=1"
   echo "mode=0"
   echo "key_mgmt=WPA-EAP"
   echo "pairwise=CCMP TKIP"
   echo "identity=\"$2\""
   echo "password=\"$3\""
   echo "phase1=\"peaplabel=0\""
   echo "phase2=\"auth=MSCHAPV2\""
   } > /etc/wpa_supplicant/wpa_supplicant.conf

   {
   echo "iface lo inet loopback"
   echo "iface eth0 inet dhcp"
   echo ""
   echo "allow-hotplug wlan0"
   echo ""
   echo "iface wlan0 inet dhcp"
   echo "  pre-up wpa_supplicant -B -Dwext -i wlan0 -c/etc/wpa_supplicant/wpa_supplicant.conf"
   echo "  post-down killall -q wpa_supplicant"
   } > /etc/network/interfaces
   restart_wifi >/dev/null 2>/dev/null
}

function wifi_help {
  echo ""
  echo "Usage: $(basename "$0") wifi <ESSID> [password] | $(basename "$0") wifi enterperize <username> <password> "
  echo ""
  echo "Connects to a wifi network"
  echo ""
  echo "Example:"
  echo "  $(basename "$0") wifi home homewifipassword"
  echo "      Connects to a wifi network named 'home' with password 'homewifipassword'."
  echo ""
  echo "  $(basename "$0") wifi yourwifiname"
  echo "      Connects to an open wifi network named 'yourwifiname'."
  echo ""
  echo "  $(basename "$0") wifi enterprize schoolwifi user1 pass123"
  echo "      Connects to a public wifi with username called user1 and password pass123"
  echo ""
}

