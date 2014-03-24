#include <stdio.h>
#include <time.h>

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
