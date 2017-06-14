# \ ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
function promps {
    # 色は気分で変えたいかもしれないので変す宣言しておく
    local  BLUE="\[\e[1;34m\]"
    local  RED="\[\e[1;31m\]"
    local  GREEN="\[\e[1;32m\]"
    local  WHITE="\[\e[00m\]"
    local  GRAY="\[\e[1;37m\]"

    case $TERM in
        xterm*) TITLEBAR='\[\e]0;\W\007\]';;
        *)      TITLEBAR="";;
    esac
    local BASE="\u@\h"
    PS1="${TITLEBAR}${GREEN}${BASE}${WHITE}:${BLUE}\W${GREEN}\$(parse_git_branch)${BLUE}\$${WHITE} "
}
promps

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
alias nv='nvim'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# please set network-interface
network_if=eth0

if [ -e /opt/tmc/ros/indigo/setup.bash ] ; then
  export TARGET_IP=$(LANG=C /sbin/ifconfig $network_if | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
  if [ -z "$TARGET_IP" ] ; then
    echo "ROS_IP is not set."
  else
    export ROS_IP=$TARGET_IP
  fi
  alias rossethsr='export ROS_MASTER_URI=http://nori:11311 export PS1="\[\033[41;1;37m\]<hsrb>\[\033[0m\]\w$ "'
fi


# ros methods
rossetaero(){
	export ROS_MASTER_URI=http://garlic:11311
	export ROS_IP=`hostname -I`
	export ROS_HOSTNAME=$ROS_IP
}
rosreset(){
	export ROS_MASTER_URI=http://localhost:11311 #you can modify
	export ROS_IP=`hostname -I`
	export ROS_HOSTNAME=$ROS_IP
    source "$HOME/.bashrc"
}	
rossetmachine(){
    export ROS_IP=`hostname -I | sed "s/ //" `
    export ROS_MASTER_URI=http://${ROS_IP}:11311
    export ROS_HOSTNAME=$ROS_IP
}
    
# add
export PATH="$HOME/.local/bin:$PATH"
## set EDITOR
export EDITOR='nvim'
## CUDA
#export LD_LIBRARY_PATH=/usr/lib32/nvidia-375:$LD_LIBRARY_PATH
export CUDA_HOME="/usr/local/cuda-8.0"
export PATH=${CUDA_HOME}/bin:$PATH
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export CPATH=${CUDA_HOME}/include:$CPATH
export LIBRARY_PATH=${CUDA_HOME}/lib64:$LIBRARY_PATH
export CFLAGS=-I${CUDA_HOME}/include
export LDFLAGS=-L${CUDA_HOME}/lib64
## SVN and SSH
export SSH_USER=m-takeda
export SVN_SSH="ssh -l ${SSH_USER}"
## ROS
#source $HOME/new_catkin/devel/setup.bash
## cask
export PATH="/home/muku/.cask/bin:$PATH"
### virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh
### pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
## pycaffe
#export PYTHONPATH=~/project/caffe/caffe/python/:$PYTHONPATH
export PYTHONPATH="/home/muku/project/caffe/caffe/install/python:$PYTHONPATH"
## opencv
#export PYTHONPATH="$HOME/project/Install-OpenCV/Ubuntu/OpenCV/opencv-3.1.0/build/lib:$PYTHONPATH"
#export OpenCV_DIR="$HOME/project/Install-OpenCV/Ubuntu/OpenCV/opencv-3.1.0/build"
#export OpenCV_DIR="/usr"
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
## bazel
source /home/muku/.bazel/bin/bazel-complete.bash
export PATH="$HOME/bin:$PATH"
## ns2
export NS_HOME="/home/muku/project/ns-allinone-2.35"
export LD_LIBRARY_PATH=$NS_HOME/otcl-1.14:$NS_HOME/lib:$LD_LIBRARY_PATH
export TCL_LIBRARY=$NS_HOME/tcl8.5.10/library
## tex
export PATH="/usr/local/texlive/2016/bin/x86_64-linux:$PATH"
#useful setting
export HSR="/home/muku/catkin_ws2/src/ut-hsr-community/users/mtakeda"
export RCUP="$HOME/catkin_ws2/src/jsk_hsr/jsk_hsr_demos/jsk_help_me_carry_201702_hsr/"
export FRCN_ROOT="/home/muku/project/py-faster-rcnn/"


