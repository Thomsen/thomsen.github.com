---
layout: default
title: REST 架构
category: Web
tags: [设计，架构]
---

REST，Representational State Transfer，含状态传输。REST是设计风格而不是标准，SOAP是一个协议。REST通常基于使用HTTP、URI和XML以及HTML这些现有的广泛流行的协议和标准。

<!-- more -->

资源
--

* 资源由URI来指定
* 对资源的操作包括获取（GET）、创建（POST）、修改（PUT）和删除（DELETE）
* 通过操作资源点额表现形式来操作资源
* 资源的表现形式则是XML或者HTML，取决于读者是机器还是人，是消费web服务的客户软件还是web浏览器。当然也可以是任何其他格式，如JSON、YAML。



状态
--

需要区别应用的状态和连接状态。HTTP连接是无状态的（也就是不记录每个连接的信息），而REST传输会包含应用的所有状态信息，因此可以大幅度降低对HTTP连接的重复请求资源消耗。

含状态传输的Web服务，也称RESTful Web API
> - 直观简短的资源地址，URI
> - 传输的资源，Web服务接收与返回的互联网媒体类型
> - 资源的操作，Web服务在该资源上所支持的一系列请求方法

典型用途
--

* 一组资源的URI

比如http://example.com/resources/

GET：列出URI，可以是每个资源的详细信息；

POST：在本组资源中创建或追加一个新的资源，返回该新资源的URI；

PUT：使用一组资源替换该整组资源；

DELETE：删除整组资源。

* 单个资源的URI

比如http://example.com/resources/23

GET：获取指定资源的详细信息，可以是任意一种网络媒体格式；

POST：把指定的资源当成一个资源组，并在其下创建或追加一个新的资源，隶属当前资源组；

PUT：替换或创建指定的资源，并将其追加到相应的资源组；

DELETE：删除指定资源。



GET、PUT和DELETE方法时幂等方法，幂等是不考虑如错误或者过期等问题的情况下，若干次请求的副作用与单次请求相同或者根本没有副作用。
GET方法时安全方法，安全方法是除了进行获取资源信息外，这些请求不应当再有其他意义。


Rails 实例
--

Rails 1.2以后的版本开始支持REST model。


* REST风格的URL
 
`/examples` 和 `/exampels/1`

在路由中，通过\*\*\*_path表示一个url。嵌套资源点额URL，通过路由。

	map.resources :examples do |example|
	example.resources :subs
	end


* 传统方式的URL

`/examples/new`、`/exemples/show/1`、`/examples/delete/1` 和 `/examples/update/1`

