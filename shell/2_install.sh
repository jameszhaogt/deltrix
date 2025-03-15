cd /htdocs/software
# 安装ngnix
useradd -s /sbin/nologin www
tar zxf nginx-1.24.0.tar.gz
cd nginx-1.24.0
./configure --prefix=/data/nginx --user=www --group=www --with-file-aio --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_gzip_static_module --with-pcre
make && make install
# 安装JDK
yum install -y java-1.8.0-openjdk-1.8.0.332.b09-1.el7_9.x86_64.rpm java-1.8.0-openjdk-devel-1.8.0.332.b09-1.el7_9.x86_64.rpm
# 安装ElasticSearch
cd /htdocs/software
useradd es
tar zxf elasticsearch-7.15.2.tar.gz
mv elasticsearch-7.15.2/ /data/elasticsearch
chown -R es.es /data/elasticsearch
# 安装Redis（5.0.14）
tar zxf redis-5.0.14.tar.gz
mv redis-5.0.14 /data/redis
cd /data/redis/
mkdir data
make && make install

# 安装RabbitMQ（3.10.2）
cd /htdocs/software
tar zxf otp_src_24.3.4.2.tar.gz
yum install -y make gcc gcc-c++ m4 openssl openssl-devel ncurses-devel unixODBC unixODBC-devel
# erlang
cd otp_src_24.3.4.2/
mkdir -p /usr/local/erlang
./configure --prefix=/usr/local/erlang
make && make install

# 安装MongoDB（4.2.24）
cd /htdocs/software
tar zxf mongodb-linux-x86_64-rhel70-4.2.24.tgz
mv mongodb-linux-x86_64-rhel70-4.2.24 /data/mongodb

# 安装Zookeeper（3.4.14）
cd /htdocs/software
tar zxf zookeeper-3.4.14.tar.gz
mv zookeeper-3.4.14 /data/zookeeper

# 安装Kafka（2.12-2.3.1）
tar zxf kafka_2.12-2.3.1.tgz
mv kafka_2.12-2.3.1 /data/kafka

# 安装Canal（1.1.6）
mkdir -p /data/canal
tar zxf canal.tar.gz -C /data/canal
# mongo-capture
tar zxf mongo-capture.tar.gz -C /data/sbc/
# 十七、安装DBreplay
cd /htdocs/software/
tar zxf dbreplay.tar.gz -C /data/s2b
