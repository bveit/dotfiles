# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$HOME/.rbenv/shims:$PATH
export EDITOR=vim

export PS1="\n\t [\u@\h \W]\\$ \[$(tput sgr0)\]"

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# add scripts dir to path
export PATH="/home/vbillinger/scripts:$PATH"


unset rc

# User specific aliases and functions
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

bind "set completion-ignore-case on"

eval "$(rbenv init - bash)"

# eval "$(fzf --bash)"

HISTSIZE=50000

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

export LANG="en_US.UTF-8" # (updated)
