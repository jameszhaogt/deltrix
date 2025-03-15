cd /htdocs/software/
# nginx配置
tar zxf nginx_config.tar.gz
mv -f nginx_config/* /data/nginx/conf/

# mysql配置
mv my5.7.cnf /etc/my.cnf
cd /data/mysql/bin
./mysqld --defaults-file=/etc/my.cnf --initialize --user=mysql --basedir=/data/mysql --datadir=/data/mysql/data/
# 上一步初始化过程中若无异常，查看error.log，便会发现一串临时密码，记录此密码，用于初次登录mysql时使用
cd /data/mysql/data/
less error.log
# 编辑环境变量
# vim /root/.bash_profile 修改 PATH=$PATH:$HOME/bin 为：
# PATH=$PATH:$HOME/bin:/data/mysql/bin:/data/mysql/lib
source /root/.bash_profile
cd /data/mysql/support-files/
cp mysql.server /etc/init.d/mysql

# elasticsearch
sudo sh -c "echo '*          soft    nofile    65536' >> /etc/security/limits.d/20-nproc.conf"
sudo sh -c "echo '*          hard    nofile    65536' >> /etc/security/limits.d/20-nproc.conf"
sudo sh -c "echo 'vm.max_map_count=262144' >> /etc/sysctl.conf"
sudo sh -c "echo 'export ES_JAVA_HOME=/data/elasticsearch/jdk' >> /etc/profile"

source /etc/profile
sysctl -p

#十八、设置定时任务和运行脚本
cd /htdocs/software
tar zxf cron_shell.tar.gz
mv cron_shell /htdocs/Shell


