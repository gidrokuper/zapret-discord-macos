#!/bin/bash
# Сравнивает доступ к Discord напрямую и через tpws.
for h in discord.com gateway.discord.gg cdn.discordapp.com; do
  d=$(curl -s -o /dev/null -m 8 -w '%{http_code}' "https://$h/" || true)
  p=$(curl -s -o /dev/null -m 8 -w '%{http_code}' --socks5-hostname 127.0.0.1:1080 "https://$h/" || true)
  printf '%-24s напрямую: %-4s через zapret: %s\n' "$h" "${d:-000}" "${p:-000}"
done
