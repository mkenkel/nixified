#!/usr/bin/env fish
notify-send -a "GIF Recording" "Screen capture started! To end for upload, hit ALT+P to end the recording."
wf-recorder -g $(slurp) -F fps=30 -c gif -f /tmp/testing.gif -y
