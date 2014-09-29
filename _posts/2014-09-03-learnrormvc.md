---
layout: default
title: RoR MVC
category: 网站
tags: [ruby, rails, mvc]
---

rails的指导思想：

* __不自我重复__

系统中的每个功能都要有单一、准确、可信的实现，这样代码才能更易维护，更具扩展行，也不容易出问题；

* __多约定，少配置__

rails为大多数需求都提供了最好的解决方法，使用这些默认的约定，不用在长长的配置文件中设置每个细节。

<!-- more -->

模型(M)
==

Active Record，主要负责创建和使用需要持存入数据库中的数据。采用对象光系映射，把程序中的对象和关系型数据库中的数据表连接起来。默认的命名约定：

* 模型的类名（首字母大写）转换成复数变成数据表（下划线分隔）

如果不想用默认的命名规定，可通过self.table\_name设定，测试中调用set\_fixture_class。

外键，使用singularized\_table\_id形式命名；主键，默认情况下使用整数字段id作为表的主键。

* 读写数据

创建，new方法创建一个新对象，create方法创建新对象并将其存入数据库。save方法保存记录到数据库。
读取，all查看所有，first查看第一条，find_by根据条件查等等。
更新，先读取，然后赋值保存。删除，destory销毁对象并从数据库中删除。
create、save、update方法会做数据验证，对应的爆炸方法method!。爆炸方法更严格，会抛RecordInvalid异常，正常的校验返回false。

* 数据迁移

迁移文件存储在db/migrate文件夹中，文件名采用YYYYMMDDHHMMSS_filename.rb形式。

``` sh
$ rails generate migration (ActiveRecord::Migration)
```
生成迁移文件。模型生成器和脚手架生成器会生成合适的迁移，创建模型。在生成器中，字段后面可以在花括号中添加选项（limit，precision，scale，polymorphic，null）。

编写迁移，create\_table方法创建数据表，create\_join\_table创建联合数据表，change_table修改数据表。

``` sh
$ rake db:migrate VERSION=YYYYMMDDHMMSS
```

运行指定版本的迁移。或者`db:migrate:up/down/change，指定任务运行。RAILS_ENV指定环境运行迁移。

``` sh
$ rake db:rollback STEP=num
```
撤销前几次的迁移。

* 回调

对象都有生命周期，可以被创建、更新和销毁。而回调可以在对象的状态改变之前和之后触发指定的逻辑，是在生命周期的特定时刻执行。使用回调之前，主要先注册。可用的回调，before\_validation、after\_validation、before\_save、around\_save、before\_create、around\_create、after\_create、after\_save、before\_update、around\_update、after\_update、after\_save、before\_destroy、around\_destroy、after\_destroy。创建和更新对象时都会触发after\_save，总在after\_create和after\_update之后执行。另外还有after\_initialize（对象初始化）、after\_find、after\_touch（触碰对象）。另外和数据验证一样，回调也是可跳过的。还有就是关联回调、条件回调和事务回调。

* 关联

关联是两个Active Record模型之间的关系。关联使用宏的方式实现，用声明的形式为模型添加功能。rails支持六种关联，belongs\_to（一对一的关系）、has\_one（一对一的关系，但语义和结果有点不一样）、has\_many（一对多的关系）、has\_many :through（多对多的关系）、has\_one :through（一对一的关系，通过第三模型）、has\_and\_belongs\_to\_many（多对多的关系，不借第三模型）。还有一种高级用法，多太关联，在同一个关联中，模型可以属于其他多个模型。模型与自己关联是自连接方式。

关联中需要注意：缓存控制，避免命名冲突，更新模式，控制关联的作用域，Bi-directional associations（双向关联）。

* 查询

rails执行查询是大多数情况下，无需直接使用SQL。

视图(V)
==

Action View是Action Pack的一个主要组件。请求由Action Pack分两步处理，其中一步交给视图（渲染视图）。Action View用来构建响应，由嵌入html的ruby代码编写。为了保证模板代码的简洁明了，Action View提供了很多帮助方法，用来构建表单、日期和字符串等。Action View并不依赖Action Record，有独立的代码库，可以再任何Ruby代码库中使用。

每个控制器在app/views中都对应一个文件夹，用来保存该控制器的模板文件。模板文件的作用是显示控制器动作的视图。

* 模板

模板可使用多种语言编写。如.erb是由erb和html，.builder是由Builder::XmlMarkup。erb中<% %>引入无返回值的ruby代码，<%= %>引入有输出结果的ruby代码。builder需要更多地编程，特别适合生成xml文档，可以直接使用名为xml的XmlMarkup对象。默认情况下，rails会把各个模板都编译成一个方法，这样才能渲染视图。

* 局部布局

局部视图把整个渲染过程分成多个容易管理的代码片段。想在视图中使用局部视图，可以调用render方法。局部视图的一种用法是作为子程序，把细节从视图中移出，这样能更好的理解视图的作用。render的几种操作，as（本地变量指定不同的名字）、object（直接在局部视图中使用对象）、collection（渲染集合）、spacer\_template（间隔模板）。

* 布局

布局用来渲染rails控制器动作的页面整体结构。指定控制器所用布局，使用layout方法。`layout "page" 使用app/views/layouts/page.html.erb文件作为布局。指定布局同时可以使用:only和:except选项，作为条件布局。


