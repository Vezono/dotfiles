source $ZDOTDIR/.zprofile
tput cnorm

local zsh_config_dir="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
local zsh_plugins="${zsh_config_dir}/plugins.zsh"
local zsh_plugins_src="${zsh_config_dir}/plugins.txt"
local antidote_location="${XDG_DATA_DIR:-${HOME}/.local/share}/antidote"
export ANTIDOTE_HOME="${XDG_DATA_DIR:-${HOME}/.local/share}/antidote_bundles"

get_antidote() {
    git clone --depth=1 https://github.com/mattmc3/antidote.git "${antidote_location}"
}

regen_plugins(){
    . ${XDG_DATA_DIR:-~/.local/share}/antidote/antidote.zsh
    antidote bundle < $zsh_plugins_src > $zsh_plugins
    echo "Antidote plugins file was updated"
}

# download antidote if not exist
[ ! -d "${antidote_location}" ] && get_antidote

# Generate antidote.zsh when absent or when antidote.txt is newer than antidote.zsh
[ ! -e $zsh_plugins ] && regen_plugins
[ $zsh_plugins_src -nt $zsh_plugins ] && regen_plugins

bindkey -e

fpath=($ZDOTDIR/completions $fpath)

source $zsh_plugins
# All calls to compdef should be done AFTER this line

# Enable zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#source ~/.cache/antidote/github.com/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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

command -v atuin > /dev/null && eval "$(atuin init --disable-up-arrow --disable-ai zsh)"

eval "$(zoxide init zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
