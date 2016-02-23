#! /bin/bash
source ~/.sshagent.sh

##############################################################################################3
# Setup git-prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1

# Enable 256 color terminal mode
export TERM=xterm-256color

# Setup git-prompt for Windows
PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[33m\]\w$(__git_ps1)\[\033[0m\]\n$ '
