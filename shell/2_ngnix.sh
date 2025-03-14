useradd -s /sbin/nologin www
cd /root/htdocs/software/
tar zxf nginx-1.24.0.tar.gz
cd nginx-1.24.0
./configure --prefix=/data/nginx --user=www --group=www --with-file-aio --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_gzip_static_module --with-pcre
make && make install
