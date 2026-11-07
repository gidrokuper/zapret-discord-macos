#!/bin/bash
# Запускает tpws как локальный SOCKS5-прокси 127.0.0.1:1080 (sudo не нужен).
# Обход DPI применяется только к доменам из discord.txt.
# Стратегию можно сменить: ./start.sh 2  (варианты 1..4)
DIR="$(cd "$(dirname "$0")" && pwd)"
PORT=1080
PIDFILE="$DIR/tpws.pid"
xattr -d com.apple.quarantine "$DIR/tpws" 2>/dev/null

case "${1:-1}" in
  1) STRAT="--split-pos=1,midsld --disorder --tlsrec=sniext" ;;
  2) STRAT="--split-pos=1,midsld --disorder" ;;
  3) STRAT="--split-pos=1,sniext+1 --disorder --tlsrec=sniext" ;;
  4) STRAT="--split-pos=2 --tlsrec=sniext" ;;
  *) echo "Стратегия 1..4"; exit 1 ;;
esac

[ -f "$PIDFILE" ] && kill "$(cat "$PIDFILE")" 2>/dev/null && sleep 0.5

"$DIR/tpws" --socks --bind-addr=127.0.0.1 --port=$PORT \
  --daemon --pidfile="$PIDFILE" \
  --hostlist="$DIR/discord.txt" $STRAT \
  && echo "tpws запущен: socks5://127.0.0.1:$PORT (стратегия ${1:-1})"
