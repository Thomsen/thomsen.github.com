---
layout: post
title: Heroku部署Rails项目
category: operation
tag: [heroku]
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

通过gem install安装，会出现
> !    The `heroku` gem has been deprecated and replaced with the Heroku Toolbelt.

```sh

$ hroku login

```

登录成功后，会添加ssh证书，可通过heroku keys查看，heroku keys:remove移除key。linux上要对.netrc设置权限。

```sh

$ sudo chmod 0600 ~/.netrc

```

由于linux可能有多个ssh key，所以指定一个新的，有意思的，名字为id_rsa.heroku。

```sh

$ ssh-keygen -t rsa
$ heroku keys:add

```

#### 2. 部署 ####

在已经有的rails项目中，执行

```sh

$ heroku create --http-git

$ git remote add heroku git@heroku.com:mibo.git

$ git push heroku master

```

remote add heroku需要在heroku添加mibo app才能找到对应的mibo.git。heroku编译需要Gemfile.lock文件，需要提交该文件。由于Heroku默认支持PostgreSQL，不支持SQLite，所以要将数据库做修改。

``` sh

$ bundle install --without production

``` 

应用部署后，查看应用是否正在运行，并且打开。

``` sh

$ heroku ps:scale web=1

$ heroku open

```

#### 3. 使用数据库 ####

3.1 查看组件

``` sh

$ heroku addons

```

3.2 查看配置

``` sh

$ heroku config

$ heroku pg

```

3.3 配置数据库pg，执行迁移

``` sh

$ heroku run rake db:schema:load

```

3.4 本地安装PostgresSQL，能够用psql命令

``` sh

$ heroku pg:psql

```

 !    No app specified.
 !    Run this command from an app folder or specify which app to use with --app
 APP.
__要在工程目录下运行__


3.5 多个项目共用一个数据库，

在heroku的管理页面，可以管理[databases](https://postgres.heroku.com/databases)。通过rails的database.yml配置数据，没有成功，部署到heroku后会自动生成配置文件去连接postgresql。

This behavior is only needed up to Rails 4.1. Any later version contains direct support for specifying a connection URL and configuration in the database.yml so we do not have to overwrite it.

升级rails到4.2.0.rc3，database.yml中使用url连接数据库，能够共享。部署成功后，删除项目使用的数据库。

3.6 addons的使用

``` sh

$ heroku addons | grep POSTGRES # 查看当前工程使用的数据库

$ heroku addons:remove heroku-postgresql:hobby-dev # 删除数据库

$ heroku addons:add heroku-postgresql:hobby-dev # 创建新数据库


```


#### 4. 绑定域名 ###

采用二级域名，采用CNAME解析类型，指向example.herokuapp.com。

``` sh

$ heroku domains:add mibo.thomsen.wang

```

访问[Mibo](http://mibo.thomsen.wang)


### 问题 ###

Heroku是一个“只读”的平台，所以类似的附件上传是无法实现的。要想实现该功能，可以借助第三方图片上传服务器。

Rails3.1之后引进了asset pipeline，静态资源能够自动产生。解决方式，在production.rb配置文件中，将config.assets.compile改为true。或者预先编译一次再提交到代码库中。

``` sh

$ rake assets:procompile RAILS_ENV=production

```
