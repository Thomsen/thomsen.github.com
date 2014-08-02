---
layout: default
title: Emacs Markdown模式
---

### markdown的安装与配置 ###
emacs 通过elpa插件管理进行安装，新建一个el文件init-markdown.el  

    (require-package 'markdown-mode)  
    (setq auto-mode-alist  
        (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))
    (provide 'init-markdown)  

这样，当emacs打开一个后缀为md或markdown的文件，就会自动启动markdown模式。

<!-- more -->

### markdown的编辑命令 ###
掌握了默认的markdown快捷方式，就可以更快的将想要的格式输出来。

#### 有命令模式 ####
##### 区块元素 #####
* C-c C-t n 插入hash样式的标题；n代表1-5级别, 3表示\###）
* C-c C-t t 插入underline样式的标题，一级； ==  
* C-c C-t s 同上，二级； --
* C-c C-s b 插入引用内容； >
* C-c -     插入水平线

##### 区段元素 #####
* C-c C-a l 插入链接 []()
* C-c C-i i 插入图片 ![]()
* C-c C-s c 插入代码 ` `
* C-c C-p b 加粗
* C-c C-p i 斜体 

#### 无命令模式 ####
##### 区块元素 #####
+ 段落和换行， 换行通过两个以上的空格实现;
+ 列表，主要分为无序列表（*、+、-）和有序列表（1.），与段落间要有空行，不让会当作段落处理；
+ 代码区块，建立缩进通过4个空格或1个制表符

##### 区段元素 #####
- 强调，使用*活_包围实现强调，可以多个。如果 * 或 _ 两边都有空白，则会当作普通字符。

### markdown的大纲视图 ###
通过Shift-Tab 可以在emacs查看markdown的大纲视图、目录视图、及正常的视图。

### markdown的预览 ###
在系统中安装markdown程序包，如：
$ sudo apt-get install markdown

然后，在emacs中即可通过以下命令来预览

* C-c C-c m 在另一个缓冲区预览html格式
* C-c C-c p 在浏览器中进行预览

