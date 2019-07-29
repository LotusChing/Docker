# Anki

## 如何使用

镜像已上传至Docker Hub并开放拉取
```
$ docker pull lotusching/anki:latest
```

启动方式
```
$ docker run -d --name anki -p 27701:27701 lotusching/anki:latest
$ docker logs -f anki
```

检查访问，访问http://外网地址:27701，如果看到`Anki Sync Server`即为成功！

## 安卓使用自建anki

设置 -> 高级设置 -> 自定义同步服务器 -> 勾选自定义同步服务器 -> 同步服务器地址(http://公网IP:27701) -> 媒体文件同步服务器地址(http://公网IP:27701/msync)

完成后，点击同步，顺利的话会看到输入帐号密码，默认用户名密码都是admin

## TODO

* 通过run -e 变量传递设置用户名密码
* 备份方式
