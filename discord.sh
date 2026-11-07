#!/bin/bash
# Поднимает tpws (если не запущен) и перезапускает Discord через прокси.
DIR="$(cd "$(dirname "$0")" && pwd)"
if ! { [ -f "$DIR/tpws.pid" ] && kill -0 "$(cat "$DIR/tpws.pid")" 2>/dev/null; }; then
  "$DIR/start.sh" "${1:-1}" || exit 1
fi
osascript -e 'quit app "Discord"' 2>/dev/null
pkill -x Discord 2>/dev/null
sleep 2
open -a Discord --args --proxy-server="socks5://127.0.0.1:1080"
echo "Discord запущен через zapret"
