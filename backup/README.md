## 自动备份数据库
支持以下方式备份
* github
* 七牛云

### Github
1. 修改`Dockerfile`, 将`git clone git@github.com:user/project.git`换成你项目的ssh地址
2. 启动`docker-compose up --build`后，进入容器生成ssh_key信息 `ssh-keygen -t rsa -C "your_email@youremail.com"`
3. 把生成之后公钥、私钥、known_hosts的内容都保存到`backup/ssh`下对应文件
4. 把公钥保存到Github项目仓库的部署公钥上，并添加可写操作
5. 重新执行`docker-compose up --build`

### 七牛云
