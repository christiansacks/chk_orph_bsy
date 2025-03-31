#!/usr/bin/env bash

WDIR="/mystic"; cd $WDIR

F=$(ps -ef|grep "[m]is poll" >/dev/null; [ $? -gt 0 ] && echo "NOT RUNNING" || echo "RUNNING")
M=$(pidof mutil; [ $? -gt 0 ] && echo "NOT RUNNING" || echo "RUNNING")
B=$(find -iname '*.bsy'|grep -c echomail)

cat << EOF
Fidopoll pidof result: $F
   Mutil pidof result: $M
  Number of BSY files: $B
EOF

if [[ $B -gt 0 && ($F == "NOT RUNNING" && $M == "NOT RUNNING") ]]; then
  echo -e "\nClearing $B orphaned BSY files..."
  for F in $(find -iname '*.bsy'|grep echomail); do
    echo "Removing: $F"; rm $F
  done
fi
