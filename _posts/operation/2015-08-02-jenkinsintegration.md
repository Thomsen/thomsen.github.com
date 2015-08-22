---
layout: post
title: Jenkins集成环境
ctime: 2015-08-22 17:28
category:
tags:
---

[jenkins]: https://jenkins-ci.org/ "jenkins"
[sonar]: http://www.sonarqube.org/ "sonar"
[gerrit]: https://www.gerritcodereview.com/ "gerrit"
[git]: https://git-scm.com/ "git"
[apache]: http://httpd.apache.org "httpd"
[tomcat]: http://tomcat.apache.org "tomcat"

总体概述，通过[jenkins][jenkins]建立集成运行环境。配合[sonar][sonar]，[git][git]，[gerrit][gerrit]。

[Jenkins CI][gerrit]是从"Hudson Labs"演进过来，作为一个集成的部署运行服务。

[Sonar][sonar]全称SonarQube，一个管理代码质量的开放平台。主要涉及代码的结构设计(architecture & design)、重复率(duplications)，单元测试(unit tests)，复杂度(complexity)，潜在的问题(potential bugs)，代码规则(coding rules)，注释(comments)。

[Git][git]是为了快速有效的处理从小到大的工程而设计的一个免费开源的版本控制系统。

[Gerrit][gerrit]是为git提供基本的代码查看和代码库管理。


<!-- more -->

下面开始搭建整个环境，是基于centos发行版的linux。


1、jenkins环境配置

jenkins基于tomcat运行，tomcat运行需要jdk支持。

1.1 jdk安装

centos中安装jdk有两种方式，一种安装openjdk；一种安装oracle jdk。

安装openjdk直接通过yum命令安装即可

``` sh
$ yum search openjdk # 搜索相关openjdk包
$ sudo yum install [package_name]
```

安装oracle jdk（推荐），通过oracle官网下载对应的[jdk安装包](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

选择对应的版本和平台，例如支持rpm的jdk-8u60-linux-x86.rpm

下在rpm包后，可通过rpm命令安装

``` sh
$ sudo rpm -ivh jdk-8u60-linux-x86.rpm
```

也可通过其他方式安装jdk。安装成功后，可能需要配置环境变量$JAVA_HOME。如果系统有多个版本的jdk，还需要update-alternatives配置当前使用的java版本。


1.2 tomcat安装

下载选择的[tomcat版本][tomcat]，解压到指定目录。如果需要的话，还可以为该目录建立指定的用户。

通过'$CATALINA_HOME/bin/startup.sh' 启动tomcat。


1.3 jenkin配置

下载jenkins的[war包](http://mirros.jenkins-ci.org/war-stable/latest)，放入tomcat的webapps目录下。

运行tomcat即可。

2、gerrit环境配置

gerrit依赖于jdk，database，git。jdk在安装tomcat时已经安装。database使用postgresql数据库。

2.1 postgresql安装

postgresql可以通过yum进行安装

``` sh
$ sudo yum install postgresql-server
```

启动postgresql服务

``` sh
$ sudo service postgresql initdb
```

postgresql默认建立postgres用户，用该用户可以登录psql。此用户为系统用户，一开始需要设置登录密码。

``` sh
$ sudo passwd postgres
```

登录psql，需要修改

"/var/lib/pgsql/data/postgresql.conf"

listen_addresses="*"

"var/lib/pgsql/data/pg_hba.conf"

host    all    all   ::1/128    md5

``` sh
$ psql -hlocalhsot -Upostgres -W
```

如若不行，可以切换到postgres用户下，登录psql

``` sh
$ psql
```

登录后，可以创建数据库用户。

2.2 git安装

通过yum命令安装

``` sh
$ sudo yum install git
```

部署git代码仓库，位于"/var/repos"

``` sh
$ sudo mkdir /var/repos & cd /var/repos
$ sudo chown group:user repos
$ git clone --base reponame reponame.git
```

2.3 gerrit安装

下载gerrit war包[gerrit-2.8.war](https://gerrit-releases.storage.googleapis.com/gerrit-2.8.war), 需要翻墙。

通过war包安装gerrit到指定目录"/opt/gerrit"

``` sh
$ sudo java -jar gerrit-2.8.war init -d /opt/gerrit
```

过程中需要配置

* location of git repositories
* database
* authentication method
 * method header, listen, proxy
* smtp server
* run user
* java runtime

运行服务

``` sh
$ sudo ln -s /opt/gerrit/bin/gerrit.sh /etc/init.d/gerrit
$ sudo chkconfig -add gerrit
$ /etc/init.d/gerrit start
```

成功配置运行后，就可以访问gerrit服务了。



3、sonar环境配置

sonar依赖于postgresql，postgresql在安装gerrit时已经安装。

下载[sonarqube](http://www.sonarqube.org/downloads)，找到最新版本或则长期支持版本下载。如[sonarqube-4.5.5.zip](http://downloads.sonarqube.com/sonarqube/sonarqube-4.5.5.zip)。

解压下载好的zip包到指定目录，如"/opt/sonar"。

配置数据库访问(postgresql)，"/opt/sonar/conf/sonar.properties"

sonar.jdbc.username=

sonar.jdbc.password=

sonar.jdbc.url=jdbc:postgresql://localhost/dbname

在postgresql中创建数据库dbname，运行bin下对应系统架构的sonar.sh，启动sonar。


``` sh
$ sudo unzip sonarqube-4.5.5.zip -d /opt/sonar
$ cd /opt/sonar
$ ./bin/linux-x86-32/sonar.sh
```

4、jenkins集成

在jenkins的manage jenkins通过manage plugins管理插件。

集成sonar，需要安装插件

+ Jenkins sonar plugins


集成gerrit，需要安装插件

+ Gerrit Trigger
+ Hudson Gerrit plugin

配置sonar，manage jenkins -> configure system

在sonar一栏中，选中advance配置

- Server URL
- Sonar account login
- Sonar account password
- Database URL
- Database login
- Database password
- Database driver

配置gerrit

gerrit trigger，manage jenkins -> gerrit trigger

- Frontend URL
- SSH Port
- Username
- E-mail
- SSH Keyfile
- SSH Keyfile Password

配置好后测试，连接是否成功

job -> configure -> *

在每个建立的工作集成中，需要对其详细的配置:

比如源码管理，如git。使用gerrit build分支时，需要设置Branches to build = $GERRIT_BRANCH

Additional Behaviours可以选择策略，Gerrit Trigger or Gerrit-Plugin，Branch name is $GERRIT_BRANCH。

Build Triggers选择Gerrit event。

Gerrit Trigger配置Gerrit project。
