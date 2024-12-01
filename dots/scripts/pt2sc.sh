#!/usr/bin/env fish
pkill --signal SIGINT wf-recorder
curl -F "file=@/tmp/testing.gif" 0x0.st | wl-copy
