---
layout: post
title: "some_problem_with_octopress"
date: 2014-03-23 22:13:05 +0800
comments: true
categories: octopress
---
###我使用octopress时遇到的问题汇总：

* ``` Error: Permission denied (publickey) ```  

**说明：**我第一次使用```rake deploy```命令，总是有一个错误，提示说```Error: Permission denied (publickey)```, 我开始没注意，后来才看见了，原来是我电脑还没有设置publickey

**解决：**
> 
1. 生成一个publickey:```ssh-keygen -lf ~/.ssh/id_rsa.pub```
2. 在github上添加publickey，详情：[github-help](https://help.github.com/articles/error-permission-denied-publickey)

* ``` octopress/plugins/pygments_code.rb:27:in 'rescue in pygments': Pygments can't parse unknown language: cpp. (RuntimeError) ```  

**说明：**在我以为成功安装完*pygments*后，再使用```rake deploy```命令时就出现这个错误，同样，我也没注意，折腾了半天，连post都不能更新了，郁闷了半天，后面发现我的*pygments*压根就没安装成功

**解决：**这个问题已经很明确了，只要成功安装*pygments*就行了，接下来就是安装*pygments*的问题了

* ``` Traceback (most recent call last):
  File "/usr/bin/pycompile", line 36, in <module>
    from debpython.version import SUPPORTED, debsorted, vrepr, \
  File "/usr/share/python/debpython/version.py", line 24, in <module>
    from ConfigParser import SafeConfigParser
ImportError: No module named 'ConfigParser' ```

**说明：**提示没有找到*ConfigParser*这个模块，果断google了下发现，我的ubuntu前几天刚升级了python3，结果*ConfigParser*这个模块在python3下是*configparser*

**解决：**这个问题简单，要么改代码，要么换python2，我电脑上还有python2，直接替换下python3，再次安装pygments就成功了，再次使用```rake deploy```就OK了，octopress已经在我的ubuntu上完美运行了