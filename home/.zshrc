# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt incappendhistory
setopt sharehistory

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

export PATH="$PATH:$HOME/.local/bin"

function enter-temp {
  temp="$(mktemp -d)"
  trap "rm -fr '$temp'" EXIT
  nvim -c "cd $temp"
}

source ~/.aliases
source ~/.aliases.local

function bootstrap_asdf {
  local install_path="$HOME/.asdf"
  if [ ! -d "$install_path" ]; then
    git clone https://github.com/asdf-vm/asdf.git "$install_path"
  fi
}

function bootstrap_zinit {
  local install_path="$HOME/.zinit/bin"
  if [ ! -d "$install_path" ]; then
    git clone https://github.com/zdharma/zinit.git "$install_path"
  fi
}

bootstrap_asdf
bootstrap_zinit

. "$HOME/.asdf/asdf.sh"
fpath=("$ASDF_DIR/completions" $fpath)
autoload -Uz compinit && compinit

source ~/.zinit/bin/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit load agkozak/zsh-z
zinit light greymd/tmux-xpanes
zinit light olets/zsh-abbr
zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

function zalias {
  abbr -S -q "$1"
}

source ~/.zaliases
source ~/.zaliases.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zshrc.local
