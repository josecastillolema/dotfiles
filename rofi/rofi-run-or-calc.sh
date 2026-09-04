#!/bin/bash
input="$*"

if echo "$input" | grep -qE '[\+\*/\^%]' && echo "$input" | grep -qE '^[0-9 \+\-\*/\.\(\)%\^,a-zA-Z_]+$'; then
    result=$(python3 -c "
import sys, re
from math import *
expr = sys.argv[1].replace('^', '**')
ns = {'__builtins__': {}, 'sin': sin, 'cos': cos, 'tan': tan,
      'asin': asin, 'acos': acos, 'atan': atan, 'sqrt': sqrt,
      'log': log, 'log2': log2, 'log10': log10, 'exp': exp,
      'pi': pi, 'e': e, 'abs': abs, 'pow': pow, 'round': round,
      'floor': floor, 'ceil': ceil, 'factorial': factorial}
r = eval(expr, ns)
if isinstance(r, float) and r == int(r) and abs(r) < 1e15:
    print(int(r))
else:
    print(r)
" "$input" 2>/dev/null)
    if [ -n "$result" ]; then
        selected=$(echo "$result" | rofi -dmenu -p "calc:")
        if [ -n "$selected" ]; then
            echo -n "$selected" | wl-copy
        fi
        exit 0
    fi
fi

exec sh -c "$input"
