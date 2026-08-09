#!/bin/sh

STATE=$(netbird status 2>/dev/null | grep -oP '(?<=Management: )\S+')

if [ "$STATE" = "Connected" ]; then
  netbird down
else
  netbird up
fi
