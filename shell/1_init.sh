cat ../package/wanmi** > /root/wanmi.zip
# 解压wanmi.zip到htdocs/software目录
# 创建目标目录（如果不存在）
mkdir -p /htdocs/software/
mkdir -p /data/{s2b,sbc}（bff和微服务安装目录）
mkdir -p /htdocs/jar/backup
mkdir -p /htdocs/sbc/jar/backup
# 解压文件到目标目录
unzip /root/wanmi.zip -d /htdocs/software/
mv /htdocs/software/shenzhi/* /htdocs/software/
