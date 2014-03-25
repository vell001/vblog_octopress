---
layout: post
title: 复习C语言
comments: true
categories: C/C++
---

{{ page.title }}
---------------------
今天突然有感觉复习下C语言了，发现已经好久没有用过C编程了，话说最近都没有编过程序了都，趁现在还有点时间，好好学习下C了。话不多说上题目

---------------------
> 请定义一个宏，比较两个数a、b的大小，不能使用大于、小于、if语句

>**分析**：要不使用符号比较数的大小，第一个想到的应该是最原始的方法，就是数的二进制表示（第一位为1表示这是一个负数），以及对二进制的操作
>
>步骤：
>>
 1. 得到当前系统的位数：sizeof函数
 2. 将1**左移**位数减一位得到一个最高位为1的二进制数，如: 0x10000000
 3. 将两数之差和0x10000000相**与**，如果为1，说明差是负数。。。
>
代码：
``` c 
#include <stdio.h>

int const shift = sizeof(int) * 8 - 1;

#define max(a,b) ((((a)-(b))&(1 << shift))?b:a)

// test
void main()
{
	printf("%d", max(23,3));
}
```
2014/3/21 22:45:13 

--------------------
> 输出源文件的标题和目前执行行的行数

> **分析**：掌握__LINE__和__FILE__这两个宏定义就行了

> **代码**：
``` c
#include <iostream>
using namespace std;

int main()
{
	int line = __LINE__;
	char* file = __FILE__;
	cout << "filename:" << (file) << ",line is " << line << endl;
	return 0;
}
```
2014/3/21 23:06:16 