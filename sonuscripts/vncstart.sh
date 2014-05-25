#!/bin/bash

ssh -C -f -L 5900:localhost:5900 sonu@192.168.1.7 \
        x11vnc -safer -localhost -nopw -once -noxdamage -display :0 \
        && sleep 5 \
        && vncviewer localhost:0
