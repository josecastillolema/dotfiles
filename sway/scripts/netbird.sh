#!/bin/sh

STATE=$(netbird status 2>/dev/null | grep 'Management:' | sed 's/.*Management: //' | cut -d' ' -f1)

if [ "$STATE" = "Connected" ]; then
  netbird down
else
  netbird up
fi
