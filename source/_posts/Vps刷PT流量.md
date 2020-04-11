---
title: Vps刷PT流量
date: 2019-05-02 14:58:41
tags: PT
# header_image: url(https://img.xjh.me/random_img.php)
abstract: 使用VPS来完成PT站的新手任务。
---
最近迷上了使用PT做种，其中很多PT站都需要完成新手任务。为了完成新手任务，并且是自动做种，考虑使用vps来自动做种。网上有很多不同的工具，本文章使用Transmission和FlexGet自动刷PT流量，使用Debian和Ubuntu的系统，在CentOS上的刷PT流量教程，考虑在后面重新做一期。
**本文章只适用Debian9和Ubuntu16以上的系统**
<!-- more -->
# 一、安装Transmission
```yaml
    apt-get update
    apt-get install transmission-daemon -y
```
现在开始修改配置，需要先停止运行Transmission：
```yaml
    /etc/init.d/transmission-daemon stop
    vim /var/lib/transmission-daemon/info/settings.json
```
需要修改的部分如下：
```yaml
    rpc-username 帐号
    rpc-password 密码
    "rpc-authentication-required": true
    "rpc-whitelist-enabled": false
    "preallocation": 0
```
启动程序：
```yaml
    /etc/init.d/transmission-daemon start
```
通过http://ip:9091，可以访问transmission的webui。

# 二、安装FlexGet
依次执行：
```yaml
    apt-get install -y python-pip python-setuptools
    pip install --upgrade pip
    pip2 install flexget
```

注：本人在Openvz上执行 upgrade pip时，总是显示 “locale.Error: unsupported locale setting”

原因是语言环境配置出错，执行一下的语句：
```yaml
root@ubuntu:~# locale
    locale: Cannot set LC_ALL to default locale: No such file or directory
    LANG=en_US.UTF-8
    LANGUAGE=
    LC_CTYPE="en_US.UTF-8"
    LC_NUMERIC=zh_CN.UTF-8
    LC_TIME=zh_CN.UTF-8
    LC_COLLATE="en_US.UTF-8"
    LC_MONETARY=zh_CN.UTF-8
    LC_MESSAGES="en_US.UTF-8"
    LC_PAPER=zh_CN.UTF-8
    LC_NAME=zh_CN.UTF-8
    LC_ADDRESS=zh_CN.UTF-8
    LC_TELEPHONE=zh_CN.UTF-8
    LC_MEASUREMENT=zh_CN.UTF-8
    LC_IDENTIFICATION=zh_CN.UTF-8
    LC_ALL=

export LC_ALL=C
    root@ubuntu:~# locale
    LANG=en_US.UTF-8
    LANGUAGE=
    LC_CTYPE="C"
    LC_NUMERIC="C"
    LC_TIME="C"
    LC_COLLATE="C"
    LC_MONETARY="C"
    LC_MESSAGES="C"
    LC_PAPER="C"
    LC_NAME="C"
    LC_ADDRESS="C"
    LC_TELEPHONE="C"
    LC_MEASUREMENT="C"
    LC_IDENTIFICATION="C"
    LC_ALL=C
```

配置FlexGet:
```yaml   
    mkdir /root/.flexget
    vim /root/.flexget/config.yml
```
其中，编辑文本时，可以采用vi、vim和nano，看个人喜好。

FlexGet的配置文件示例：
```yaml
    tasks:
      mt:
        rss: https://tp.m-team.cc/torrentrss.php?https=1&rows=10&linktype=dl&passkey=xxxxxxxxxxxxxx
        accept_all: yes
        content_size:
          min: 256
          max: 4000
        download: /var/lib/transmission-daemon/torrents
        transmission:
          host: 127.0.0.1
          port: 9091
          username: username
          password: "password"
      ttg:
        rss: https://totheglory.im/putrss.php?par=xxxxxxx&ssl=yes
        accept_all: yes
        content_size:
          min: 256
          max: 4000
        download: /var/lib/transmission-daemon/torrents
        transmission:
          host: 127.0.0.1
          port: 9091
          username: username
          password: "password"
```
以上内容表示，只下载文件大小在256MB和4000MB之间的种子，**用户名和密码为之前配置的transmission的。**rss为pt网站订阅的rss地址。一般选择所有的就行了，TTG等网站需要注意最好不要覆盖那些带H&R的内容（剧集）。

