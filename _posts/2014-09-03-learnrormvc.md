---
layout: default
title: RoR MVC
category: 网站
tags: [ruby, rails, mvc]
---

rails的指导思想：

* __不自我重复__，系统中的每个功能都要有单一、准确、可信的实现，这样代码才能更易维护，更具扩展行，也不容易出问题；

* __多约定，少配置__，rails为大多数需求都提供了最好的解决方法，使用这些默认的约定，不用在长长的配置文件中设置每个细节。


模型(M)
==

Active Record，主要负责创建和使用需要持存入数据库中的数据。采用对象光系映射，把程序中的对象和关系型数据库中的数据表连接起来。默认的命名约定：

* 模型的类名（首字母大写）转换成复数变成数据表（下划线分隔）。如果不想用默认的命名规定，可通过self.table\_name设定，测试中调用set\_fixture_class。

* 外键，使用singularized\_table\_id形式命名；主键，默认情况下使用整数字段id作为表的主键。

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

控制器(C)
===
