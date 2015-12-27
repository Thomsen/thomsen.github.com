---
layout: post
title: ejabberd 环境搭建
category: life
tags: [opeation]
---

### 概述 ###


ejabberd是基于xmpp通信协议的一类实现。实现端对端之间的通信。

<!-- more -->

### 目标 ###

本文预实现在阿里云上搭建一套ejabberd服务器。

### 准备 ###

1. 阿里云ECS服务器,ubuntu系统环境

2. erlang编译环境

3. mysql数据库

4. 相关源码，[erlang][erlang] [ejabberd][ejabberd]

[erlang]: https://github.com/erlang/otp "erlang"

[ejabberd]: https://github.com/processone/ejabberd "ejabberd"

#### [阿里云](http://www.aliyun.com/) ####

在阿里云申请一台ECS云服务器，前期可以免费体验15天的服务器。在[帮助页面](https://help.aliyun.com/document_detail/get-started/ecs/get-started/login.html)点击免费体验，登录阿里云。免费试用选择配置中，操作系统选择ubuntu 14.04 64位。

开通ECS实例后，在阿里云的web管理控制台中重新设置密码。即可以选择一个ssh客户端连接上ECS云服务器。

``` sh
$ ssh root@(公网IP)
```

建立新的系统用户组和用户ejabberd。

``` sh
# groupadd ejabberd
# useradd -g ejabberd -d /home/ejabberd ejabberd
# pwsswd ejabberd
# visudo -f /etc/sudoers
```

#### erlang ####

编译ejabberd需要erlang环境，通过源码编译erlang。

编译前准备，使用ejabberd登录ECS云服务器。

``` sh
$ sudo apt-get install make autoconf libssl-dev unixodbc-dev g++ libncurses5-dev
```

下载源码及编译

``` sh
$ git clone https://github.com/erlang/otp.git
$ cd otp
$ ./otp_build autoconf
$ ./configure
$ make
$ sudo make install
```

至此，操作系统与编译环境已经准备完毕。由于ejabberd选择运行在mysql上，这里需要安装mysql服务器。

``` sh
$ sudo apt-get install mysql-server-5.6
```

安装过程中，设置root账户密码。安装好后，建立ejabberd数据库及用户ejabberd。

``` sh
$ mysql -uroot -p
> create database ejabberd;
> grant all privileges on ejabberd.* to 'ejabberd@localhost' indentified by 'password';
```

### 安装 ###

经过系统环境和编译环境的准备，现在可以正式编译ejabberd源码。编译前，需要安装一些依赖包。

``` sh
$ sudo apt-get install libexpat1-dev libyaml-dev
```

下载源码及编译安装

``` sh
$ git clone git://github.com/processone/ejabberd.git
$ cd ejabberd
$ ./autogen.sh
$ ./configure --enable-mysql
$ make
$ sudo make install
```

通过交互方式运行ejabberd

``` sh
$ sudo ejabberdctl live
```

### 配置 ###

为了能够让ejabberd能够使用mysql数据库，及需要一个系统账户进行登录，需要对ejabberd配置文件做一些更改。

``` sh
$ sudo vi /etc/ejabberd/ejabberd.yml
```

``` text
auth_method: odbc

hosts:
  - "ip"

acl:
  admin:
    user:
      - "user": "ip"

host_config:
  "ip":
     auth_method: odbc
     allow_multiple_connections: false
     anonymous_protocol: login_anon
```
