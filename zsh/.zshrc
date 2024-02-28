zsh_plugins=~/.zsh_plugins.zsh

regen-plugins(){
    antidote bundle < ~/.zsh_plugins.txt > $zsh_plugins
}

. /usr/share/zsh-antidote/antidote.zsh
[[ ! -e ~/.zsh_plugins.zsh ]] && regen-plugins

zstyle ':omz:update' mode disabled

. $zsh_plugins
. ~/.zsh_aliases.zsh
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh

autoload -Uz compinit
compinit

# Created by `pipx` on 2023-10-24 23:40:10
export PATH="$PATH:/home/vezono/.local/bin"