此处没有严格按照缩进原则，就会出现问题。**[要注意的是，由于配置文件是YAML格式，需要遵循YAML语法，也就是说，千万不要使用tab来缩进，一定要用空格。缩进是一定要遵守的，每个层级之间用两个空格缩进。](https://www.tok9.com/archives/285/)**

多个任务，在后面添加即可。

因为没有这个种子文件下载目录，需要先创建：
```yaml
    mkdir /var/lib/transmission-daemon/torrents
```
FlexGet配合transmission还需要插件支持：
```yaml
    pip2 install transmissionrpc
```
FlexGet简单命令：
```yaml
    flexget check ： 用于检查 config.yml 配置文件是否有格式错误。
    flexget execute ： 手动开始一次 RSS 下载，就等于正式 RSS 了一次。
```
可以执行一次flexget check，一般是没有问题的。

添加自动任务：
```yaml
    crontab -e
```
在其中添加：
```yaml
    */5 * * * * /usr/local/bin/flexget -c /root/.flexget/config.yml execute
```
表示每5分钟更新一次RSS。

# 三、自动删除种子文件
先创建Sheell文件：
```yaml   
    vim trans_cleanup.sh
```
其中内容为：
```yaml
    #! /bin/bash
    #====================================================================
    # trans_cleanup.sh
    #
    # Copyright (c) 2011, WangYan <webmaster@wangyan.org>
    # All rights reserved.
    # Distributed under the GNU General Public License, version 3.0.
    #
    # Monitor disk space, If the Over, delete some files.
    #
    # See: http://wangyan.org/blog/trans_cleanup.html
    #
    # V0.2, since 2012-10-29
    #====================================================================
     
    # The transmission remote login username
    USERNAME="username"
     
    # The transmission remote login password
    PASSWORD="password"
     
    # The transmission download dir
    DLDIR="/var/lib/transmission-daemon/downloads"
     
    # The maximum allowed disk (%)
    DISK_USED_MAX="90"
     
    # Enable auto shutdown support (Disable=0, Enable=1)
    ENABLE_AUTO_SHUTDOWN="0"
     
    # Log path settings
    LOG_PATH="/var/log/trans_cleanup.log"
     
    # Date time format setting
    DATA_TIME=$(date +"%y-%m-%d %H:%M:%S")
     
    #====================================================================
     
    dist_check()
    {
        DISK_USED=`df -h $DLDIR | grep -v Mounted | awk '{print $5}' | cut -d '%' -f 1`
        DISK_OVER=`awk 'BEGIN{print('$DISK_USED'>'$DISK_USED_MAX')}'`
    }
     
    dist_check
     
    if [ "$DISK_OVER" = "1" ];then
            for i in `transmission-remote --auth $USERNAME:$PASSWORD -l | grep 100% | grep Done | awk '{print $1}' | grep -v ID`
            do
                    [ "$i" -gt "0" ] && echo -n "$DATA_TIME [Done] " >> $LOG_PATH
                    transmission-remote --auth $USERNAME:$PASSWORD -t $i --remove-and-delete >> $LOG_PATH 2>&1
                    [ "$i" -gt "0" ] && sleep 10 && dist_check
                    [ "$DISK_OVER" = "0" ] && break
            done
    fi
     
    if [ "$DISK_OVER" = "1" ];then
            for ii in `transmission-remote --auth $USERNAME:$PASSWORD -l | grep Stopped | awk '{print $1}' | grep -v ID`
            do
                    [ "$ii" -gt "0" ] && echo -n "$DATA_TIME [Stopped] " >> $LOG_PATH
                    transmission-remote --auth $USERNAME:$PASSWORD -t $ii --remove-and-delete >> $LOG_PATH 2>&1
                    [ "$ii" -gt "0" ] && sleep 10 && dist_check
                    [ "$DISK_OVER" = "0" ] && break
            done
    fi
     
    if [ "$DISK_OVER" = "1" ];then
            for iii in `transmission-remote --auth $USERNAME:$PASSWORD -l | grep -v Sum | awk '{print $1}' | grep -v ID`
            do
                    [ "$iii" -gt "0" ] && echo -n "$DATA_TIME [Up or Down] " >> $LOG_PATH
                    transmission-remote --auth $USERNAME:$PASSWORD -t $iii --remove-and-delete >> $LOG_PATH 2>&1
                    [ "$iii" -gt "0" ] && sleep 10 && dist_check
                    [ "$DISK_OVER" = "0" ] && break
            done
    fi
     
    if [ "$DISK_OVER" = "1" ];then
            rm -rf $DLDIR/*
    fi
     
    if [ "$ENABLE_AUTO_SHUTDOWN" = "1" ];then
            SHUTDOWN=1
            for STATUS in `transmission-remote --auth $USERNAME:$PASSWORD -l | awk '{print $9}'`
            do
                    if [[ "$STATUS" = "Up" || "$STATUS" = "Uploading" ]];then
                            SHUTDOWN=0
                    fi
            done
            TASK_TOTAL=`transmission-remote --auth $USERNAME:$PASSWORD -l | grep -Ev '(ID|Sum)' | wc -l`
            if [ "$TASK_TOTAL" -gt "0" ] && [ "$SHUTDOWN" -eq "1" ];then
                    echo -n "$DATA_TIME " >> $LOG_PATH
                    shutdown now >> $LOG_PATH 2>&1
            fi
    fi
```
自行修改其中的username和password，以及DISK_USED_MAX=”90″，这个数值表示最大可占用的硬盘空间，超过以后就会自动删除pt种子。不要设置太大，谨防下载速度太快爆硬盘，会导致服务器无法连接。

创建自动任务，在crontab里添加：
```yaml       
    */1 * * * * /bin/bash /root/trans_cleanup.sh
```   
每分钟检查一次硬盘空间占用。

**注意：如果硬盘空间太小，可能会导致每个种子的分享率不高，按需要调节每个种子文件大小限制，或者减少添加的task。**

文中内容，参考转载自：[https://www.ljchen.com/archives/963](https://www.ljchen.com/archives/963)