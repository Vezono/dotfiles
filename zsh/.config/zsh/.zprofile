export PATH=$PATH:$HOME/scripts:$HOME/bin
export PATH="$HOME/.npm-global/bin:$PATH"

export HISTFILE="$XDG_STATE_HOME"/zsh/history

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export GNUPGHOME="$XDG_DATA_HOME"/gnupg

export EDITOR=nvim

export WINEPREFIX="$XDG_DATA_HOME"/wine
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
alias adb='HOME="$XDG_DATA_HOME"/android adb'

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js   
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm                             
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm 
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc 

export ZSH="$XDG_DATA_HOME"/oh-my-zsh 

export PYTHON_HISTORY="$XDG_STATE_HOME"/python/history

# Created by `pipx` on 2023-10-24 23:40:10
export PATH="$PATH:/home/vezono/.local/bin"


if [[ "$(tty)" == "/dev/tty1" ]]; then
	usertree b
fi
