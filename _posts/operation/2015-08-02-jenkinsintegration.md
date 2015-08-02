---
layout: post
title: jenkins集成环境
ctime:
category:
tags:
---

[jenkins]: https://jenkins-ci.org/ "jenkins"
[sonar]: http://www.sonarqube.org/ "sonar"
[gerrit]: https://www.gerritcodereview.com/ "gerrit"
[git]: https://git-scm.com/ "git"

总体概述，通过[jenkins][jenkins]建立集成运行环境。配合[sonar][sonar]，[git][git]，[gerrit][gerrit]。

[Jenkins CI][gerrit]是从"Hudson Labs"演进过来，作为一个集成的部署运行服务。

[Sonar][sonar]全称SonarQube，一个管理代码质量的开放平台。主要涉及代码的结构设计(architecture & design)、重复率(duplications)，单元测试(unit tests)，复杂度(complexity)，潜在的问题(potential bugs)，代码规则(coding rules)，注释(comments)。

[Git][git]是为了快速有效的处理从小到大的工程而设计的一个免费开源的版本控制系统。

[Gerrit]是为git提供基本的代码查看和代码库管理。


<!-- more -->

下面开始搭建整个环境，时基于centos发行版的linux。