除了能够渲染视图外，还能够渲染文本、HTML、JSON、XML、普通的JavaScript、原始的主体（body）。render能够接收:content\_type、:layout、:location、：status四个选项。

渲染视图时，会把视图和当前模板结合起来。布局中可以使用三种工具把各部分结合在一起组成完整的响应：
> - 静态资源标签（auto\_discovery\_link\_tag、javascript\_include\_tag、stylesheet\_link\_tag、image\_tag、video\_tag、audio\_tag）
> - yield和content\_for（yiled标明一个区域，渲染的视图会插入这里。content\_for在布局的具名yield区域插入内容）
> - 局部视图

* 表单

页面中最常见的是表单，最基本的表单帮助方法时form\_tag。表单的一个特别常见的用途是编辑或创建模型对象。这时可以使用*\_tag帮助方法，但太麻烦了，每个元素都要设置正确的参数名称和默认值。rails提供很多帮助方法可以简化这一过程，例如text\_field（text\_field_tag)和text\_area。还有更好的方式，将表当绑定到对象上，可以使用form\_for。

rails框架建议使用rest架构设计程序，因此除了get和post请求之外，还要处理patch和delete请求。但大多数浏览器不支持表单中提交get和post之外的请求。rails使用post请求进行模拟，并在表单中加入\_method的隐藏字段，其值表示真正希望使用的请求方法。使用select和option标签快速创建选择列表。表单中上传文件，表单的编码必须设为"multipart/form-data"。

控制器(C)
===

Action Controller是Action Pack的另一个主要组件。请求有Action Pack分两步处理，其中一步交给控制器（逻辑处理）。Action Controller的作用是和数据库通信，根据需要执行CRUD操作。路由决定使用哪个控制器处理请求，控制器负责解析请求，生成对应的请求。

从控制器的角度，创建http的响应由三种方式：
> - 调用render方法，向浏览器发送一个完整的响应
> - 调用redirect\_to方法，向浏览器发送一个http重定向状态吗
> - 调用head方法，向浏览器发送只含报头的响应

执行到redirect_to方法时，代码会停止运行，等待浏览器发起新的请求。并需要告诉浏览器下一个请求是什么，并返回302状态码（临时重定向）。

控制器的命名习惯是，最后一个单词使用复数形式，但也有例外（ApplicationController)。程序接收到请求时，路由决定运行哪个控制器和哪个动作，然后创建该控制器的实例，运行和动作同名的方法。在控制器的动作中，往往需要获取用户发送的数据，或其他参数。在网页程序中参数分为两类：
> * 第一类随URL发送，叫做”请求参数”，即URL中?符号后面的部分
> * 第二类经常成为“POST”数据， 一般来自用户填写的表单

rails不区分这两种参数，在控制器中都可以通过params hash获取。

* 参数

参数可分为hash数组参数、json参数、路由参数、健壮参数

加入健壮参数功能后，action controller的参数禁止在active model中批量赋值，除非参数在白名单中。你需要明确选择那些属性可以批量更新，避免意外把不该暴露的属性暴露了。允许使用标量值，若params中有:id，且:id是标量值，就可以通过白名单检查（permit)，否则:id会被过滤掉。嵌套参数，也可以传入嵌套参数。

* 会话

程序中的每个用户都是一个会话，可以存储少量数据，在多次请求中永久存储。会话只能在控制器和视图中使用，CookieSotre、CacheStore、ActiveRecordStore、MemCacheStore。rails不允许在url中传递会话id，这么做不安全。

* Cookies

程序可以再客户端存储少量数据（称为cookie），在多次请求中使用，甚至可以用作会话。删除会话中的数据是把键的值设为nil，但要删除cookie中的值，要使用cookies.delete(:key)方法。

* 其他

过滤器（filter）是一些方法，在控制器动作运行之前、之后、或者前后运行。过滤器会继承，如果在ApplicationController中定义过滤器，那么程序的每个控制器都可以使用。

跨站请求伪造（CSRF)是一种工具方式，A网站的用户伪装成B网站的用户发送请求，在B站中添加、修改或删除数据，而B站的用户绝然不知。防止这种攻击的第一步是，确保所有析构动作（create，update和destroy）只能通过get之外的请求方式访问。如果遵从REST架构，已经完成了这一步。我们还需要添加一个只有自己的服务器才知道的难以猜测的令牌，去禁止访问。

每个控制器都有两个存取方法，分别用来获取当前请求的请求对象（request）和响应对象（response）。

Rails内建了两种http身份认证方式，基本认证（http\_basic\_authenticate\_with)和摘要认证(authenticate\_or\_request\_with\_http\_digest)。

所有控制器都可以使用send\_data和send\_file方法将文件以数据流发送给用户。

捕获错误后如果想要更详尽的处理，可以使用rescue\_form。rescue\_form可以处理整个控制器及其子类中的某种（或多种）异常。

有时，基于安全考虑，可能希望某个控制器只能通过https协议访问。为了达到这个目的，可以在控制器中使用force_ssl方法。也可指定:only和：except选项。

路由映射，resources会创建七种不同的路由：GET(all)、GET(new)、POST(create)、GET(:id)、GET(:id edit)、PATCH/PUT(:id udpate)、DELETE(:id destroy)。resource单数路由，会生成六中路由，除GET(all)。嵌套路由，resources do end。路由中还可以构建REST架构动作（成员路由、集合路由，额外新建动作的路由）。除资源式路由外，还有非资源式路由get。