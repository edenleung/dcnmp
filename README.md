# xiaodi-docker-lnmp

### Docker [必须安装](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

### Docker 加速
在桌面右下角状态栏中右键 docker 图标，修改在 Docker Daemon 标签页中的 json ，把下面的地址:
"registry-mirrors"
~~~
http://f1361db2.m.daocloud.io
~~~

### 创建项目
1. 在workspace目录 创建项目
2. 配置虚拟主机```conf/conf.d/project_name.conf```, listen 添加你自定义的端口 参考```tp5.conf.examplte```
3. 自定义配置启动端口映射 docker-compose.yml （可选）
注！ ```9503:9503``` 指 ```本地端口:容器端口```
~~~
nginx:
    ...
    ports:
      - 9503:9503
~~~

### 启动
~~~
$ docker-compose up
~~~

### 指定PHP版本
修改 ```conf/conf.d/你的项目.conf```
~~~
location ~ \.php$ {
  fastcgi_pass   php56:9000;

  # php7.3
  # fastcgi_pass php73:9000;

}
~~~

### 数据库连接
~~~
mysqli_connect('容器名称', 'root', 1234, 'database')
~~~
#### 例子
连接mysql5.6: ```mysqli_connect('mysql56', 'root', 1234, 'database')```
连接mysql5.7: ```mysqli_connect('mysql57', 'root', 1234, 'database')```

### 数据库工具连接
直接使用当前映射的端口访问内部

## MYSQL linux问题
注意启动时的提示，如果出现以下提示，你数据库的数据卷应该无法同步到本地
`Warning: World-writable config file '/etc/mysql/my.cnf' is ignored`
解决
在linux服务器，更改my.cnf的权限，再重启
`chmod 644 my.cnf`

## MYSQL 主从复制
1.配置my.cnf， master与slave只是server-id不同
```
[mysqld]

log-bin=mysql-bin
server-id=1
```
2.创建复制账号(Master) 用户名 `bakcup` 密码 `backup`
```sql
GRANT REPLICATION SLAVE ON *.* to 'backup'@'%' identified by 'backup';
```
3.slave配置链接与启动同步
```sql
CHANGE MASTER TO 
MASTER_HOST='mysql56',
MASTER_PORT=3306,
MASTER_USER='backup',
MASTER_PASSWORD='backup';
```

```sql
START SLAVE;
```
注意，复制只能从创建数据库开始才跟踪到，不能在Master已有目标数据库，而Slave没有目标数据库，这种情况是不能复制到的。
