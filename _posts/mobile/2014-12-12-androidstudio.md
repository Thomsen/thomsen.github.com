---
layout: post
title: Android Studio 1.0
category: mobile
tags: ['android studio']
---

之前断断续续的使用了android studio开发工具，现在android studio 1.0稳定版正式发布了。android studio升级后，首先要解决的是之前的android项目像高版本迁移。android studio采用的是gradle编译android项目，而对应android studio的gradle tools也会升级。

android studio 特性：

>
* 模板与样例
* 智能代码编辑
* 翻译编辑器
* 多布局支持
* 性能分析工具
* 即时访问云服务
* 统一构建系统

android studio 1.0 使用的gradle tool是1.0.0开始，所以在原有的项目中'com.android.tools.build:gradle:0.5.+'就要改为1.0.0。

android studio 1.0 本身包含了gradle组建工具，版本2.2.1。在android studio的project settings配置中，gradle下配置使用本地的gradle发行版本。

* Updating Maven Repository Indices...

``` gradle
buildscript {
  repositories {
    maven { url 'http://repo1.maven.org/maven2' }
  }
}
```

Updating [http://repo1.maven.org/maven2] nexus-maven-repository-index.gz

* Minimum required is 19.1.0

因为Android SDK Build-tools版本下载的是21.1.2

``` gradle

android {
  buildToolsVersion "21.1.2"
}

```

*  Error:FAILURE: Build failed with an exception.

What went wrong:
Task 'compileDebug' is ambiguous in project ':ProjectName'. Candidates are: 'compileDebugAidl', 'compileDebugJava', 'compileDebugNdk', 'compileDebugRenderscript', 'compileDebugSources', 'compileDebugTestAidl', 'compileDebugTestJava', 'compileDebugTestNdk', 'compileDebugTestRenderscript', 'compileDebugTestSources'.

Try:
Run gradle tasks to get a list of available tasks. Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output.

A problem occurred configuring project ':ProjectName'.  
\> Could not resolve all dependencies for configuration ':ProjectName:classpath'.  
    \> Cannot resolve external dependency com.android.tools.build:gradle:1.0.0 because no repositories are defined.  
     Required by:  
         ProjectName:ProjectName:unspecified
         
Sync Project with Gradle files




