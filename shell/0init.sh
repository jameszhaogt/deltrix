cat ../package/wanmi** > /root/wanmi.zip
# 解压wanmi.zip到htdocs/software目录
mkdir -p /htdocs/software /data/{s2b,sbc} /htdocs/jar/backup /htdocs/sbc/jar/backup

# 解压文件到目标目录
unzip /root/wanmi.zip -d /htdocs/software/
mv /htdocs/software/shenzhi/* /htdocs/software/
