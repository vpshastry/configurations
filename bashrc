# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

#PROMPT_COMMAND='echo `date +"%r"` `pwd` $USER "$(history 1)" >> ~/.bash_eternal_history'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@-\[\033[01;34m\]\W\[\033[00m\]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@-\W\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# My gluster aliases
alias gvc='gluster volume create'
alias gvi='gluster volume info'
alias gvd='gluster volume delete'
alias gv='gluster volume'
alias gmount='mount -t glusterfs'
alias gnmount='mount -t nfs -o vers=3,soft,intr'

alias cdg='cd /home/varun/workspace/git/glusterfs'
alias cdgl='cd /usr/local/var/log/glusterfs'
alias cdd='cd /home/varun/workspace/git/downstream-rhs/'

# Git aliases
alias gc='git checkout'
alias gb='git branch --color=auto'
alias gr='git rebase'
alias gd='git diff'
alias gs='git show'
alias gagd='git add `git diff --name-only`'
alias gl='git log'
alias gg='git grep -n --color=auto'

# My other aliases
alias psgrep='ps auwx | grep gluster'
alias psg='ps ax | grep '
alias psq='ps ax | grep quotad'
alias agi='apt-get install'
alias v='vim'
alias g='git'
alias cs='cscope'
alias c='clear'
alias rm='rm -i'
alias e='emacs -nw'
alias emacs='emacs -nw'
alias gxall='getfattr -d -m . -e hex'

# List only directories
alias ldir="ls -l | egrep '^d'"

alias acs='apt-cache search'

alias cs='cscope'
#change dir aliases
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias up='cd ../'
alias mounts='mount | column -t'
alias my_beep='aplay /usr/share/sounds/speech-dispatcher/test.wav'

#Environmental variables
export EDITOR=/usr/bin/vim
export CFLAGS='-g -O0'

# Randomly display man page from /usr/bin
#man `ls /usr/bin | shuf -n 1`

# My functions
extract () {
        if [ -f $1 ] ; then
                case $1 in
                *.tar.bz2)   tar xvjf $1    ;;
                *.tar.gz)    tar xvzf $1    ;;
                *.bz2)       bunzip2 $1     ;;
                *.rar)       rar x $1       ;;
                *.gz)        gunzip $1      ;;
                *.tar)       tar xvf $1     ;;
                *.tbz2)      tar xvjf $1    ;;
                *.tgz)       tar xvzf $1    ;;
                *.zip)       unzip $1       ;;
                *.Z)         uncompress $1  ;;
                *.7z)        7z x $1        ;;
                *.xz)        xz -d $1       ;;
                *)           echo "don't know how to extract '$1'..." ;;
                esac
        else
                echo "'$1' is not a valid file!"
        fi
}

fvim(){
    vim `find . -name '$1' | head -1`
}

fhere(){
        echo ""
        find . -name *$1*
        echo ""
}
