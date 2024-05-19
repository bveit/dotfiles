# https://www.sitrox.com/wiki/index.php/B530_VMs_(vm1.b530.000.ch)
function compat {
  if [[ $1 == '-h' ]]; then
    echo "ie8, ie9, ie10, ie11, edge"
    echo "ff"
    echo "office2007, office2010, office2013, office2016, vision2019"
    echo "pdfgen"
    return
  fi

  server="b530.000.ch"
  case $1 in
    # Windows / Internet Explorer Test Machines
    (ie8)  name="win7-ie8" ;;
    (ie9)  name="win7-ie9" ;;
    (ie10) name="win7-ie10" ;;
    (ie11) name="win7-ie11" ;;
    (edge) name="win10-msedge" ;;

    # Windows / Firefox Test Machines:
    (ff) name="win7-firefox49" ;;

    # Windows / Office Test Machines:
    (office2007) name="win7-office2007" ;;
    (office2010) name="win7-office2010" ;;
    (office2013) name="win7-office2013" ;;
    (office2016) name="win7-office2016" ;;
    (visio2019)  name="win10-visio2019" ;;

    # Windows / Office sitrox_office_to_pdf_converter test Machine:
    (pdfgen) name="win10-pdfgen" ;;
  esac
  #rdesktop -u Sitrox -p - -g 1900x1000 $server
  xfreerdp /u:Sitrox /p:sitrox /w:1680 /h:960 /v:$name.$server
}

function gshow {
  git show --color "$1" | less -R
}

function nvim {
    if [ -d "$1" ]; then
      command nvim -c "cd $1 | NvimTreeToggle"
    else
        command nvim "$@"
    fi
}

alias svntunnel='ssh -fNL 3690:svn.sitrox.com:3690 vbillinger@dev37.sitrox.com'

# vim with clipboard
# use "+ y to copy to clipboard
# alias vim='gvim -v'

# docker
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



# git alias
alias ga='git add .'
alias gc='git commit'
alias gs='git status'
alias gl='git log --color --abbrev-commit --reverse | less -R +G'
alias gls='git log --color --abbrev-commit --pretty=oneline --reverse | less -R +G'
alias glt="git log --color --graph --pretty=tformat:'\t%C(red)%h%C(reset) - %<(50,trunc)%s %C(green)%<(15,trunc)%cr %C(bold blue)%<(15,trunc)%an %C(reset)%C(yellow)%d' --abbrev-commit | less -R"
alias gb='git branch'
alias gd='git diff --color | less -R'
alias gco='git checkout'

#re source terminal
alias res='source ~/.bashrc'

# list ssh tunnels
alias lssh="lsof -i -n | egrep '\<ssh\>'"

# mount gdrive
# alias gdrive='rclone mount drive:passwords ~/gdrive --daemon'

# run sdoc generation
alias sdoc="python3 ~/scripts/generate_sdoc.py *.sdoc *.png"

alias ll="ls -lhtr --color=auto"

# zero tier for VPN
alias zti="zerotier-cli info"
