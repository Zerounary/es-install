#!/bin/bash
# 容器初始化脚本

echo "http.cors.enabled: true" >> /usr/share/elasticsearch/config/elasticsearch.yml
echo "http.cors.allow-origin: \"*\"" >> /usr/share/elasticsearch/config/elasticsearch.yml

# 安装IK中文分词插件

cd /usr/share/elasticsearch/plugins/
echo y | elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.9.3/elasticsearch-analysis-ik-7.9.3.zip