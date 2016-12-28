#option

setopt auto_cd
setopt auto_pushd

#補完
#for-zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

#補完機能を有効にする
autoload -Uz compinit
compinit -u
#補完 メニューの選択モード
zstyle ':completion:*:default' menu select=2

#文字の区切り設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "/=;@;{}.|"
zstyle ':zle:*' word-style unspecified

#大文字と小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#プロンプトの表示
PROMPT="
%B%F{226}$%f%b%F{green}%n%f%B@%b%F{166}%d%f%B::%b%F{033}%@%f
%F{magenta} ===> %f"
#コマンド履歴の保存
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

#dirctory履歴
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

#複数rename機能
autoload -Uz zmv

#ブランチ情報
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

#エイリアス
alias ls='ls -F'
alias la='ls -a'
alias ll='ls -l'
alias -g G='|grep'
alias gs='git status'
alias gr='git rebase -i'
alias gp='git pull'
alias gc='git co'
alias gst='git stash'
alias gsp='git stash pop'
alias tm='/usr/local/bin/tmuxx'
alias diff='diff -u'

#function
function zman(){
    PAGER="less -g -s '+/^{7}"$1"'" man zshall
}
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
eval "$(rbenv init -)"

#環境変数読み込み
if [ -f .*.env ]; then
  source ~/.*.env
fi

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

#zplug管理
if ! zplug check; then
    zplug install
fi

#コマンドラインsyntax
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# プラグインを読み込み、コマンドにパスを通す
zplug load
