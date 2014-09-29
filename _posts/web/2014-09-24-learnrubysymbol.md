---
layout: default
title: Ruby Symbol
category: Web
tags: []
---

### Symbol What ###

Ruby中Symbol表示“名字”，比如字符串的名字，标识符的名字。一个Symbol对象是在字符串或者标识符前面加上冒号。

<!-- more -->

通过object\_id观察，每个String对象都是不同的，即便他们包含相同的字符串内容；每个symbol对象，一个名字（字符串内容）唯一确定一个Symbol对象。创建Symbol对象的字符串中不能含有'\0'字符。

定义一个实例变量时，Ruby会自动创建一个Symbol对象。如@test对应为:@test。

Symbol一旦定义将一直存在，直到程序执行退出。所有Symbol对象放在Ruby内部的符号表中，可以通过类方法Symbol.all_symbols得到当前Ruby程序中定义的所有Symbol对象，返回一个数组。

String可以通过'[]='方式改变，而Symbol则不行。使用to\_s或id2name方法可以讲Symbol转成String对象，String可以通过to_sym或intern方法转成Symbol对象。

### Symbol Use ###

* Use Symbol

使用的字符串内容可能发生变化。

* Use String

使用固定的名字或者说是标识符。比如枚举值、关键字（哈希表关键字、方法的参数）等

哈希表例子

``` ruby

hts {
  'keyone' => 'valueone',
  'keytwo' => 'valuetwo'
}

``` 

如果使用keyone的值，使用hts["keyone"]。但如果频繁的使用该值，ruby会对每一次引用生成一个String对象，累积下来开销相当大。这时，就可以考虑使用Symbol，hts[:keyone]。

``` ruby

hts {
  :'keyone' => 'valueone',
  :'keytwo' => 'valuetwo'
}

```


### Symbol How ###
