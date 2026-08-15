alias cd='z'
alias ls='eza --icons=auto'
alias lsdu='eza --total-size --icons=auto'
alias cat='bat -p'
alias diff='delta'
alias hist='tv zsh-history'
alias wd='. wd'

function termcolors() {
    fg='\e[38;5;';bg='\e[48;5;'
    for ix in {1..256}; do
        printf "fg \"%s\e[38;5;%sm%s\e[0mm\"\tbg \"%s\e[48;5;%sm%s\e[0mm\"\n" ${fg} ${ix} ${ix} ${bg} ${ix} ${ix}
    done
    printf "\e[0m"
}
