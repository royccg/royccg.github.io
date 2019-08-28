---
title: 安装基于onedrive的在线网盘-—Pyone
date: 2019-05-17 13:21:25
tags: 建站
abstract: 基于Onedrive网盘的在线网盘搭建教程
---
之前博主介绍过一个OneDrive网盘的目录索引程序OneIndex，而且发了不少安装和使用教程了，介绍查看：[OneIndex](https://www.moerats.com/archives/592/)，今天再介绍个类似的工具[PyOne](https://wiki.pyone.me/)，基于Flask开发的，由于是模仿的OneIndex，自然功能就差不多，就是界面好看很多，后台也可以直接上传编辑文件，目前作者新增多网盘和离线下载，该功能刚出来，BUG肯定是有的，可以向作者反映修复下，这里说一下安装教程。

# 截图
---------------------
![picture](pyone网盘图.jpg)
![picture](pyone网盘图2.jpg)

# Demo地址
-------------------
https://www.pyone.me
# 特性
--------------------------
1.简单易用。只需简单设置，即可做一个onedrive文件列表分享程序
2.后台强大。
 * 防盗链设置。
 * 后台上传文件。
 * 后台更新文件。
 * 后台设置统计代码
 * 后台管理onedrive文件。
    - 删除onedrive文件
    - 直接在后台给文件夹添加`.password`和`README`和`HEAD`
    - 直接在后台编辑文本文件。
    - 上传本地文件至onedrive(2018.10.18更新）
    - 支持创建文件夹(2018.10.19更新）
    - 支持移动文件（仅限单文件）(2018.10.19更新）
 * 支持绑定多网盘！！！（2018.11.15更新）
 * 支持搜索文件！！！（2019.01.18更新）

# 安装
---------------------
Github地址：https://github.com/abbeyokgo/PyOne
帮助文档：https://wiki.pyone.me/
账号支持：只支持`onedrive`上夜班、教育版、个人版
环境要求：`Python2.7`、`Redis`、`Mongodb`、`Nginx`

1. 安装[宝塔](https://www.bt.cn/)
    ```yaml
    #Centos系统
    yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && bash install.sh
    #Ubuntu系统
    wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh
    #Debian系统
    wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh
    ```
    安装完成后，不需要进行初设置的那些安装。点击左侧软件管理，然后安装`Redis`、`Mongodb`、`Nginx`，其中`Debian`的linux版本安装`Mongodb`之前需要使用`apt install sudo`，不然可能出现`Mongodb`启动不了的情况。
2. 拉取源码
    ```yaml
    git clone https://github.com/abbeyokgo/PyOne.git
    ```
3. 安装依赖
    进入Pyone的文件夹，运行代码如下：
    ```yaml
    cd /root/PyOne
    pip install -r requirements.txt
    ```

4. 开始运行
    ```yaml
    #复制配置文件
    cp self_config.py.sample self_config.py
    cp supervisord.conf.sample supervisord.conf
    touch .install
    ```
    请保证运行的目录在root的目录下，不然则需要修改`self_config.py`中的`config_dir`参数和`supervisord.conf`的`directory`参数为正确的目录。
    ```yaml
    #运行
    gunicorn -w4 -b 0.0.0.0:34567 run:app
    ```
5. 安装Aria2
    ```yaml
    git clone https://github.com/abbeyokgo/aria2_installer.git
    cd aria2_installer
    sh install_aria2.sh
    ```

# 域名设置
点击左侧网站，添加站点，然后再点击添加好了的域名名称，这时候就进入了站点配置，点击反向代理，目标URL填入http://127.0.0.1:34567，再启用反向代理即可。

然后再点击配置文件，进行如下修改：  
```yaml
    #加上中间三句
    location / 
        {
            ...
            
            proxy_buffering off;
            proxy_cache off;
            proxy_set_header X-Forwarded-Proto $scheme;
                    
            ...
        }
```
最后就可以进入域名打开授权页面了。
![picture](PyOne5.png)![picture](PyOne6.png)
授权成功即可，首次访问，会显示登录后台，输入初始密码：`PyOne`后会自动跳转到绑定网盘页面。如果没有跳转到绑定网盘页面，可以按照：后台-文件管理-添加网盘进行下一步。

# 开机启动
网站源码下有个`supervisord.conf`，主要内容如下：
```yaml
[program:pyone]
command = gunicorn -k eventlet -b 0.0.0.0:34567 run:app
directory = /root/PyOne
autorestart = true
```
主要修改两个地方
```yaml
端口号：即34567那个端口号，修改为自己选的，或者不改动
源码目录：directory修改为你选的网站目录
```
修改之后运行下面的命令（记得修改为正确的目录），设置开机启动：
```yaml
echo "supervisord -c /root/PyOne/supervisord.conf" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
```
重启生效。

本次不用重启生效的方法：
```yaml
supervisord -c /root/PyOne/supervisord.conf
```

# 总结
目前来说该程序很不错，特别是加了多网盘和离线下载，作者更新也频繁，但BUG还是不少的，特别是离线下载。