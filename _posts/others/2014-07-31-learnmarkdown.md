---
layout: default
title: Emacs Markdown模式
category: Others
tag: [emacs, markdown]
---

markdown的初始化
==============

-------------------------------------------------------------------------------

emacs 通过elpa插件管理进行安装，新建一个el文件init-markdown.el

``` lisp
(require-package 'markdown-mode)
(setq auto-mode-alist  
    (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))
(provide 'init-markdown)  
```
这样，当emacs打开一个后缀为md或markdown的文件，就会自动启动markdown模式。[Standard Makdown](http://standardmarkdown.com/)

<!-- more -->

markdown的命令
=============

-------------------------------------------------------------------------------

掌握了默认的markdown快捷方式，就可以更快的将想要的格式输出来。


有命令模式
------

### 区块元素 ####

* 插入header样式的标题

C-c C-t h (markdown-insert-header-dwim) ##### 标题 #####

C-c C-t H (markdown-insert-header-setext-dwim) ##### 标题 #####

C-c C-t n (markdown-insert-header-atx-n, n\[1-6\]) # 标题 #

C-c C-t !\t (markdown-insert-header-setext-1) 标题\n==

C-c C-t @\s (makrdown-insert-header-setext-2) 标题\n--

* 插入引用  

C-c C-s C-b (markdown-insert-blockquote) > 引用

C-c C-s p (markdown-insert-pre)  预览

C-c C-s C-p (markdown-pre-region） 区域

* 插入水平线

C-c - (markdown-insert-hr) -------------------------------------------------------------------------------

### 区段元素 ####
* 插入链接

C-c C-a l (makrdown-insert-link)  [链接]()

C-c C-a L\r (markdown-insert-reference-link-dwim) [链接][]

C-c C-a u (markdown-insert-uri) <链接>

C-c C-a f (markdown-insert-footnote) [^1]

C-c C-a w （markdown-insert-wiki-link） [[维基]]

* 插入图片

C-c C-i i (makrdown-insert-image) !![说明]()

C-c C-i I (markdown-insert-reference-image) ![说明][id]
  
* 插入样式  

C-c C-s s (markdown-insert-bold） **加粗**

C-c C-s e (markdown-insert-italic） *斜体*

C-c C-s c (markdown-insert-code) `代码`

### 其他 ####

辅助命令：
> - Element removal
> - Promotion, Demotion, Completion, and Cycling
> - Following and Jumping
> - Indentation (C-c > | C-c <)
> - Visibility cycling
> - Header navigation (C-c C-p)
> - Buffer-wide commands (C-c C-c m)j
> - List editing
> - Mobement
> - Alternative keys (in case of problems with the arrow keys)

语法高亮：

通过jekyll默认的使用pygments实现语法高亮，区块上要有空行，前面不需要空格。  
\`\`\` language  
\`\`\`

或

{% highlight sh %}
{% endhighlight %}
  

无命令模式
-----

### 区块元素 ####

+ 段落和换行

空一行就是下一个段落的开始，换行通过两个以上的空格实现。用空格实现强迫换行，会使段落的缩进比较难看;

+ 列表

主要分为无序列表（*、+、-）和有序列表（1.），与段落间要有空行(或换行），不让会当作段落处理；有序列表时要注意段落的开头要和列表的缩进保持一致，不然就不会形成有序列表；

jekyll解析有序列表的问题，如果列表强制换行，段落与列表对齐，可以解决有序的问题。但是，序号后就会有很大的空白，与段落对齐的原因。通过空行后序列号就有问题。

有时，不要错误的将列表作为标题使用。

+ 代码区块

建立缩进通过4个空格或1个制表符

### 区段元素 ####

- 强调

使用*或_包围实现强调，可以多个。如果 * 或 _ 两边都有空白，则会当作普通字符。


markdown的大纲视图
---------------------

通过Shift-Tab 可以在emacs查看markdown的大纲视图、目录视图、及正常的视图。

markdown的预览
-----------

在系统中安装markdown程序包，如：

``` sh
$ sudo apt-get install markdown
```

然后，在emacs中即可通过以下命令来预览

* C-c C-c m 在另一个缓冲区预览html格式
* C-c C-c p 在浏览器中进行预览

{{ page.date | date_to_string }}
