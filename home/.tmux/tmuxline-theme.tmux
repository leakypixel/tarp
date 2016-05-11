# This tmux statusbar config was created by tmuxline.vim
# on Wed, 11 May 2016

set -g status-left-attr "none"
set -g status-utf8 on
set -g status-fg colour12
set -g status-interval 2
set -g status-left ''
set -g status-bg "colour235"
set -g status-justify "left"
set-option -g status-position bottom

set -g message-command-fg "colour254"
set -g status "on"
set -g message-bg "colour237"
set -g message-fg "colour254"
set -g message-command-bg "colour237"
set -g status-attr "none"
set -g status-utf8 "on"
set -g pane-active-border-bg "colour235"
set -g pane-border-bg "colour235"
set -g pane-active-border-fg "colour235"
set -g pane-border-fg "colour235"
setw -g window-status-fg "colour173"
setw -g window-status-attr "none"
setw -g window-status-activity-bg "colour235"
setw -g window-status-activity-attr "none"
setw -g window-status-activity-fg "colour143"
setw -g window-status-separator ""
setw -g window-status-bg "colour235"

set -g status-right "#[fg=colour237,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour254,bg=colour237] %Y-%m-%d  %H:%M #[fg=colour143,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour235,bg=colour143] #h "

setw -g window-status-format "#[fg=colour173,bg=colour235] #I:#[fg=colour173,bg=colour235] #W "
setw -g window-status-current-format "#[fg=colour235,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour254,bg=colour237] #I #[fg=colour254,bg=colour237] #W #[fg=colour237,bg=colour235,nobold,nounderscore,noitalics]"
