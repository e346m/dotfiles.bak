#$B%*%W%7%g%s(B

setopt auto_cd
setopt auto_pushd

#$BJd40(B
#for-zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)


#$BJd405!G=$rM-8z$K$9$k(B
autoload -Uz compinit
compinit -u
#$BJd40(B $B%a%K%e!<$NA*Br%b!<%I(B
zstyle ':completion:*:default' menu select=2

#$BJ8;z$N6h@Z$j@_Dj(B
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "/=;@;{}.|"
zstyle ':zle:*' word-style unspecified

#$BBgJ8;z$H>.J8;z$r6hJL$7$J$$(B
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#$B%W%m%s%W%H$NI=<((B
RPROMPT="[%~]" #current dirctory$B$N(Bpath$B$r1&C<I=<((B

#$B%3%^%s%IMzNr$NJ]B8(B
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

#dirctory$BMzNr(B
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

#$BJ#?t(Brename$B5!G=(B
autoload -Uz zmv

#$B%V%i%s%A>pJs(B
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*:' formats '(%s)-[%b]'
zstyle ':vcs_info:*:' actionformats '(%s)-[%b|%a]'
function _update_vcs_info_msg(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%v"

#$B%3%^%s%I%i%$%s(Bsyntax

[[ -f $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#$B%(%$%j%"%9(B
alias ls='ls -F'
alias la='ls -a'
alias ll='ls -l'
alias -g G='|grep'
alias gs='git status'
alias tm='/usr/local/bin/tmuxx'


#function
function zman(){
    PAGER="less -g -s '+/^{7}"$1"'" man zshall
}
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

