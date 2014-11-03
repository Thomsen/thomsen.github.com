---
layout: default
title: RoR 入门学习
category: Web
tag: [ruby, rails]
---

### 开发版本 ###
+ **ruby** 2.0.0-p353  
+ **rails** 4.1.4

### 搭建项目 ###

* 创建项目

``` sh
$ rails new blog
```
使用rvm管理ruby，可以配置rvmrc指定版本。在项目的根目录下创建.rvmrc，为了能够使用rvm管理，还需要事先做准备。首先创建rails的别名

``` sh
$ rvm gemset create rails414
```
创建别名后，再使用ruby和别名的版本，最后安装rails对应的版本

``` sh
$ rvm use 2.0.0-p353@rails414
$ gem install rails -v 4.1.4
```
在.rvmrc文件中添加`rvm use 2.0.0-p353@rails414`。这样就通过rvm对ruby和rails对应起来进行管理。

<!-- more -->

* 运行项目

``` sh
$ rails server
```
问题：_gems/ruby-2.0.0-p353@rails414/gems/execjs-2.2.1/lib/execjs/runtimes.rb:51:in \`autodetect': Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)_

解决方式（debian）：

``` sh
$ curl -sL https://deb.nodesource.com/setup | sudo bash -
$ sudo apt-get install nodejs
```

### 基本页面 ###

* 欢迎首页

新建页面，产生控制器，视图，测试，帮助，资源

``` sh
$ rails generate controller welcome index
```
在config/routes.rb指定首页面，新增`root "welcome#index"`，通过

``` sh
$ rake routes
```
查看请求的路径

* 文章页面

```sh
$ rails g controller posts
```
在config/routes.rb新增`resources :posts`，然后在控制器中加上CRUD的操作，并建立相应的视图文件。html.erb文件中进行多行注释:

``` html
<%#= %> <% #%>
<!--
<p> </p>
-->
``` 
建立new视图，在new中submit后进入到create视图。
   
* 创建模型

```sh
$ rails g model Post title:string text:text
```
会生成数据库文件，模型文件，测试文件。接下来就是数据库的迁移

``` sh
$ rake db:migrate
``` 
然后就可以在create的控制器中保存到数据库中，并进行重定向。过程中需要解决ForbiddenAttributesError,这是因为rails有几处安全特性帮助应用程序得到更好的安全，比如说强参数。

重定向后，需要创建show视图，显示已经创建的博客。

* 创建列表页

在控制器中添加index方法，并创建对应的index视图。

* 添加链接

``` ruby
<%= link_to "link desc", url %>
```
url说明，通过rake routes查看uri映射。可以得到prefix，使用prefix\_path可以访问对应的uri。

*  添加校验

对模型中的一些字段可以相应的添加一些校验，如一些必填，长度限制等。提供了校验规则后，还需要在页面中对不符合规则给出相应的提示。

``` ruby
<% if @post.errors.any? %>
```
报undefined method `errors' for nil:NilClass，是因为在controlllers中的对应页面方法中，没有定义@post变量。

* 显示和编辑

根据对应的id显示和编辑对应项。

* 嵌入页面

使用render关键字，render只是简单的页面渲染，并不会发送任何请求，不会执行action请求或重新加载服务器数据。

* 删除

### 知识点 ###

<%= %> 输出一个变量的值，将expression的返回结果添加到当前位置。

<% %> 执行脚本命令，如条件。只是演算expression，对erb的结果不做任何修改，可看做statement。

在4.1.4中使用<% form_for %>需要使用<%= %>

### 调试项目 ###

* 如何调试erb

使用Aptana Studio 3进行调试，出现问题:_Configured browser /usr/bin/iceweasel does not support debugging. Current only Firefox is supported_.

正常选择的浏览器有chrome、firefox、opera、ie、safari、netscape。使用opera同样出现上述的问题。需要安装ruby-debug-ide：

``` sh
$ gem sources a url
$ gem install ruby-debug-ide
```
但是在linux下，aptana studio 3的gear仍然没能出现Debug Server。_是由于没有建立rails project，web project无该选项_。

aptana studio运行rails server，需要script/rails。但是4.1.4版本script已经改为了bin，这样就无法运行rails server。

解决方案：**新建script目录，将bin/rails拷贝到script下。debug运行，出现cannot load such file -- debase (LoadError)。需要安装debase

``` sh
$ gem install debase
```
这样，debug server就可以调试erb。  

{{ page.date | date_to_string }}

