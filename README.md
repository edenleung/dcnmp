# xiaodi-docker-lnmp
#### Docker开发环境

### 创建项目
1. 在workspace目录 创建项目
2. 配置虚拟主机conf/conf.d/你的项目.conf, listen 添加你自定义的端口 参考tp5.conf
3. 配置启动端口映射 docker-compose.yml 
##### 注！ 9503:9503 指 ```本地端口:容器端口```
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
