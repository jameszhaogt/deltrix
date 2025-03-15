#!/bin/bash
# ... 其他配置步骤 ...

# 生成ElasticSearch CA证书和节点证书
echo "生成ElasticSearch CA证书和节点证书..."
sudo -u es mkdir -p /data/elasticsearch/config/certs
cd /data/elasticsearch/bin

# 生成CA证书（非交互式，无密码）
sudo -u es ./elasticsearch-certutil ca --pass "" -out config/certs/elastic-stack-ca.p12

# 生成节点证书（使用CA证书签名）
sudo -u es ./elasticsearch-certutil cert --ca config/certs/elastic-stack-ca.p12 --ca-pass "" --pass "" -out config/certs/elastic-certificates.p12

# 设置证书文件权限
chown -R es:es /data/elasticsearch/config/certs
chmod 660 /data/elasticsearch/config/certs/*.p12

# 修改ElasticSearch配置文件以启用安全功能
ELASTIC_YML="/data/elasticsearch/config/elasticsearch.yml"
cat << EOF >> "$ELASTIC_YML"

# 启用X-Pack安全
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: certs/elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: certs/elastic-certificates.p12
EOF

# 初始化ElasticSearch内置用户密码
echo "初始化ElasticSearch用户密码..."
sudo -u es ./elasticsearch-setup-passwords auto -b

# 重启ElasticSearch服务
echo "重启ElasticSearch..."
pkill -f elasticsearch
sleep 5
sudo -u es /data/elasticsearch/bin/elasticsearch -d

# 验证证书和安全性
echo "验证ElasticSearch安全性..."
curl -u elastic:$(sudo grep "PASSWORD elastic" /data/elasticsearch/logs/elasticsearch.log | awk '{print $NF}') http://localhost:9200/_cluster/health?pretty