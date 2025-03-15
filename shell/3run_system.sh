#!/bin/bash
# 启动中间件
/data/nginx/sbin/nginx
service mysql start
/data/redis/src/redis-server /data/redis/redis.conf
su - es -c "/data/elasticsearch/bin/elasticsearch -d"
/data/zookeeper/bin/zkServer.sh start
/data/kafka/bin/kafka-server-start.sh -daemon /data/kafka/config/server.properties
rabbitmq-server -detached

# 启动微服务
/data/nacos/bin/startup.sh -m standalone
/data/sbc/xxl-job/bin/startup.sh
service setting reload
service message reload
# ... 其他微服务启动命令

# 启动前端
service dist_site reload
service dist_mobile reload