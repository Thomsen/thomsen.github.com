---
layout: default
title: Heroku部署Rails项目
category: DevOps
tag: []
---

### 简介 ###

Heroku是云计算平台，提供免费的云空间，当然要想有好的性能还是要付出的。同类型的还有OpenShift，只是OpenShift支持的语言更多。Heroku现在支持部署的应用有ruby、php、js、python、java、clojure、scale。使用前需要在[官网](http://signup.heroku.com)上注册一个免费账户。

<!-- more -->


### 部署项目 ###

#### 前提条件 ####
* 免费的Heroku账号
* 在操作系统上安装了Ruby
* 安装了Bundler

#### 1. 设置 ###

在系统上安装Heroku Toolbelt工具或者通过gem安装heroku。已经安装过ruby的话，推荐使用gem安装，不然toolbelt还会安装ruby一次。安装成功后，可以运行heroku命令，登录heroku。

```sh

$ hroku login

```

登录成功后，会添加ssh证书，可通过heroku keys查看，heroku keys:remove移除key。

#### 2. 部署 ####

在已经有的rails项目中，执行

```sh

$ heroku create --http-git

$ git remote add heroku git@heroku.com:mibo.git

$ git push heroku master

```

remote add heroku需要在heroku添加mibo app才能找到对应的mibo.git。heroku编译需要Gemfile.lock文件，需要提交该文件。由于Heroku默认支持PostgreSQL，不支持SQLite，所以要将数据库做修改。

``` sh

$ bundle install --without product

``` 

应用部署后，查看应用是否正在运行，并且打开。

``` sh

$ heroku ps:scale web=1

$ heroku open

```

#### 3. 使用数据库 ####

查看组件

``` sh

$ heroku addons

```

查看配置

``` sh

$ heroku config

$ heroku pg

```

配置数据库pg，执行迁移

``` sh

$ heroku run rake db:schema:load

```

本地安装PostgresSQL，能够用psql命令

``` sh

$ heroku pg:psql

```

 !    No app specified.
 !    Run this command from an app folder or specify which app to use with --app
 APP.
__要在工程目录下运行__


#### 4. 绑定域名 ###

采用二级域名，采用CNAME解析类型，指向example.herokuapp.com。

``` sh

$ heroku domains:add mibo.thomsen.wang

```

访问[Mibo](http://mibo.thomsen.wang)