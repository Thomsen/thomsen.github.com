---
layout: default
title: RoR 入门学习
---

### 开发版本 ###
+ **ruby** 2.0.0-p353  
+ **rails** 4.1.4

### 搭建项目 ###
1. 创建项目  
    `$ rails new blog`  
   使用rvm管理ruby，可以配置rvmrc指定版本。在项目的根目录下创建.rvmrc  
   首先创建rails的别名    
    `$ rvm gemset create rails414`  
   创建别名后，再使用ruby和别名的版本，最后安装rails对应的版本  
    `$ rvm use 2.0.0-p353@rails414`    
    `$ gem install rails -v 4.1.4`  
   在.rvmrc文件中添加  
    rvm use 2.0.0-p353@rails414  
   这样就通过rvm对ruby和rails对应起来进行管理。

<!-- more -->

2. 运行项目  
    `$ rails server`  
   问题：
   _gems/ruby-2.0.0-p353@rails414/gems/execjs-2.2.1/lib/execjs/runtimes.rb:51:in \`autodetect': Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)_  
   解决方式（debian）：  
    `$ curl -sL https://deb.nodesource.com/setup | sudo bash -`  
    `$ sudo apt-get install nodejs`

### 创建页面 ###
1. 欢迎首页  
   新建页面，产生控制器，视图，测试，帮助，资源  
    `$ rails generate controller welcome index`  
   在config/routes.rb指定首页面，新增  
    root "welcome#index"
   通过**rake routes**查看请求的路径。
2. 文章页面  
    `$ rails g controller posts`  
   在config/routes.rb新增  
    resources :posts  
   然后在控制器中加上CRUD的操作，并建立相应的视图文件。html.erb文件中如何进行多行注释，暂时没有找到解决方式。  
   建立new的视图，在new中submit后进入到create视图
3. 创建模型  
    `$ rails g model Post title:string text:text`  
   会生成数据库文件，模型文件，测试文件。接下来就是数据库的迁移  
    `$ rake db:migrate`  
   然后就可以在create的控制器中保存到数据库中，并进行重定向。过程中需要解决ForbiddenAttributesError,这是因为rails有几处安全特性帮助应用程序得到更好的安全，比如说强参数。
   重定向后，需要创建show视图，显示已经创建的博客。
4. 创建列表页  
   在控制器中添加index方法，并创建对应的index视图。
5. 添加不同页面的链接  
    {% highlight ruby %}<%= link_to "link desc", url %>{% endhighlight %}
   url说明，  
6. 添加校验  
   对模型中的一些字段可以相应的添加一些校验，如一些必填，长度限制等。提供了校验规则后，还需要在页面中对不符合规则给出相应的提示。  
   {% highlight ruby %} <% if @post.errors.any? %> {% endhighlight %}
   报undefined method `errors' for nil:NilClass，是因为在controlllers中的对应页面方法中，没有定义@post变量。  
7. 显示和编辑  
8. 嵌入页面  
   使用render关键字  
9. 删除  


{{ page.date | date_to_string }}
