#!/usr/bin/env bash
sleep 5;
conky -c $HOME/.dashboard/.conkystatsrc &
conky -c $HOME/.dashboard/.conkytimerc &
stalonetray -c $HOME/.dashboard/.stalonetrayrc &
