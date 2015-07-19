---
layout: post
title: Github Blog
category: tools
tag: [ruby markdown]
---

很长时间没有更新博客了，能够再次更新博客。特别记录在[github](https://github.com)上如何记录博客开始。Github为我们提供了一个很好的平台，可以表达自己的思想，记录学习的点滴，并将其分享出来。

在Github上创建属于自己的博客分为几步：

1、拥有一个自己的github账号；  
2、创建属于自己的博客代码仓库；  
3、克隆代码库使用github pages；  
4、建立hexo项目迁移到github pages；  
5、配置访问路径，如果有可能添加域名访问。

[git]: https://git-scm.com/download/
[node]: https://nodejs.org/
[hexo]: https://hexo.io/

工具：

+ [git][git] 版本控制器
+ [node][node] 前端开发工具管理器
+ [hexo][hexo] 博客主题管理工具

<!-- more -->

### 创建github账号 ###

github创建账户很简单，只需要填写用户名，邮箱，密码即可。且密码还不需要重复输入进行确认。[注册地址][github]

[github]: https://github.com "github"

假设我们在这里注册一个用户，用户名为__bloguser__。

### 创建代码仓库 ###

登录账户后，创建一个代码库，点击new repository，进入[创建页面](https://github.com/new)，该页面需要登录后才能找到，不然报404错误。

在创建页面，创建名为__bloguser.github.io__的代码仓库。

同时可以添加代码库的描述（可选），想要创建私有代码库，需要升级账户。也可选择创建
README文件。

接着将代码仓库中的代码克隆到本地

``` sh

$ git clone https://github.com/bloguser/bloguser.github.io.git

```

或者将本地项目与远程github的代码库关联

``` sh

$ git remote add origin https://github.com/bloguser/bloguser.github.io.git

```

添加本地更改到远程代码库，在commit前需要添加user.name和user.email。

``` sh

$ git push -u origin master

```

上述是在git命令下进行，windows也可在github for windows客户端下操作。

使用github pages的分支方式访问页面，首先在github的代码库下通过settings自动生成project site，生成过程中可以选择相应的模板。如果已经显示you site is published at ... 需要确定是否生成后覆盖本分支。

检出分支

``` sh

$ git fetch origin
$ git checkout gh-pages

```

如果同时建立bloguser.github.io和bloguser.github.com两个代码库，将会以bloguser.githubio为标准。并且在该库中建立gh-pages后，是无法访问的，访问的还是master。gh-pages现用与其他项目的访问目录，可通过'bloguser.github.io/projectName'访问。

即使建立bloguser.github.com也不能够通过bloguser.github.com访问，同样bloguser.github.io访问，同时还在代码库中添加CNAME。而且也不是通过建立分支访问。


### 配置heko ###

通过hexo初始化博客项目，例如blog

``` sh

$ hexo init blog
$ cd blog
$ npm install
$ npm serve -p 4001

```

创建博客，会在_posts目录下生成markdown文件。

``` sh

$ hexo new 'new blog'

```

生成静态页面，将markdown文件生成html、css静态文件。

``` sh

$ hexo generate

```


### 整合github pages ###

安装 hexo deployer git

``` sh

$ npm install hexo-deployer-git --save

```

配置_config.yml

>> \# Deployment  
>> \#\# Docs: http://hexo.io/docs/deployment.html  
>> deploy:  
>>  type: git  
>>  repository: git@github.com:bloguser/bloguser.github.io.git  
>>  branch: master

生成ssh访问密钥，并在github账户的设置中添加密钥。

``` sh

$ ssh-keygen -t rsa -b 4096 -C 'email'
$ ssh -T git@github.com

```

增加ssh key到ssh-agent，如果ssh -T git@githu.com失败的话

``` sh

$ ssh-add ~/.ssh/id_rsa*

```

部署到分支上，部署前都需要生成静态资源

``` sh

$ hexo deploy -g

```


### 访问路径 ###

如果你注册了一个域名，可以在博客代码库中添加CNAME文件，将域名添加到CNAME。并在域名的管理服务中，添加CNAME的域名解析，用一级域名的话主机名为'@'，指向bloguser.github.io。

