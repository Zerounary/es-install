#!/bin/bash
# Centos 7 Docker Elasticsearch 一键安装脚本，包含ES和IK中文分词
# author:  Zerounary
# contact: 850657663@qq.com
# usage:   将es-install.sh和es-init.sh复制到服务器，加运行权限

# 安装Docker
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

# 修改Docker镜像源

echo "{\"registry-mirrors\":[\"http://registry.docker-cn.com\"]}"  > /etc/docker/daemon.json

# 重启Docker

systemctl restart docker.service

# 安装ES
docker pull elasticsearch:7.9.3

docker network create es_network

docker run -d \
  --restart=always \
  --name elasticsearch \
  --network es_network \
  -p 9200:9200 -p 9300:9300 \
  -e "discovery.type=single-node" \
  elasticsearch:7.9.3

docker cp ./es-init.sh elasticsearch:/es-init.sh

# 初始化ES容器
docker exec -it elasticsearch chmod 777 /es-init.sh
docker exec -it elasticsearch bash /es-init.sh


# 重启容器
docker restart elasticsearch