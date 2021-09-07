function bootstrap_zinit {
  local install_path="$HOME/.zinit/bin"
  if [ ! -d "$install_path" ]; then
    git clone https://github.com/zdharma/zinit.git "$install_path"
  fi
}

bootstrap_zinit

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
