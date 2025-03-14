cat ../wanmi* > /root/wanmi.zip
# 解压wanmi.zip到htdocs/software目录
# 创建目标目录（如果不存在）
mkdir -p /root/htdocs/software/
# 解压文件到目标目录
unzip /root/wanmi.zip -d /root/htdocs/software/
