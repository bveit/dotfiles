```
sudo dnf install
  tldr
  git
  gvim
  the_silver_searcher
  docker
  bat
  stow
  ufw
```

# setup ssh key and add to git
`ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github -C "<user>-2024-10-github"`
- add key to github
- add to ssh config
```
Host *
  ServerAliveInterval 60
  ServerAliveCountMax 3
  ExitOnForwardFailure yes
  Compression yes
  ForwardAgent no

# GitHub account
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
    IdentitiesOnly yes
```

# start docker deamon
`sudo systemctl start docker`

# dotfiles
`git@github.com:bveit/dotfiles.git`
`stow .`

# ufw
`sudo ufw add 22`
`ufw enable`
