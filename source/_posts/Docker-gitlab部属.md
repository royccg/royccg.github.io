---
title: Docker-gitlab部属
date: 2020-12-10 20:37:00
tags:
		 - vps
		 - Docker
		 - gitlab
         - git
---

## 前言
最近在折腾`Git`,想对自己的代码版本进行托管和版本控制，准备在Ubuntu server 利用Docker上搭建一个`GitLab`。

### 平台
+ 操作系统： Ubuntu 20.04.1 server
+ Docker Version ：20.10.0, build 7287ab3
+ Gitlab Version：13.6.2

<!-- more -->

## Docker
docker用来隔离应用还是比较方便的，一来本身的操作较为简单，二来资源占用也比虚拟机要小的多，三来是较为安全。

### 安装Docker
我采用的是Ubuntu 20发行版本
此处采用 国内daocloud 一键安装命令：

```bash
curl -sSL https://get.daocloud.io/docker | sh
```
或者使用 官方的安装脚本自动安装
```bash
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

注意： 如果要使用 Docker作为非root用户使用，则应考虑使用以下方式将用户添加到`docker`组：
```bash
sudo usermod -aG docker your-user
```

### 更换源
国内的镜像源有
+ docker官方中国区 `https://registry.docker-cn.com`
+ 网易 `http://hub-mirror.c.163.com`
+ ustc `http://docker.mirrors.ustc.edu.cn`
+ 阿里云 `http://<你的ID>.mirror.aliyuncs.com`

通用的方法就是编辑`/etc/docker/daemon.json`：
```bash
{
  "registry-mirrors" : [
    "http://registry.docker-cn.com",
    "http://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com"
  ],
  "insecure-registries" : [
    "registry.docker-cn.com",
    "docker.mirrors.ustc.edu.cn"
  ],
  "debug" : true,
  "experimental" : true
}
```
然后重启`docker`即可。
```bash
service docker restart
```


## Gitlab安装
### 下载镜像
 使用如下命令可以使 Docker安装 Gitlab 镜像
  gitlab 镜像分为两个版本：
  + gitlab-ce 社区版
  + gitlab-ee 企业收费版
  此处采用社区版本即可，直接安装官方镜像，拉取`gitlab-ce`源
  ```bash
  docker pull gitlab/gitlab-ce
  ```

### 创建目录
通常会将Gitlab的配置(etc)、日志(log)、数据(data)放在容器之外，便于日后升级，因此先准备这三个目录
```bash
mkdir -p /srv/gitlab/config
mkdir -p /srv/gitlab/logs
mkdir -p /srv/gitlab/data
```

### 启动运行
```bash
docker run --detach \
  --hostname 192.xxx.xx.xx \
  --publish 8443:443 --publish 8880:8880 --publish 8222:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  --privileged=true \
  gitlab/gitlab-ce:latest
```
说明：
+ --hostname gitlab.example.com: 设置主机名或域名
+ --publish 8443:443：将http：443映射到外部端口8443
+ --publish 8880:8880：将web：8880映射到外部端口8880 （此处两个端口号必须一致，不然后面有问题）
+ --publish 8222:22：将ssh：22映射到外部端口8222
+ --name gitlab: 运行容器名
+ --restart always: 自动重启
+ --volume /srv/gitlab/config:/etc/gitlab: 挂载目录
+ --volume /srv/gitlab/logs:/var/log/gitlab: 挂载目录
+ --volume /srv/gitlab/data:/var/opt/gitlab: 挂载目录
+ --privileged=true 使得容器内的root拥有真正的root权限。否则，container内的root只是外部的一个普通用户权限

运行成功之后，可以使用下面的命令查看容器运行状态：
```bash
docker ps -a
```
可以看到 GitLab 已经在运行了，有一个属性 STATUS 为 health: starting，说明 gitlab 的服务正在启动中，还没有启动完毕。等这个状态变成 healthy 时则说明已经部署完成，可以访问了。


### 访问
gitlab启动成功后，浏览器访问http://ip:8880, 即可访问。为了使用域名访问，需要配置nginx：
```
upstream gitlab{
    server 127.0.0.1:8880;
}

server {
    listen 80;
    server_name  gitlab.example.com;
    access_log     /var/log/nginx/gitlab.example.com-access.log;
    error_log     /var/log/nginx/gitlab.example.com-error.log;
    location / {
        proxy_pass_header Server;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_pass http://gitlab;
    }
}
```
nginx重启配置生效后，浏览器访问http://gitlab.example.com 即可正常访问。（此处 并没有尝试）

