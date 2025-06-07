ls /run/current-system/sw/share/applications/*.desktop | sed 's/^.*\///g ; s/\.desktop//g ; s/^.*\.//g ; s/-/ /g ; s/^\(.\)/\u\1/g'
