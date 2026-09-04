#!/bin/bash

case "$ROFI_RETV" in
    0)
        echo -en "\0prompt\x1fcalc\n"
        ;;
    1)
        value="${ROFI_INFO:-$1}"
        setsid sh -c "echo -n '$value' | wl-copy" &
        exit 0
        ;;
    2)
        echo -en "\0prompt\x1fcalc\n"
        result=$(python3 -c "
import sys, re
from math import *
expr = sys.argv[1]
if re.match(r'^[\d\s\+\-\*/\.\(\)%\^,a-zA-Z_]+$', expr):
    expr = expr.replace('^', '**')
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
" "$1" 2>/dev/null)
        if [ -n "$result" ]; then
            echo -en "$result\0icon\x1fcalculator\x1finfo\x1f$result\n"
        fi
        ;;
esac
exit 0
