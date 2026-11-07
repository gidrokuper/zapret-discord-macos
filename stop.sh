#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$DIR/tpws.pid" ]; then kill "$(cat "$DIR/tpws.pid")" 2>/dev/null; rm -f "$DIR/tpws.pid"; fi
pkill -f "$DIR/tpws" 2>/dev/null
echo "tpws остановлен"
