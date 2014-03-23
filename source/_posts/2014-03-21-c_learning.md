---
layout: post
title: 复习C语言
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

--------------------
> 实现一个快速排序算法

> **C代码**:
``` c
#include <stdio.h>
#include <time.h> 

#define NUM 15

int Partition(int* a, int low, int high){
	int key = a[low];
	while(low < high){
		while(low < high && a[high] >= key) --high;
		a[low] = a[high];
		while(low < high && a[low] <= key) ++low;
		a[high] = a[low];
	}
	a[low] = key;
	return low;
}

int* QSort(int* a, int low, int high){
	if(low < high){
		int p = Partition(a, low, high);
		QSort(a, low, p-1);
		QSort(a, p+1, high);
	}
}

int* QuickSort(int* a, int n) {
	return QSort(a, 0, n-1);
}

int* GetRandomNum(int n) {
	srand( (unsigned)time( NULL ) ); 
	int* a = (int*)malloc(n * sizeof(int));
	int i = 0;
	for(i=0; i<n; i++) {
		a[i] = rand() % n;
	}
	return a;
}

void PrintList(int* a, int n){
	int i = 0;
	for(i=0; i<n; i++){
		printf("%d  ", a[i]);
	}
	printf("\n");
}

void main() {
	int* a = GetRandomNum(NUM);
	PrintList(a, NUM);
	QuickSort(a, NUM);
	PrintList(a, NUM);
}
```
> **Java代码**:
``` java
package arithmetic;

public class QuickSort {

	public static void main(String[] args) {
		int[] a = {6,5,42,3,2,4,67,7,2,9,4};
		a = sort(a, 0, a.length-1);
		for(int i=0; i<a.length; i++){
			System.out.print(a[i] + "  ");
		}
		System.out.println();
	}
		
	public static int[] sort(int[] a, int low, int high){
		if(low < high){
			int p = partition(a, low, high);
			sort(a, low, p-1);
			sort(a, p+1, high);
		}
		return a;
	}
		
	public static int partition(int[] a, int low, int high){
		int key = a[low];
		while(low < high){
			while(low < high && a[high] >= key) high--;
			a[low] = a[high];
			while(low < high && a[low] <= key) low++;
			a[high] = a[low];
		}
		a[low] = key;
		return low;
	}
}
```
--------------------------
> 实现一个冒泡排序

> **C代码**:
``` c
#include <stdio.h>

int* BubbleSort(int* a, int n){
	int i = 0, j = 0, flag = 1, cup = 0;
	for(i=n-1; i>0 && flag; i--){
		for(j=0; j<i; j++){
			flag = 0;
			if(a[j] > a[j+1]){
				cup = a[j];
				a[j] = a[j+1];
				a[j+1] = cup;
				flag = 1;
			}
		}
	}
	return a;
}

void main(){
	int a[15] = {12,3,3,4,54,2,5,76,23,4,56,2,4,6,4};
	int i = 0;
	BubbleSort(a, 15);
	for(i=0; i<15; i++){
		printf("%d  ", a[i]);
	}
	printf("\n");
}
```
2014/3/23 11:58:29 

-------------------
> 实现希尔排序

> **C代码**:
``` c
#include <stdio.h>

int* ShellSort(int* a, int n){
	int i = 0, j = 0, d = n, cup = 0;
	for(d=n/2; d>=1; d=d/2){
		for(i=d; i<n; i++){
			cup = a[i];
			for(j=i-d; j>=0 && a[j]>cup; j=j-d){
				a[j+d] = a[j];
			}
			a[j+d] = cup;
		}
	}
	return a;
}

int* GetRandomNum(int n) {
	srand( (unsigned)time( NULL ) ); 
	int* a = (int*)malloc(n * sizeof(int));
	int i = 0;
	for(i=0; i<n; i++) {
		a[i] = rand() % n;
	}
	return a;
}

void PrintList(int* a, int n){
	int i = 0;
	for(i=0; i<n; i++){
		printf("%d  ", a[i]);
	}
	printf("\n");
}

void main(){
	int* a = GetRandomNum(15);
	PrintList(a, 15);
	ShellSort(a, 15);
	PrintList(a, 15);
}
```
2014/3/23 13:20:05 