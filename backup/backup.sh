#!/bin/sh
cd /home/backup

#===================================== 例子 备份数据库 【db1】==============================================

if [ ! -d "/home/backup/db1" ]; then
  mkdir -p /home/backup/db1
fi

mysqldump -h mysql56 -u root -p'1234' db1 > /home/backup/db1/$(date +"%Y-%m-%d").sql
#========================================================================================================


#上传到七牛
if [ $QINIU_UPLOAD ]
then
    sh /home/upload/qiniu.sh
fi