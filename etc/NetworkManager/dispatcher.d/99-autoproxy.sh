#!/bin/sh -e

if [ -z "$1" ]; then
    echo "$0: called with no interface" 1>&2
    exit 1
fi

if [ "$1" != "wlan0" ]; then
    exit 1
fi

INTERFACE=$1
STATUS=$2
ACCESSPOINT="`nm-tool | grep \* | sed 's/.*Infra, \([^,]*\).*/\1/' |
    tail -n 1`"
export DBUS_SESSION=$(grep -v "^#" \
    /home/tato/.dbus/session-bus/`cat /var/lib/dbus/machine-id`-0)

# Universidad
if [ "$STATUS" = "up" ] && [ "$ACCESSPOINT" = "00:26:5A:87:51:8D" ]; then
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/http_proxy/use_http_proxy --type boolean true
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/http_proxy/use_same_proxy --type boolean true
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/http_proxy/host --type string 'proxy.udb.edu.sv'
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/http_proxy/port --type integer 8080
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/mode --type string manual
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/secure_host --type string 'proxy.udb.edu.sv'
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/old_secure_host --type string 'proxy.udb.edu.sv'
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/secure_port --type integer 8080
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/old_secure_port --type integer 8080
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/ftp_host --type string 'proxy.udb.edu.sv'
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/old_ftp_host --type string 'proxy.udb.edu.sv'
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/ftp_port --type integer 8080
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/old_ftp_port --type integer 8080
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/socks_host --type string 'proxy.udb.edu.sv'
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/old_socks_host --type string 'proxy.udb.edu.sv'
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/socks_port --type integer 8080
    sudo -u tato $DBUS_SESSION /usr/bin/gconftool-2 --set /system/proxy/old_socks_port --type integer 8080
fi
