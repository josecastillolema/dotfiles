#!/bin/sh
toolbox run pass sudo 2>/dev/null | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g; s/\x1b\][^\x1b]*\x1b\\//g'
