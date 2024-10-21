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
  nginx
  certbot
  python3-certbot-nginx
  cronie
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
```
sudo ufw add 22
sudo ufw add http
sudo ufw add https
ufw enable
```

# nginx
```
sudo systemctl start nginx
sudo systemctl enable nginx
nano duck.sh
echo url="https://www.duckdns.org/update?domains=YOUR_SUBDOMAIN&token=YOUR_TOKEN&ip=" | curl -k -o duck.log -K -
chmod +x duck.sh
./duck.sh
crontab -e
*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1
```

# nginx
`sudo vi /etc/nginx/conf.d/sp600.duckdns.org.conf`
```
server {
    listen 80;
    server_name sp600.duckdns.org;

    root /usr/share/nginx/html;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}
```
`sudo systemctl restart nginx`
`sudo certbot --nginx -d sp600.duckdns.org`

# vaultwarden
`sudo vi /etc/nginx/conf.d/vault.sp600.duckdns.org.conf`
```
server {
    listen 80;
    server_name vault.sp600.duckdns.org;

    location / {
        proxy_pass http://localhost:3003;  # Vaultwarden HTTP port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # WebSocket support
    location /notifications/hub {
        proxy_pass http://localhost:3012;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
`sudo systemctl reload nginx`
`sudo certbot certonly --nginx -d vault.sp600.duckdns.org`
```
server {
    listen 80;
    server_name vault.sp600.duckdns.org;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name vault.sp600.duckdns.org;

    ssl_certificate /etc/letsencrypt/live/vault.sp600.duckdns.org/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/vault.sp600.duckdns.org/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;

    location / {
        proxy_pass http://localhost:3003;  # Vaultwarden HTTP interface
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # WebSocket for Vaultwarden
    location /notifications/hub {
        proxy_pass http://localhost:3012;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
`sudo systemctl reload nginx`
```
services:
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    environment:
      # generate with `openssl rand -base64 32`
      # ADMIN_TOKEN: '<secure_token>'     # only needed to acess /admin route
      WEBSOCKET_ENABLED: 'true'           # Enable WebSocket notifications
      SIGNUPS_ALLOWED: 'false'            # Disable open sign-ups for security; enable for fist account
      DOMAIN: 'https://vault.sp600.duckdns.org'
    volumes:
      - ./data:/data                   # Persist Vaultwarden data
    ports:
      - "3012:3012"                       # WebSocket notifications
      - "3003:80"                         # Vaultwarden's HTTP port
    restart: unless-stopped
```

