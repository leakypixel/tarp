#!/usr/bin/env bash
touch /home/craigf/great_success
conky -c $HOME/.dashboard/.conkystatsrc &
conky -c $HOME/.dashboard/.conkytimerc &
stalonetray -c $HOME/.dashboard/.stalonetrayrc &
