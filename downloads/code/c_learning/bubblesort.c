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
