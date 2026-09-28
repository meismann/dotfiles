#!/usr/bin/env bash

TARGET="192.168.0.1"
IFACE="enp0s31f6"
PING_COUNT=2
PING_TIMEOUT=2

# Prüfe mit ping (unterdrücke Ausgabe)
if ping -c "$PING_COUNT" -W "$PING_TIMEOUT" "$TARGET" >/dev/null 2>&1; then
  exit 0
fi

# Falls ping fehlschlägt: prüfe Interface-Status mit ip link
if ip link show dev "$IFACE" >/dev/null 2>&1; then
  # Interface vorhanden — ist es UP?
  state=$(ip -o link show dev "$IFACE" | awk '{print $9}')
  if [ "$state" = "UP" ]; then
    # Interface ist UP, aber Ziel nicht erreichbar -> evtl. ARP/route Problem
    # versuche kurz, Interface neu zu starten
    if command -v sudo >/dev/null 2>&1; then
      sudo ip link set dev "$IFACE" down
      sleep 1
      sudo ip link set dev "$IFACE" up
    else
      ip link set dev "$IFACE" down
      sleep 1
      ip link set dev "$IFACE" up
    fi
  else
    # Interface ist DOWN -> bringe es hoch
    if command -v sudo >/dev/null 2>&1; then
      sudo ifconfig "$IFACE" up || sudo ip link set dev "$IFACE" up
    else
      ifconfig "$IFACE" up || ip link set dev "$IFACE" up
    fi
  fi
else
  # Interface existiert nicht
  echo "Interface $IFACE nicht gefunden" >&2
  exit 2
fi

# Optional: nach dem Hochfahren nochmal prüfen (kurze Wartezeit)
sleep 1
if ping -c "$PING_COUNT" -W "$PING_TIMEOUT" "$TARGET" >/dev/null 2>&1; then
  exit 0
else
  echo "Ziel $TARGET nach Ifup weiterhin nicht erreichbar" >&2
  exit 1
fi
