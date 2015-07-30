---
layout: post
title: React Native
ctime: 2015-07-30 23:43
category: mobile
tags: [hybrid]
---

### 搭建react native的运行环境 ###

react native还没有很好的运行环境，现在借助于ionic-cli及cordova建立基于react native的开发环境。

ionic和cordova都是基于node进行安装的，系统首先要安装node，通过nvm安装node并管理。

<!-- more -->

基于linux版本

1、安装nvm

``` sh
$ git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm&& git checkout `git describe --abbrev=0 --tags`
```

在终端的配置文件中添加：

> export NVM_DIR="~/.nvm" # ~ 替换为真正的用户目录  
> [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

2、安装node

``` sh
$ nvm install version # version 对应的版本，可通过nvm ls-remote查看可安装的版本
```

3、安装cordova，ionic

``` sh
$ npm install -g cordova ionic
```

4、创建项目

``` sh
$ ionic start helloworld blank --id com.example.helloworld
```

5、下载reactjs

在[下载页面](https://facebook.github.io/react/downloads.html)下载reactjs官方库。

替换www/lib下的ionic库。

6、使用reactjs

接下来在index.html就可以使用reactjs方式开发前台页面。


