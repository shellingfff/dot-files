# hoembrew
export PATH=/opt/homebrew/bin:$PATH

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
autoload -Uz compinit; compinit
zinit light Aloxaf/fzf-tab
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
#alias jo="joshuto"
alias q="exit"
#alias emacs="env GTK_IM_MODULE=xim emacs"
#alias pc="proxychains4 -f ~/.config/proxychains.conf -q"
alias pc="proxychains4 -q"
#alias mihomo="cat ~/Mine/Core/Scripts/start-clash | sh"
#alias yacd="cat ~/Mine/Core/Scripts/start-yacd | sh"
alias ls="exa"
alias android="~/Mine/Core/Scripts/waydroid.sh"
alias music='mpv -no-audio-display -loop-file "$(find ~/Mine/Extra/Music/ -type f | fzf)"'


# for mac os
alias typora="open -a typora"
alias brave='open -a "Brave Browser.app"'

# nvim $(fd and fzf)
function nf() {
  local dir=$1
  if [ -z "$dir" ]; then
    dir="."
  fi
  # Run fzf and store the result
  fzfRes=$(fd -H -E .cache -E .local . $dir | fzf)

  # Check if fzf returned a non-empty result
  if [ -n "$fzfRes" ]; then
    # Open the selected file in nvim
    nvim "$fzfRes"
  fi
}

# cd $(fd and fzf)
function cf() {
  local dir=$1
  if [ -z $dir ]; then
    dir="."
  fi
  # Run fzf and store the result
  fzfRes=$(fd -H -t d . $dir | fzf)

  # Check if fzf returned a non-empty result
  if [ -n "$fzfRes" ]; then
    # Open the selected file in nvim
    cd "$fzfRes"
  fi
}

# y for yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# n for nnn
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

# jo for joshuto
function jo() {
	ID="$$"
	mkdir -p /tmp/$USER
	OUTPUT_FILE="/tmp/$USER/joshuto-cwd-$ID"
	env joshuto --output-file "$OUTPUT_FILE" $@
	exit_code=$?

	case "$exit_code" in
		# regular exit
		0)
			;;
		# output contains current directory
		101)
			JOSHUTO_CWD=$(cat "$OUTPUT_FILE")
			cd "$JOSHUTO_CWD"
			;;
		# output selected files
		102)
			;;
		*)
			echo "Exit code: $exit_code"
			;;
	esac
}

# proxy env
alias pe="export http_proxy=http:127.0.0.1:4444;export https_proxy=http://127.0.0.1:4444"

alias wechat="cat ~/Mine/Core/Scripts/dochat.sh | DOCHAT_SKIP_PULL=true zsh"
alias ..="cd .."

# the fuck
# eval $(thefuck --alias)

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

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

export EDITOR=nvim
