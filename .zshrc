#local
local orange=%F{166}
local blue=%F{033}
local magenta=%F{magenta}
#option
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
setopt auto_cd
setopt auto_pushd
export PATH="/usr/local/sbin:$PATH"

#プロンプトの表示
setopt prompt_subst
function gcloud-current() {
  if [[ -d $HOME/.config/gcloud/ ]]; then
    cat $HOME/.config/gcloud/active_config
  fi
}
PROMPT="$(gcloud-current):%b$orange%(5~,%-2~/.../%2~,%~)%f%B%b$blue%@%f $magenta> %f"

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
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

#エイリアス
alias ls='ls -Fh'
alias la='ls -ah'
alias ll='ls -lh'
alias -g G='|grep'
alias gs='git status'
alias gr='git rebase -i'
alias gp='git pull'
alias gc='git checkout'
alias gip="curl https://ipinfo.io/ip"
alias diff='diff -u'
alias vim='nvim'
alias gpush='git push origin `git symbolic-ref --short HEAD` -f'
alias gbl='git branch --sort=-committerdate'
alias gdel='git branch -a --merged | grep -v master | grep remotes/origin| sed -e "s% *remotes/origin/%%" | xargs -I% git push origin :%'
alias gldel='git checkout master && git branch --merged | grep -v "*" | xargs -I % git branch -d %'

function gitpr() {
    if [ "$1" != "" ]
    then
        git fetch upstream refs/pull/$1/head:pr/$1 && git checkout pr/$1
    else
        echo 'should add pull request number'
    fi
}

#load env
if [ -f $HOME/.env ]; then
  source $HOME/.env
fi

#overriding alias
if which bat > /dev/null; then alias cat='bat'; fi

#ruby
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init --no-rehash -)"

#python
# prevent .configure script from orverriding *-config
# remove pyenv path when using Homebrew
alias brew="env PATH=${PATH/\/usr\/local\/var\/pyenv\/shims:/} brew"

export PYENV_ROOT="/usr/local/var/pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init --no-rehash -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init --no-rehash -)"; fi

#iEx shell_history
export ERL_AFLAGS="-kernel shell_history enabled"
export ELIXIR_EDITOR="vim +__LINE__ __FILE__"

#asdf
#source /usr/local/opt/asdf/asdf.sh
#export PATH="/usr/local/sbin:$PATH"

#go
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
export PATH="$PATH:$GOBIN"


# For docker
export DOCKER_BUILDKIT=1
alias d_rmi_none='docker rmi $(docker images -f dangling=true -q)'

# POSTGRES
if which pspg > /dev/null; then
  export PSQL_PAGER=pspg
else
  export PSQL_PAGER="less -S"
fi

#android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# For Cross Platform
case ${OSTYPE} in
  darwin*)
    #Java
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    export PATH=${JAVA_HOME}/bin:$PATH

    #Alacritty
    export WAYLAND_DISPLAY="alacritty on Wayland"

    #If you need to have openssl@1.1 first in your PATH run:
    export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

    #For compilers to find openssl@1.1 you may need to set:
    export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
    export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

    #For pkg-config to find openssl@1.1 you may need to set:
    export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
    export PATH="/usr/local/opt/ncurses/bin:$PATH"

    # Google Cloud
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
    alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'

    function _zf_reload() {
      source $HOME/.zshrc
    }
    function _gcloud_change_project() {
      local proj=$(gcloud config configurations list | fzf --header-lines=1 | awk '{print $1}')
      if [ -n $proj ]; then
        gcloud config configurations activate $proj
        _zf_reload
        return $?
      fi
    }
    alias gcp=_gcloud_change_project
    ;;
  linux*)
    function _gcloud_change_project() {
      local proj=$(gcloud config configurations list | fzf --header-lines=1 | awk '{print $1}')
      if [ -n $proj ]; then
        gcloud config configurations activate $proj
        _zf_reload
        return $?
      fi
    }
    function _zf_reload() {
      source $HOME/.zshrc
    }
    alias gcp=_gcloud_change_project

    source '/usr/share/google-cloud-sdk/completion.zsh.inc'
    ;;
esac

# functions
function mkcd() {
  mkdir -p $1 && cd $1
}

function zman(){
    PAGER="less -g -s '+/^{7}"$1"'" man zshall
}

# change to project root directory
function cdg()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

#plugins
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
# ignore case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

#補完 メニューの選択モード
zstyle ':completion:*:default' menu select=2

zinit light zdharma/fast-syntax-highlighting

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# End of Zinit's installer chunk#

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
