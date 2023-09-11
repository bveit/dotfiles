# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

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

# vim with clipboard
# use "+ y to copy to clipboard
alias vim='gvim -v'


#aliases
alias gdock='docker-compose -f /home/vbillinger/Documents/globaldocker/docker-compose.yml'
alias dock='docker-compose'
alias dox='dock exec app'
alias rb='dox bin/ruby'
alias br='dox bin/ruby bin/rails'
alias brs='br s -b 0.0.0.0'
alias ctass='rb -S rails tmp:clear assets:clobber'
alias routes='dox rails routes --expanded'
alias checker='rb -S rails trox_work:check'
alias lbrs='dox script/server'
alias fbrs='dox bin/npm run start-docker'

alias dockdb='docker exec -it globaldocker_mariadb-10-5_1 mysql -uroot --default-character-set=utf8mb4'
alias down='shutdown -h +0'

#check for errors and correct
alias rcop='dox ./bin/rubocop -a && dox ./bin/eslint --fix .'

#run translation file
alias ptrans='dox bin/ruby -S process-translations'
#for legacy lexwork
alias ltrans='dox bash -c "
bin/ruby -S rake gettext:find;
bin/ruby -S rake gettext:clean;
for lang in en de fr it rm ; do
 msgcat --no-wrap -o locale/$lang/app.po locale/$lang/app.po
done"'



#git alias
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status'
alias gl='git log'
alias gb='git branch'
alias gd='git diff | bat'
alias gco='git checkout'

#re source terminal
alias res='source ~/.bashrc'

# list ssh tunnels
alias lssh="lsof -i -n | egrep '\<ssh\>'"

# mount gdrive
# alias gdrive='rclone mount drive:passwords ~/gdrive --daemon'

# run sdoc generation
alias sdoc="python3 ~/scripts/generate_sdoc.py *.sdoc *.png"

alias ll="ls -lhtr"

unset rc

# User specific aliases and functions
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# . "$HOME/.cargo/env"
