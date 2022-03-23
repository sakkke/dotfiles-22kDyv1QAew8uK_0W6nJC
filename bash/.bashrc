#
# ~/.bashrc
#

# If not running interactively, don't do anything
if [[ ! $- =~ i ]]; then
  return
fi

if ! pidof -q sway; then
  exec sway
elif [[ -z $TMUX ]]; then
  exec tmux
elif [[ -z $RANGER_LEVEL ]]; then
  exec ranger
fi

eval "$(starship init bash)"
