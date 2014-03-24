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
