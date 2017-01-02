---
layout: post
title: GTD管理
ctime:
category: plan
tags: []
---

去年的差不多这个时候，制定了一项新的启航计划。回顾将近一年的时间，其中只完成了一部分。

1. ruby rails后台开发  -- 完成项目的构建，部署和登录功能。还需继续...

2. nosql系列数据库开发 -- 了解了一下mogodb开发部署，仅此而已

3. android客户端开发   -- 没有实现，仍需继续努力

4. ios客户端开发       -- 初学了ios开发，没有做客户端

<!-- more -->

为了能够很好的完成制定计划，需要好的时间管理方法。现在介绍GTD（Getting ThingsDone）一种管理方式，结合Ecmas + Org-mode工具。通过org-mode的todo管理任务安排，以达到更好的时间管理。GTD的核心原则是，**收集**、__整理__、**组织**、**回顾**、__执行__。

emac是神一样的编辑器，其关键并不在本身。而是能够结合很多插件，让你这一款编辑器可以做任何事情。org-mode能够让emacs编辑的内容以分级方式显示。并且支持写todo列表，这样就可以使用这个功能来制定将要做的事情。

emacs想要使用org-mode模式，需要首先安装org-mode插件，具体的安装方式可以通过网上寻找适合自己的。这里配置emacs中org todo的使用。

``` lisp
;; Org todo

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)")))) ; 设置全局的任务状态，如果org文档中没有默认配置#+SEQ_TODO: 。通过C-c C-t唤起。

(setq org-agenda-files (list "")) ; 添加默认的org todo文档，通过C-[ 添加，C-] 移除。

(defun org-summary-todo (n-done n-not-done)
  "switch entry to done when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states) ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))
    ))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo) ; 统计
```

说明：

TODO(t) -- 't' 快捷键
DONE(d!/!) -- '!' 切换到该状态时会自动添加时间戳
WAITING(w@/!) -- '@' 切换到该状态时会要求添加文字说明。这里同时加时间戳和文字说明。


#### 实际操作 ####

通过emacs新建一个org文档，存放到统一存储todo的目录。在文档中编写一条想要执行的事情。格式：

\* 将要做的事情

编写完成后，光标停留在该行文本上。执行C-c C-t，会出现几种任务的状态供选择，通过快捷键选择该任务当前的状态。这样，一个简单计划要做的事情就安排好了。可以通过 C-[ 添加到任务列表中。既可以通过 C-c a t 查看将要执行的任务。

设定子任务，也就是在一级列表下建立二级列表。格式：

\* 总任务 [%]

\*\* 任务A [/]

\*\*\* 任务A-a

\*\*\* 任务A-b

\*\* 任务B

上级任务标题中添加'[%]'或'[/]'，可以跟踪任务的状态。'%'以百分比的形式表示，'/'以比例的形式表示。
