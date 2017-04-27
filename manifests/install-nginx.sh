#!/bin/bash
############################
# nginx reverse proxy server
############################
apt-get install -y nginx
rm /etc/nginx/sites-enabled/default
# http://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/
cat << 'EOF' >> /etc/nginx/sites-available/rstudio-shiny
server {
  listen 80;

  location / {
    proxy_pass http://localhost:8787;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }

  location /shiny/ {
    proxy_pass http://localhost:3838;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}
EOF
ln -s /etc/nginx/sites-available/rstudio-shiny /etc/nginx/sites-enabled/rstudio-shiny
systemctl restart nginx
