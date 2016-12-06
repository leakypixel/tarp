#!/usr/bin/env bash
sleep 5;
feh --bg-scale $HOME/.dashboard/wallpaper.jpg &
conky -c $HOME/.dashboard/.conkystatsrc &
conky -c $HOME/.dashboard/.conkytimerc &
stalonetray -c $HOME/.dashboard/.stalonetrayrc &
