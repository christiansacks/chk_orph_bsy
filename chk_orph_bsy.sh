#!/usr/bin/env bash

WDIR="/mystic"

cd $WDIR

F=$(ps -ef|grep "mis poll"|grep -v grep >/dev/null; [ $? -gt 0 ] && echo "NOT RUNNING" || echo "RUNNING")
M=$(pidof mutil; [ $? -gt 0 ] && echo "NOT RUNNING" || echo "RUNNING")
B=$(find . -type f|grep .bsy|grep echomail|wc -l)

cat << EOF
Fidopoll pidof result: $F
   Mutil pidof result: $M
  Number of BSY files: $B
EOF

if [[ $B -gt 0 && ($F == "NOT RUNNING" && $M == "NOT RUNNING") ]]; then
  echo -e "\nClearing $B orphaned BSY files..."
  for F in $(find . -type f|grep .bsy|grep echomail); do
    echo "Removing: $F"; rm $F
  done
fi
