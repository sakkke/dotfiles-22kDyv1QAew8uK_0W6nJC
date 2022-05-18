#
# ~/.bashrc
#

# If not running interactively, don't do anything
if [[ ! $- =~ i ]]; then
  return
fi

export EDITOR=nvim
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/bin:$PATH"

if type sway &> /dev/null && ! pidof -q sway; then
  exec sway
elif type tmux &> /dev/null && ! pidof -q tmux && [[ -z $TMUX ]]; then
  exec tmux
elif type lf &> /dev/null && [[ -z $LF_LEVEL ]]; then
  exec lf
elif type ranger &> /dev/null && [[ -z $RANGER_LEVEL ]]; then
  exec ranger
fi

if [[ -f ~/.aliases ]]; then
  source ~/.aliases
fi

eval "$(starship init bash)"
