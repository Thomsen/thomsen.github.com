---
title: Docker 入门
layout: default
category:
tags: []
---

Debian Wheezy安装Docker
===

Docker要求linux kernel 3.8+，现wheezy 7.6用的是3.2，不过wheezy-backports现在用的是[kernel 3.14](https://packages.debian.org/wheezy-backports/linux-image-amd64)。

``` sh

$ sudo vi /etc/apt/sources.list.d/wheezy-backports.list

```

` deb http://http.debian.net/debian wheezy-backports main

``` sh

$ sudo apt-get update
$ sudo apt-get install -t wheezy-backports linux-image-amd64

```

linux-image-2.6-amd64，linux-image-amd64，linux-3.2.0-4-amd64会被删除，而fglrx也会被删除。

ERROR: could not insert 'cpuid': Unknown symbol in module, or unknown parameter (see dmesg)

gj linux-headers(/lib/modules) linux-image(/boot)

``` sh

$ curl -sSL https://get.docker.io/ | sh

```

The following NEW packages will be installed:
  aufs-tools lxc-docker lxc-docker-1.2.0

安装成功后，建立能够访问的用户组，添加用户到用户组。

``` sh

$ sudo groupadd docker
$ sudo usermod -aG docker $user

```

使用docker

``` sh

$ sudo docker login
$ sudo docker run ubuntu:14.04 /bin/echo 'run echo'

```

ubuntu:14.04的下载目录在哪里?

``` sh

$ sudo docker run -t -i ubuntu:14.04 /bin/bash

```
