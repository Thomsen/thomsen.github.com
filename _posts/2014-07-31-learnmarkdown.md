---
layout: default
title: Emacs Markdown模式
---

### markdown的安装与配置 ###
emacs 通过elpa插件管理进行安装，新建一个el文件init-markdown.el  
<code>
(require-package 'markdown-mode)  
(setq auto-mode-alist  
        (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))
(provide 'init-markdown)  
</code>
这样，当emacs打开一个后缀为md或markdown的文件，就会自动启动markdown模式。

### markdown的编辑命令 ###
掌握了默认的markdown快捷方式，就可以更快的将想要的格式输出来。  
* C-c C-t n 插入hash样式的标题（n代表1-5级别, 3表示程\### \###）
* C-c C-t t 插入underline样式的标题，一级； ==  
* C-c C-t s 同上，二级； --
* C-c C-a l 插入链接 []()
* C-c C-i i 插入图片 ![]()
* C-c C-s b 插入引用内容 > 
* C-c C-s c 插入代码 ` `
* C-c C-p b 加粗
* C-c C-p i 斜体 
* C-c -     插入水平线 

-------------------------------------------------------------------------------

#### 大纲视图 ####

#### 预览 ####


