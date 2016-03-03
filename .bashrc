# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" 

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# # set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
    # xterm-color|*-256color|*rxvt*) color_prompt=yes;;
# esac

# # uncomment for a colored prompt, if the terminal has the capability; turned
# # off by default to not distract the user: the focus in a terminal window
# # should be on the output of commands, not on the prompt
# force_color_prompt=yes

# if [ -n "$force_color_prompt" ]; then
    # if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# # We have color support; assume it's compliant with Ecma-48
	# # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# # a case would tend to support setf rather than setaf.)
	# color_prompt=yes
    # else
	# color_prompt=
    # fi
# fi

# if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|*rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    # ;;
# *)
    # ;;
# esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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

# History settings
export HISTSIZE=30000
export HISTFILESIZE=30000
export HISTCONTROL=ignorespace #lines starting with space in the history.
export HISTIGNORE='&:ls:pwd:exit:clear:bash:sh:dash:fg:bg:sync:ls -ltr:ls -l:ls -t'
shopt -s histappend # append to the history file, don't overwrite it
# hack for sharing history between terminals
export PROMPT_COMMAND="history -a && cat ~/.bash_history | nl | sort -k2 -k1nr | uniq -f1 | sort -n | cut -c8- > /tmp/.bash_history$$ && history -c && mv /tmp/.bash_history$$ ~/.bash_history && history -r"

shopt -s autocd
shopt -s cdable_vars				# set the bash option so that no '$' is required (disallow write access to terminal)
shopt -s cdspell				# this will correct minor spelling errors in a cd command
shopt -s checkjobs              # second "exit" needed if running any jobs
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s cmdhist          			# save multi-line commands in history as single line
shopt -s complete_fullquote
shopt -s dirspell
shopt -s extglob
shopt -s globstar
shopt -s nocaseglob        # case-insensitive pathname expansion
shopt -s mailwarn				# keep an eye on the mail file (access time)
set -o notify					# notify when jobs running in background terminate
set bell-style visible # disable audio bell
set completion-ignore-case on 		# complete things that have been typed in the wrong case
set colored-stats on
set completion-prefix-display-length 1


PS1="\[\e[35;1m\]\[$(pwd -P)\] \[\e[32;1m\]\h \u \[\e[35;1m\]\j $(echo \${?\#\#0:}) \[\e[0m\]\t\n\[\e[32;1m\]\\$ \[\e[0m\]"

# # export TMOUT=600				# auto logout after n seconds of inactivity
# export LESSCHARSET='latin1'
# export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \'
# # export LESSOPEN="|lesspipe.sh %s"; export LESSOPEN
# export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'	# use this if lesspipe.sh exists
# # export LESS="-QR"				# tell less not to beep and also display colours
# # export LESS='-R'
# # export LESS_TERMCAP_mb=$'\E[01;31m'      	# less colors for Man pages # begin blinking
# # export LESS_TERMCAP_md=$'\E[01;38;5;74m'  	# less colors for Man pages # begin bold
# # export LESS_TERMCAP_me=$'\E[0m'           	# less colors for Man pages # end mode
# # export LESS_TERMCAP_se=$'\E[0m'           	# less colors for Man pages # end standout-mode
# # export LESS_TERMCAP_so=$'\E[38;5;246m'    	# less colors for Man pages # begin standout-mode - info box
# # export LESS_TERMCAP_ue=$'\E[0m'           	# less colors for Man pages # end underline
# # export LESS_TERMCAP_us=$'\E[04;38;5;146m' 	# less colors for Man pages # begin underline
