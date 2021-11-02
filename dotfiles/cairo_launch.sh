#!/bin/bash

# Terminate already running instances

killall -q cairo-dock

# Launch Cairo-dock and gimme a log

cairo-dock -o 2>&1 | tee -a /tmp/cairo.log & disown

