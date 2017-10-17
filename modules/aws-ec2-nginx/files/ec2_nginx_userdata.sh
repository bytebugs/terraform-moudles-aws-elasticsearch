#!/bin/bash

echo "+++ Update the repository"
sudo yum update -y

echo "+++ Grant group wheel the ability to sudo like the root account"
echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel && chmod 440 /etc/sudoers.d/wheel

echo "+++ Install nginx"
sudo yum install nginx -y


kibana_url="https://${es_endpoint}/_plugin/kibana/";
private_ip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4);

sudo bash -c "cat << 'EOF' >> /etc/nginx/conf.d/kibana.conf
server {
    listen ${nginx_listen_port};
    server_name _;

    location /kibana {
        resolver                8.8.8.8;
        proxy_pass              $kibana_url;
        proxy_redirect          $kibana_url http://$private_ip:${nginx_listen_port}/kibana/;
        proxy_set_header        Host https://${es_endpoint};
        proxy_set_header        X-Real-IP $private_ip;
        proxy_set_header        Connection \"Keep-Alive\";
        proxy_set_header        Proxy-Connection \"Keep-Alive\";
        proxy_set_header        Authorization \"\";
        proxy_http_version      1.1;
    }

    location ~ (/app/kibana|/app/timelion|/bundles|/es_admin|/plugins|/api|/ui|/elasticsearch) {
        resolver                8.8.8.8;
        proxy_pass              https://${es_endpoint};
        proxy_set_header        Host \$host;
        proxy_set_header        X-Real-IP \$remote_addr;
        proxy_set_header        X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto \$scheme;
        proxy_set_header        X-Forwarded-Host \$http_host;
    }
}
EOF"

echo "+++ Start the service"
sudo service nginx start

echo "+++ Set the service start upon reboot"
sudo chkconfig nginx on
