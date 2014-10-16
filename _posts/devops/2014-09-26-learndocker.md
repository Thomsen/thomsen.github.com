---
title: Docker 入门
layout: default
category: DevOps
tags: [Docker]
---

Debian Wheezy安装Docker
===

Docker要求linux kernel 3.8+，现wheezy 7.6用的是3.2，不过wheezy-backports现在用的是[kernel 3.14](https://packages.debian.org/wheezy-backports/linux-image-amd64)。

<!-- more -->

``` sh

$ sudo vi /etc/apt/sources.list.d/wheezy-backports.list

```

添加wheezy-backports.list配置文件，编辑内容` deb http://http.debian.net/debian wheezy-backports main contrib。main分支主要是用来更新linux-image，linux-headers。contrib分支用来更新virtualbox，因为更新linux-image到3.14后，virtualbox module编译有问题，无法加载module。接着更新内核

``` sh

$ sudo apt-get update
$ sudo apt-get install -t wheezy-backports linux-image-amd64

```

更新的过程会将老板的linux-image删除，同时fglrx和virtualbox关联了linux-headers，升级过程同时也删除了fglrx和virtualbox。最后出现error，不用管它。


ERROR: could not insert 'cpuid': Unknown symbol in module, or unknown parameter (see dmesg)

> 对内核升级的理解，内核升级的linux-image升级过后在/boot目录下产生对应的内核启动文件。如果同时升级linux-headers，则会在/lib/modules目录下产生对应内核加载模块。

*升级过程遇到的问题，升级后导致virtualbox module加载失败，重新升级virtualbox即可。同样fglrx module无法加载，导致系统启动后，无法进入到登录页面。重新安装linux-image和linux-headers（3.0.2），然后编译fglrx到内核模块，这样就可以通过linux-image-3.0.2内核启动到图形界面。*

内核升级完成后，可以安装docker。


``` sh

$ curl -sSL https://get.docker.io/ | sh

```

该段命令，其实就是添加apt-get可更新的地址，并通过apt-get进行安装，会安装几个与docker相关的包：
The following NEW packages will be installed:
  aufs-tools lxc-docker lxc-docker-1.2.0

安装成功后，建立能够访问的用户组，添加用户到用户组。

``` sh

$ sudo groupadd docker
$ sudo usermod -aG docker $user

```

准备工作完成后，可以使用docker了。

``` sh

$ sudo docker login
$ sudo docker run ubuntu:14.04 /bin/echo 'run echo'

```

docker login，登录到docker hub上。  
docker run，运行对应镜像的可执行命令，如果本地对应镜像没有的话，会相应的pull。而且还会在hub上记录信息。

ubuntu:14.04的下载目录在哪里?

``` sh

$ sudo docker run -t -i ubuntu:14.04 /bin/bash

```

docker run -t -i，进入对应镜像的交互界面。

stop container 后 delete ，不让rmi image 会报container using it。
