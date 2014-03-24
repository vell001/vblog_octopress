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