首次访问需要为root用户设置密码，设置完成后需要登录，默认用户名为：root， 密码为刚刚设置的密码。

### 配置邮件服务器
想要让 GitLab 给你发送邮件，还要配置一下邮件服务器，这里以QQ邮箱的 IMAP/SMTP服务 来配置。

打开邮箱->设置->账户，然后开启 IMAP/SMTP服务，然后根据文档获取 授权码 ，这步比较重要。

```
### Email Settings
gitlab_rails['smtp_enable'] = true # 开启 SMTP 功能
gitlab_rails['smtp_address'] = "smtp.qq.com"
gitlab_rails['smtp_port'] = 465 # 端口不可以选择587，测试过会发送邮件失败
gitlab_rails['smtp_user_name'] = "test@qq.com" # 你的邮箱账号
gitlab_rails['smtp_password'] = "1324dasd" # 授权码，不是密码
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
gitlab_rails['gitlab_email_from'] = 'test@qq.com' # 发件人信息，必须跟‘smtp_user_name’保持一致，否则报错
gitlab_rails['smtp_domain'] = "qq.com" # 修改并不影响
```
配置完成后保存，然后输入下面的命令使配置生效。
```bash
sudo docker exec gitlab gitlab-ctl reconfigure
```
使配置生效之后我们可以使用 gitlab 自带的工具进行一下测试。依次执行下面的命令：
```bash
# 开启 gitlab 的 bash 工具
$ docker exec -it gitlab bash

# 开启 gitlab-rails 工具
$ gitlab-rails console production

# 发送邮件进行测试
Notify.test_email('test_001@123.com', 'Message Subject', 'Message Body').deliver_now
```
测试完成之后退出gitlab的bash工具，重启 gitlab 即可。
```bash
docker restart gitlab
```

### 配置Git仓库访问路径
在之前第一次运行 gitlab 容器的时候，有一个参数 hostname 为 gitlab.example.com , 如果配置了域名可以忽略这一步，如果你没有配置相应域名的话，你的仓库的地址将会变为下面这样：
```bash
ssh : git@gitlab.example.com:test/test.git
http：gitlab.example.com/test/test.git
```
如果域名不存在的话，这个地址是无法进行 clone 的。

为了解决这个问题，我们可以设置成 IP 或 你配置了的域名来访问。

打开文件 `/srv/gitlab/config/gitlab.rb` 文件并找到
```
external_url 'GENERATED_EXTERNAL_URL'
```
这行，去掉注释，并按照下面的格式修改。
```
# ip 形式
external_url 'http://192.168.1.44'

# 域名形式
external_url 'http://JemGeek.com'

# 子域名
external_url 'http://gitlab.JemGeek.com'

# 其他形式
external_url 'http://JemGeek.com/gitlab'
```

如果 使用`ip:8880`登录，则external_url和nginx['listen_port']的端口需要和第一步的映射端口对应。

```

// 修改如下语句
external_url 'http://ip:8880'

# https需要下面这句
# nginx['redirect_http_to_https_port'] = 8880

nginx['listen_port'] = 8880
nginx['listen_addresses'] = ['*']

gitlab_rails['gitlab_ssh_host'] = '192.168.20.132'
```

### 重启镜像

```
docker restart gitlab
```

### 升级
参照官方的说明，将原来的容器停止，然后删除：
```bash
docker stop gitlab
docker rm gitlab
```

然后重新拉一个新的版本的镜像下来
```bash
docker pull gitlab/gitlab-ce
```

然后使用原来的运行命令运行：
```
docker run --detach \
  --hostname 192.xxx.xx.xx \
  --publish 8443:443 --publish 8880:8880 --publish 8222:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  --privileged=true \
  gitlab/gitlab-ce:latest
```

<!-- 实际使用的命令，备份 -->
<!-- ```
docker run -itd \
 --publish 8443:443 \
 --publish 8880:8880 \
 --publish 8222:22  \
 --name gitlab   \
 --restart unless-stopped  \
 -v /srv/gitlab/config:/etc/gitlab \
 -v /srv/gitlab/logs:/var/log/gitlab  \
 -v /srv/gitlab/data:/var/opt/gitlab  \
 gitlab/gitlab-ce
``` -->

GitLab 在初次运行的时候会自动升级， 为了预防万一， 还是建议先备份一下 `/srv/gitlab/` 这个目录。

大版本升级（例如从 8.7.x 升级到 8.8.x）用上面的操作有可能会出现错误， 如果出现错误可以尝试登录到容器内部, 依次执行下面的命令：

```bash
gitlab-ctl reconfigure
gitlab-ctl restart
```
