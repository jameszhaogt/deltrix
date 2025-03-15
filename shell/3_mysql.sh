useradd -s /sbin/nologin mysql
cd /htdocs/software
tar zxf mysql-5.7.43-linux-glibc2.12-x86_64.tar.gz
mv mysql-5.7.43-linux-glibc2.12-x86_64 /data/mysql
chown -R mysql.mysql /data/mysql/