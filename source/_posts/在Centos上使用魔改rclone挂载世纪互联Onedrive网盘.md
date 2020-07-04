---
title: 在Centos上使用魔改rclone挂载世纪互联Onedrive网盘
date: 2020-05-31 18:37:05
tags:
    - vps
    - onedrive
    - 在线网盘
---
## 说明
官方版本Rclone不支持挂载世纪互联版本的onedrive，大佬们修改并编译了支持世纪互联版本的Rclone，同时支持其他版本的储存方式。

本教程使用 魔改的Rclone 挂载世纪互联版本的[Onedrive网盘](https://www.yiyi.one/aff.php?aff=141)。
## 魔改版的rclone下载地址
+ Rclone V1.50.2版：
    + [window-64版](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-download/rclone-v1.50.2-windows-amd64-21vianet.zip)
    + [window-32位](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-download/rclone-v1.50.2-windows-386-21vianet.zip)
    + [linux-64位](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-download/rclone-v1.50.2-linux-amd64-21vianet.zip)
    + [linux-32位](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-download/rclone-v1.50.2-linux-386-21vianet.zip)
+ Rclone V1.51.0版：
    + [window-64位](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-download/rclone-v1.51.0-windows64-21vianet.zip)
    + [linux-64位](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-download/rclone-v1.51.0-linux-amd64-21vianet.zip)

<!-- more -->

## 注册Azure应用
地址：[https://portal.azure.cn/](https://portal.azure.cn/)，登录完成后按下列步骤进行：
1. 左侧找到 `Azure Active Directory`点击
2. 左侧找到 `应用注册`
3. 上方找到 `新注册`点击
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-picture/2020021807465068-1024x490.png)
4. 名字：`onedrive`（自取）
5. 受支持的账户类型：`任何组织目录(任何 Azure AD 目录 - 多租户)中的帐户`（第二个)
6. 重定向URL: `http://localhost:53682`
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-picture/2020021807475042-1024x774.png)
7. 点击注册 找到`应用程序（客户端）ID` **复制Client_ID并保存**
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-picture/2020021807490386.png)
8. 左下方找到`证书和密码`点击
9. 下方 客户端密码 - 新客户端密码
10. 说明： `onedrive`
11. 截止期限：默认 `1年内`
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-picture/2020021807494729.png
)
12. 点击 添加，`值` 客户端密码 **复制client_secret保存**
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-picture/2020021807502037-1024x251.png
)
13. 左侧找到 `API 权限` 点击
14. 添加权限 - `Microsoft Graph` - 委托的权限 - `Files` (7)全部勾选
15. 选择应用程序权限 在下方Files里选择 `Files.Read.All`和`Files.ReadWrite.All`
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-picture/2020021807505553-1024x606.png
)

回到界面**如果**会发现该权限处于未授权状态，我们需要全局管理员点击 `代表XXXX授予管理员同意`
```yaml
Files.Read
Files.Read.All
Files.Read.Selected
Files.ReadWrite
Files.ReadWrite.All
Files.ReadWrite.AppFolder
Files.ReadWrite.Selected
```
## 申请access_token
由于vps上没有浏览器的客户端，不能申请`access_token`，所以需要借助`window`平台。

下载完window相应的客户端文件，在Rclone所在的文件夹内，打开CMD，执行命令(替换相应的**ID**和**Secret**):
```yaml
rclone authorize onedrive "应用程序(客户端) ID" "客户端密码值" --onedrive-is-21vianet-version=true
```

之后会跳转到浏览器，登录账号之后返回 Windows 命令行，会返回 token，复制保存下来，后面要用。
![](http://www.royonedrive.tk/%E5%9B%BE%E5%BA%8A/blog-picture/2020021807535362-1024x474.png)

## 安装配置VPS端的Rclone
下载相应的版本，并上传解压到`/url/bin`目录，然后

```yaml
chmod +x /usr/bin/rclone
rclone config
```

就进入了和官方版 rclone 一样的挂载程序，和国际版 onedrive 不同的是：
```yaml
client_id填写应用程序(客户端) ID，client_secret填写客户端密码。is_21vianet_version填true，Edit advanced config 以及 Use auto config 都选 no，
下一步粘贴上之前在 Windows 获取的 token({"access_token":"...","expriry":"..."})，继续按提示完成之后的步骤。
```

## 挂载
### 挂载为磁盘

```yaml
#安装 fuse
yum install fuse
#创建挂载目录,目录叫什么都可以
mkdir /root/OneDrive
#挂载为磁盘，下面的DriveName、Folder、LocalFolder参数根据说明自行替换
rclone mount DriveName:Folder LocalFolder --copy-links --no-gzip-encoding --no-check-certificate --allow-other --allow-non-empty --umask 000
```

`DriveName`为初始化配置填的`name`，`Folder`为`OneDrive`里的文件夹，`LocalFolder`为`VPS`上的本地文件夹。

如果挂载过程中出现`NOTICE: One drive root 'test': poll-interval is not supported by this remote`错误，可以无视该错误。

挂载成功后，输入`df -h`命令查看即可！

### 卸载磁盘
```
fusermount -qzu LocalFolder
```


## 开机自启（一种方式）
使用`Systemctl`守护进程，也只适用于`CentOS 7`、`Debian 8+`、`Ubuntu 16+`。

```yaml
#将后面修改成你上面手动运行命令中，除了rclone的全部参数
command="mount DriveName:Folder LocalFolder --copy-links --no-gzip-encoding --no-check-certificate --allow-other --allow-non-empty --umask 000"

```

```yaml
#以下是一整条命令，先修改DriveName:Folder和LocalFolder的值，再一起复制到SSH客户端运行
cat > /etc/systemd/system/rclone.service <<EOF
[Unit]
Description=Rclone
AssertPathIsDirectory=LocalFolder
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/rclone mount DriveName:Folder LocalFolder \
 --umask 0000 \
 --default-permissions \
 --allow-non-empty \
 --allow-other \
 --buffer-size 32M \
 --dir-cache-time 12h \
 --vfs-read-chunk-size 64M \
 --vfs-read-chunk-size-limit 1G
ExecStop=/bin/fusermount -u LocalFolder
Restart=on-abort
User=root

[Install]
WantedBy=default.target
EOF
```

开始启动：

```yaml
systemctl start rclone
```
设置开机自启：
```yaml
systemctl enable rclone
```
其他命令：
```yaml
重启：systemctl restart rclone
停止：systemctl stop rclone
状态：systemctl status rclone
```

如果你想挂载多个网盘，那么将`systemd`配置文件的`rclone.service`改成`rclone1.service`即可，重启动什么的同样换成`rclone1`。

## 其他玩法
在拥有国内较好的速度的世纪互联的Onedrive，还有其他的玩法，结合`Aria2`还有`Telegram`等，后面会慢慢补充。
