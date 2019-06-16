#!/bin/bash

apt-get update && apt-get install wget unzip -y && \


cd /tmp/ && \
    rm -rf consul_1.5.1_linux_amd64.zip ; \
    wget https://releases.hashicorp.com/consul/1.5.1/consul_1.5.1_linux_amd64.zip && \
    unzip consul_1.5.1_linux_amd64.zip && \
    chmod +x consul && \
    mv consul /usr/local/bin && \
    consul -v


cd /tmp/ && \
    rm -rf nomad_0.9.3_linux_amd64.zip ; \
    wget https://releases.hashicorp.com/nomad/0.9.3/nomad_0.9.3_linux_amd64.zip && \
    unzip nomad_0.9.3_linux_amd64.zip && \
    chmod +x nomad && mv nomad /usr/local/bin/ && \
    sudo mkdir -p /opt/nomad.d && \
    nomad -v

tee  /etc/systemd/system/nomad.service << END
[Unit]
Description=Nomad
Documentation=https://nomadproject.io/docs/
Wants=network-online.target
After=network-online.target

[Service]
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/nomad agent -config /etc/nomad.d
KillMode=process
KillSignal=SIGINT
LimitNOFILE=infinity
LimitNPROC=infinity
Restart=on-failure
RestartSec=2
StartLimitBurst=3
TasksMax=infinity

[Install]
WantedBy=multi-user.target
END

tee  /etc/nomad.d/server.hcl << END
server {
  enabled = true
  bootstrap_expect = 3
}
END

tee /etc/nomad.d/client.hcl << END
client {
  enabled = true
}
END

curl -sSL https://get.docker.io | sh ;

sudo systemctl enable docker
sudo systemctl start docker


nomad -autocomplete-install
complete -C /usr/local/bin/nomad nomad

sudo systemctl enable nomad
sudo systemctl start nomad
sudo systemctl status nomad