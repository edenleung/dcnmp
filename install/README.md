## 系统
ubuntu 18+

## 配置

添加 `docker-compose.service`文件， 路径 `/etc/systemd/system/docker-compose.service`  

修改 `ExecStart` 值 配置具体 `start.sh` 的位置

## 添加启动

```sh
$ systemctl enable docker-compose.service
```
