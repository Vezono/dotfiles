source $ZDOTDIR/.zprofile
tput cnorm

zsh_config_dir="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
zsh_plugins="${zsh_config_dir}/plugins.zsh"
zsh_plugins_src="${zsh_config_dir}/plugins.txt"

regen_plugins(){
    antidote bundle < $zsh_plugins_src > $zsh_plugins
    echo "Antidote plugins file was updated"
}

. ${XDG_DATA_HOME:-~/.local/share}/antidote/antidote.zsh
[ ! -e $zsh_plugins ] && regen_plugins
[ $zsh_plugins_src -nt $zsh_plugins ] && regen_plugins

bindkey -e

fpath=($ZDOTDIR/completions $fpath)

source $zsh_plugins
# All calls to compdef should be done AFTER this line

source ~/.cache/antidote/github.com/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh

bindkey '^I' menu-select

if [ -e "${zsh_config_dir}/aliases.zsh" ]; then
  . "${zsh_config_dir}/aliases.zsh"
fi
if [ -e "${zsh_config_dir}/aliases-nogit.zsh" ]; then
  . "${zsh_config_dir}/aliases-nogit.zsh"
fi

if [ -d /usr/share/fzf ]; then
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
fi

set zle_bracketed_paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz promptinit
promptinit
prompt adhde blue nohost

autoload -Uz zcalc

eval "$(zoxide init zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
