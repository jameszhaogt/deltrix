#!/bin/bash
# 安装Nginx
useradd -s /sbin/nologin www
cd /htdocs/software/
tar zxf nginx-1.24.0.tar.gz
cd nginx-1.24.0
./configure --prefix=/data/nginx --user=www --group=www --with-file-aio --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_gzip_static_module --with-pcre
make && make install

# 安装MySQL
useradd -s /sbin/nologin mysql
tar zxf mysql-5.7.43-linux-glibc2.12-x86_64.tar.gz
mv mysql-5.7.43-linux-glibc2.12-x86_64 /data/mysql
chown -R mysql.mysql /data/mysql/
mv my5.7.cnf /etc/my.cnf
cd /data/mysql/bin
./mysqld --defaults-file=/etc/my.cnf --initialize --user=mysql --basedir=/data/mysql --datadir=/data/mysql/data/
cd /data/mysql/support-files/
cp mysql.server /etc/init.d/mysql
chkconfig --add mysql
cd /htdocs/software/

# 安装JDK
yum install -y java-1.8.0-openjdk-1.8.0.332.b09-1.el7_9.x86_64.rpm java-1.8.0-openjdk-devel-1.8.0.332.b09-1.el7_9.x86_64.rpm
echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.332.b09-1.el7_9.x86_64' >> /etc/profile
source /etc/profile
# 删除TLSv1和TLSv1.1协议配置。修改tls协议，涉及商城无法支付问题
JDK_SECURITY_FILE="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.332.b09-1.el7_9.x86_64/jre/lib/security/java.security"
sed -i 's/TLSv1, TLSv1.1, //g' "$JDK_SECURITY_FILE"

# 安装ElasticSearch
useradd es
tar zxf elasticsearch-7.15.2.tar.gz
mv elasticsearch-7.15.2/ /data/elasticsearch
chown -R es.es /data/elasticsearch

# 安装Redis
tar zxf redis-5.0.14.tar.gz
mv redis-5.0.14 /data/redis
cd /data/redis
make && make install

# 安装RabbitMQ
tar zxf otp_src_24.3.4.2.tar.gz
cd otp_src_24.3.4.2
./configure --prefix=/usr/local/erlang
make && make install
echo 'export PATH=/usr/local/erlang/bin:$PATH' >> /etc/profile
source /etc/profile
tar xf rabbitmq-server-generic-unix-3.10.2.tar.xz
mv rabbitmq_server-3.10.2/ /data/rabbitmq
echo 'export PATH=/data/rabbitmq/sbin:$PATH' >> /etc/profile
source /etc/profile

# 安装MongoDB
tar zxf mongodb-linux-x86_64-rhel70-4.2.24.tgz
mv mongodb-linux-x86_64-rhel70-4.2.24 /data/mongodb
mkdir /data/mongodb/{db,logs}

# 安装其他组件（Zookeeper、Kafka、Canal等）
tar zxf zookeeper-3.4.14.tar.gz -C /data/
tar zxf kafka_2.12-2.3.1.tgz -C /data/
tar zxf canal.tar.gz -C /data/
tar zxf mongo-capture.tar.gz -C /data/sbc/
tar zxf dbreplay.tar.gz -C /data/s2b/