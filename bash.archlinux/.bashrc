#
# ~/.bashrc
#

# If not running interactively, don't do anything
if [[ ! $- =~ i ]]; then
  return
fi

export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

if type sway &> /dev/null && ! pidof -q sway; then
  exec sway
elif type tmux &> /dev/null && ! pidof -q tmux && [[ -z $TMUX ]]; then
  exec tmux
elif type ranger &> /dev/null && [[ -z $RANGER_LEVEL ]]; then
  exec ranger
fi

eval "$(starship init bash)"
