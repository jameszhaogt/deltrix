#!/bin/bash
# 配置Nginx
tar zxf nginx_config.tar.gz -C /data/nginx/conf/
/data/nginx/sbin/nginx -t

# 配置MySQL
service mysql start
mysql -u root -p$(grep 'temporary password' /data/mysql/data/error.log | awk '{print $NF}') -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Wmi@2023'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Wmi@2023'; FLUSH PRIVILEGES;"

# 配置ElasticSearch
echo '* soft nofile 65536' >> /etc/security/limits.d/20-nproc.conf
echo '* hard nofile 65536' >> /etc/security/limits.d/20-nproc.conf
echo 'vm.max_map_count=262144' >> /etc/sysctl.conf
sysctl -p

# 配置Redis
sed -i 's/^daemonize no/daemonize yes/' /data/redis/redis.conf
sed -i 's/^# requirepass/requirepass Wmi@2023/' /data/redis/redis.conf

# 配置MongoDB副本集
echo 'replSet = rs1' >> /data/mongodb/mongodb.conf
/data/mongodb/bin/mongo --eval 'rs.initiate({_id: "rs1", members: [{_id:0, host: "127.0.0.1:27017"}]})'

# 配置环境变量
echo 'export PATH=/data/mongodb/bin:/data/mysql/bin:/data/mysql/lib:$PATH' >> /etc/profile
echo 'export ES_JAVA_HOME=/data/elasticsearch/jdk' >> /etc/profile
source /etc/profile

# 初始化数据库（示例）
mysql -u root -pWmi@2023 < sbc-setting.sql
mongorestore -d mofang --dir ./mofang



# 设置开机自启
echo '/data/nginx/sbin/nginx' >> /etc/rc.d/rc.local
echo 'service mysql start' >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local

# 配置防火墙
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --reload
