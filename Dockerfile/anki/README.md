# Anki

## 如何使用

镜像已上传至Docker Hub并开放拉取
```
$ docker pull lotusching/anki:latest
```

启动方式
```
$ docker run -d --name anki -e USERNAME="admin" -e PASSWORD="123456" -p 27701:27701 lotusching/anki:latest
```

检查访问，访问http://外网地址:27701，如果看到`Anki Sync Server`即为成功！

## 安卓使用自建anki

设置 -> 高级设置 -> 自定义同步服务器 -> 勾选自定义同步服务器 -> 同步服务器地址(http://公网IP:27701) -> 媒体文件同步服务器地址(http://公网IP:27701/msync)

完成后，点击同步，顺利的话会看到输入帐号密码，默认用户名密码都是admin

## Win使用自建anki
Tools -> Add-ons -> View files -> 创建目录 ankisyncd -> 创建 __init__.py -> 添加以下内容 -> 保存重启anki -> 点击Sync

```python
import anki.sync, anki.hooks, aqt

addr = "http://公网IP:27701/"
anki.sync.SYNC_BASE = "%s" + addr
def resetHostNum():
    aqt.mw.pm.profile['hostNum'] = None
anki.hooks.addHook('profileLoaded', resetHostNum)
```

一切顺利的话，顺利的话就会输入帐号密码，也就是docker run时传递的用户名密码。

## TODO

* 备份方式
