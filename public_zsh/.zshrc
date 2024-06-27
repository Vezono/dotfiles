# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
