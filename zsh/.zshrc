
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# plugins
zinit load zsh-users/zsh-autosuggestions
zinit load zdharma-continuum/fast-syntax-highlighting
zinit load jeffreytse/zsh-vi-mode
zinit load davidde/git


# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

#aliases
alias lg="lazygit"
alias jo="joshuto"
alias q="exit"
#alias emacs="env GTK_IM_MODULE=xim emacs"
#alias pc="proxychains4 -f ~/.config/proxychains.conf -q"
alias pc="proxychains -q"
#alias mihomo="cat ~/Mine/Core/Scripts/start-clash | sh"
#alias yacd="cat ~/Mine/Core/Scripts/start-yacd | sh"
#alias ls="lsd -lh"
alias android="~/Mine/Core/Scripts/waydroid.sh"
alias music='mpv -no-audio-display -loop-file "$(find ~/Mine/Extra/Music/ -type f | fzf)"'

# Define a function instead of an alias
function nf() {
  local dir=$1
  if [ ! -n $dir ]; then
    $dir=.
  fi
  # Run fzf and store the result
  fzfRes=$(/usr/bin/fd -H . $dir | /usr/bin/fzf)

  # Check if fzf returned a non-empty result
  if [ -n "$fzfRes" ]; then
    # Open the selected file in nvim
    nvim "$fzfRes"
  fi
}

alias wechat="cat ~/Mine/Core/Scripts/dochat.sh | DOCHAT_SKIP_PULL=true zsh"
alias ..="cd .."

# the fuck
eval $(thefuck --alias)

# star ship
eval "$(starship init zsh)"

### Environment Variables
# Java 
#export JAVA_HOME="/usr/local/java/jdk1.8.0_202"
#export JAVA_HOME="/usr/lib/jvm/java-11-openjdk/"
#export PATH=$PATH:$JAVA_HOME/bin

# spark
#export SPARK_HOME=/usr/local/spark
#export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# hadoop
#export HADOOP_HOME=/usr/local/hadoop
#export HADOOP_PREFIX=$HADOOP_HOME
#export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
#export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# maven
#export M2_HOME=/opt/maven/apache-maven-3.9.1
#export CLASSPATH=$CLASSPATH:$M2_HOME/lib
#export PATH=$PATH:$M2_HOME/bin

# ibus
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

# nextcloud

# for ssh top
#export TERM=linux
