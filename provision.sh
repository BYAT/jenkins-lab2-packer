#!/bin/bash

curl -L get.docker.com |sh
sudo usermod -aG docker ubuntu


sudo docker pull nginx
sudo mkdir /home/ubuntu/api
sudo touch /home/ubuntu/api/index.html
sudo touch /etc/systemd/system/webserver.service
sudo chmod a+rw /etc/systemd/system/webserver.service

cat << EOF >> /etc/systemd/system/webserver.service
[Unit]
Description=The nginx HTTP and reverse proxy server
Documentation=http://nginx.org/en/docs/
Requires=webserver.service
After=docker.service

[Service]
ExecStart=sudo docker container run --name some-nginx-1 -d -p 80:80 --restart=always -v /home/ubuntu/api:/usr/share/nginx/html:ro nginx


ExecReload=/usr/bin/docker exec some-nginx nginx -s reload

# Restart 2 seconds after docker run exited with an error status.


[Install]
WantedBy=multi-user.target
EOF

sudo chmod a+xw /etc/systemd/system/webserver.service
sudo systemctl daemon-reload
sudo systemctl enable webserver.service
sudo systemctl start webserver
