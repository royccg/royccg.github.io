---
title: 搭建Hexo博客
date: 2019-03-17 17:46:55
tags: 建站
abstract: 使用github Page和Hexo搭建自己独立blog的教程，介绍了如何使用和配置Hexo框架，如何将Hexo部署到自己的Github项目中，以及域名的注册，绑定。
---
# 前言
-----------------------
我是一个入门的Blog主，暂时Blog中很多东西都是向其他博主那借鉴过来的，包括这篇搭建教程，很多内容也需要和大家一起探讨，blog的后续很多装饰也需要慢慢探索，希望大家能看到我的成长，最后自己生产出来一些内容，希望大家及时指正。

# Hexo的优势

----------------------------------------------------------

* 本身的优势

  正如[Hexo官网](<https://hexo.io/zh-cn/>)的描述：

  - 快速、简洁、高效的博客框架
  - 支持Markdown语法
  - 丰富的插件

* 与Jekyll的对比

  - Hexo官方有中文开发文档，而JekyII只有中文翻译文档且更新慢
  - JekyII的依赖环境总是出现问题
  - Hexo有详细且丰富的第三方接口

# 关于Github
----------------------
## 一、 Github的优点
* Github是基于git实现的代码托管平台。git可能是目前最好用的版本控制系统，非常受欢迎。
* Github可以免费使用，并且快速稳定。
* Github上面有很多有趣的项目，也有很多和生活息息相关的内容，比如“996”(手动狗头) 

## 二、关于Github Page
Github Page是供用户编写的、托管在Github上的静态网页。

## 三、为什么选择Github Page
* 可以绑定自己的域名
* 简单便捷，使用Github Page可以为你提供给一个免费的服务器，免去了自己搭建服务器和写数据库的麻烦。

# 安装`Node.js`
-----------------------------
在window上安装Node.js非常简单，在[官网](https://nodejs.org/en/download/)下载文件并执行安装即可。
![pict](https://user-gold-cdn.xitu.io/2018/1/20/161117c6feba58fd?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)
我是window 64位系统，直接下载相应的版本，无脑下一步就行了，不需要另外配置环境变量。

# 安装Git
-------------------------------
去[Git官网](https://git-scm.com/download/win)根据你的电脑参数，下载对应版本。

下载完成，通过在命令行输入 `git version` 查看是否安装成功，有输出版本号说明安装成功。

鼠标邮件菜单里就多了`Git GUI Here`和`Git Bash Here`两个按钮，一个是图形界面的Git操作，一个是命令行，我们选择`Git Bash Here`。
![img](https://upload.cc/i1/2019/05/19/CoKA4E.jpg)![img](https://upload.cc/i1/2019/05/19/Jg1aUA.jpg)

* 安装教程：[如何在windows下安装GIT](https://link.juejin.im/?target=http%3A%2F%2Fjingyan.baidu.com%2Farticle%2F90895e0fb3495f64ed6b0b50.html)
* Git入门教程：[Pro Git（中文版）](https://link.juejin.im/?target=http%3A%2F%2Fgit.oschina.net%2Fprogit%2F)

* Git基本操作：
![ima](https://user-gold-cdn.xitu.io/2018/1/20/161117c725a598e9?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

# Hexo
-------------------------------
Hexo是一个快速、简洁且高效的博客框架。Hexo使用Markdown（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。

## 一、 Hexo安装
桌面右键鼠标，点击 `Git Bash Here`，输入一下命令安装
```yaml
npm install hexo-cli -g
npm install hexo-deployer-git --save
```
第一句是安装Hexo，第二句是安装Hexo部署到git page的deployer，两个都需要安装。


## 二、 Hexo初始化配置
1. 创建Hexo文件夹

安装完成后，根据自己喜好建立目录（如D:\ROY\blog\myblog），直接进入D:\ROY\blog\myblog文件夹下右键鼠标，点击`Git Bash Here`，进入Git命令框，执行以下操作。
```yaml
hexo init
```
安装完成后，Hexo将会在指定文件夹中新建所需的文件。Hexo文件夹下的目录如下图所示：
![ima](https://user-gold-cdn.xitu.io/2018/1/20/161117c7293a169d?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

2. 本地查看效果

执行下面语句，执行完即可在浏览器中输入`localhost:4000`查看本地网页效果
```yaml
hexo g
hexo s
```
![ima](https://user-gold-cdn.xitu.io/2018/1/20/161117c72acc46d2?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

# 将博客部署到Github Page上
----------------------
那么现在本地的博客已经搭建起来了，但是我们只可以通过本地连接查看我们的博客。那么我们现在需要做的就是把本地的博客发布到服务器上，让别人也可以连接我们的博客，而Github Pages就帮我完成了这件事情。但是Github Pages的代码就是寄存在Github上面的。那么接下来我们需要在Github上面创建一个新的项目。

## 一、注册Github账户
1.访问[Github首页](https://github.com)
2.点击右上角的Sign up，注册自己的账号

## 二、创建项目代码库
1.注册完登陆后，创建一个自己的Github Pages项目。点击 `New repository`
