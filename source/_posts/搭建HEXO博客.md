---
title: 搭建Hexo博客
date: 2019-03-17 17:46:55
tags: 建站
---
## 前言
-----------------------
我是一个入门的Blog主，暂时Blog中很多东西都是向其他博主那借鉴过来的，包括这篇搭建教程，很多内容也需要和大家一起探讨，blog的后续很多装饰也需要慢慢探索，希望大家能看到我的成长，最后自己生产出来一些内容，希望大家及时指正。


<!-- more -->


## Hexo的优势
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

## 关于Github
----------------------
+ Github的优点
    * Github是基于git实现的代码托管平台。git可能是目前最好用的版本控制系统，非常受欢迎。
    * Github可以免费使用，并且快速稳定。
    * Github上面有很多有趣的项目，也有很多和生活息息相关的内容，比如“996”(手动狗头)

+ 关于Github Page
    + Github Page是供用户编写的、托管在Github上的静态网页。

+ 为什么选择Github Page
    * 可以绑定自己的域名
    * 简单便捷，使用Github Page可以为你提供给一个免费的服务器，免去了自己搭建服务器和写数据库的麻烦。

## 安装`Node.js`
-----------------------------
在window上安装Node.js非常简单，在[官网](https://nodejs.org/en/download/)下载文件并执行安装即可。
![pict](Node_webpage.png)
我是window 64位系统，直接下载相应的版本，无脑下一步就行了，不需要另外配置环境变量。

## 安装Git
-------------------------------
去[Git官网](https://git-scm.com/download/win)根据你的电脑参数，下载对应版本。

下载完成，通过在命令行输入 `git version` 查看是否安装成功，有输出版本号说明安装成功。

鼠标右键菜单里就多了`Git GUI Here`和`Git Bash Here`两个按钮，一个是图形界面的Git操作，一个是命令行，我们选择`Git Bash Here`。

* 安装教程：[如何在windows下安装GIT](https://link.juejin.im/?target=http%3A%2F%2Fjingyan.baidu.com%2Farticle%2F90895e0fb3495f64ed6b0b50.html)
* Git入门教程：[Pro Git（中文版）](https://link.juejin.im/?target=http%3A%2F%2Fgit.oschina.net%2Fprogit%2F)、[教学](https://www.bootcss.com/p/git-guide/)


## Hexo
-------------------------------
Hexo是一个快速、简洁且高效的博客框架。Hexo使用Markdown（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。

+ Hexo安装
桌面右键鼠标，点击 `Git Bash Here`，输入一下命令安装
```yaml
npm install hexo-cli -g
npm install hexo-deployer-git --save
```
第一句是安装Hexo，第二句是安装Hexo部署到git page的deployer，两个都需要安装。


+ Hexo初始化配置
    1. 创建Hexo文件夹

        安装完成后，根据自己喜好建立目录（如D:\ROY\blog\myblog），直接进入D:\ROY\blog\myblog文件夹下右键鼠标，点击`Git Bash Here`，进入Git命令框，执行以下操作。
        ```yaml
        hexo init
        ```
        安装完成后，Hexo将会在指定文件夹中新建所需的文件。Hexo文件夹下的目录如下图所示：
        ![img](hexo_init_folder.png)

    2. 本地查看效果

        执行下面语句，执行完即可在浏览器中输入`localhost:4000`查看本地网页效果
        ```yaml
        hexo g
        hexo s
        ```
        ![img](the_first_page.png)


## 创建Github Page
----------------------
那么现在本地的博客已经搭建起来了，但是我们只可以通过本地连接查看我们的博客。那么我们现在需要做的就是把本地的博客发布到服务器上，让别人也可以连接我们的博客，而Github Pages就帮我完成了这件事情。但是Github Pages的代码就是寄存在Github上面的。那么接下来我们需要在Github上面创建一个新的项目。

### 一、注册Github账户
1.访问[Github首页](https://github.com)
2.点击右上角的Sign up，注册自己的账号

### 二、创建项目代码库
1.注册完登陆后，创建一个自己的Github Pages项目。点击 `New repository`
![imag](github_setting_new_rep.png)
**注意：Github中仅能使用一个同名仓库的代码托管一个静态站点。**
![imag](github_setting.png)

2.然后打开仓库创建一个`index.html`文件，先随意写上一些内容。
![](the_first_index.png)
3.这时候打开 `http://你的用户名.github.io`就可以看到你的站点了。
![](the_hello_world.png)
此时，只是暂时渲染了 `index.html`的内容，后面把`Hexo`的引擎渲染出来的文件部署上来就可以看到完整的blog内容了。

### 三、配置SSH key
关于 ssh 连接到 `github`部分的内容，可以参考[官方的文档](https://docs.github.com/cn/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh)，此处不多做赘述。

## 部署到GitHub
-------------------------------------
此处采用[`Next`](https://github.com/theme-next/hexo-theme-next)的blog模板进行部署。
![](Next_page.png)

1、`clone`模板文件下载
    在 博客的源目录下面运行
    ```cmd
    git clone https://github.com/theme-next/hexo-theme-next themes/next
    ```
    此时文件夹的tree是
    ```cmd
    .
    |-- _config.landscape.yml
    |-- _config.yml                ------>  blog的配置文件
    |-- db.json
    |-- node_modules
    |   |-- JSONStream
    |   |-- ......
    |   `-- wrappy
    |-- package-lock.json
    |-- package.json
    |-- public                   ----->  渲染出来的index.html放置文件夹
    |   |-- 2020
    |   |-- archives
    |   |-- css
    |   |-- fancybox
    |   |-- index.html
    |   `-- js
    |-- scaffolds
    |   |-- draft.md
    |   |-- page.md
    |   `-- post.md
    |-- source                    ---->  后面 内容编辑 文件夹
    |   `-- _posts
    `-- themes
        `-- next                   ---->  下载下来的 `next`模板
            |-- LICENSE.md
            |-- README.md
            |-- _config.yml       ----->  next模板的配置文件
            |-- crowdin.yml
            |-- docs
            |-- gulpfile.js
            |-- languages
            |-- layout
            |-- package.json
            |-- scripts
            `-- source
            |-- css
                |-- images         -----> 主题的 picture目录
                |-- js
                `-- lib
    ```

2、`Next`安装配置
+ **blog的配置文件**`_config.yml`中的修改
    + 使用 文本程序 打开当前目录下*blog的配置文件*`_config.yml`文件，在底端可以找到`theme`键，修改为`next`。
    ![](Change_ymal_theme_1.png)
    + 网页的总设置：
        + 网站的标题、作者等
        ![](blog_title_setting.png)

+ 在 **next模板的配置文件** `_config.yml`中：
    + `Next`有4个分支主题，可以在修改配置文件中的`scheme`，激活一个你喜欢的分支主题；
        ![](Change_ymal_next_1.png)
+ 头像在`themes\next\source\images`中同名替换`avatar`文件
+ 网站标签页图片：`themes\next\source\images`中的`favicon-16x16-next.png`文件同名替换。

3、网站关联GitHub
+ 在**blog的配置文件**`_config.yml`中的最后修改为
    ```yaml
    deploy:
      type: 'git'
      repository: git@github.com:username/username.github.io.git //username是github用户名
      branch: master
   ```
+ 添加域名
    + 在blog的源目录下 创建`CNRME`文件，无后缀，内容添加为 `域名`

4、部署运行
在源目录下分别执行
```cmd
hexo clean //清理缓存
hexo g  //生成静态页面
hexo d  // 网站push 到github上
```
这样就可在 你的域名上 欣赏你的blog了，加油，bloger！
