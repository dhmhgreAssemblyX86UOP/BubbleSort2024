TITLE BubbleSort Algorithm Implementation from https://www.geeksforgeeks.org/bubble-sort/
; Bubble Sort Animation :  https://www.youtube.com/watch?v=xli_FI7CuzA
INCLUDE Irvine32.inc

;;;// Optimized implementation of Bubble sort
;;;#include <bits/stdc++.h>
;;;using namespace std;
;;;
;;;// An optimized version of Bubble Sort
;;;void bubbleSort(int arr[], int n)
;;;{
;;;    int i, j;
;;;    bool swapped;
;;;    for (i = 0; i < n - 1; i++) {
;;;        swapped = false;
;;;        for (j = 0; j < n - i - 1; j++) {
;;            if (arr[j] > arr[j + 1]) {
;;                swap(arr[j], arr[j + 1]);
;;                swapped = true;
;;            }
;;        }
;;
;;        // If no two elements were swapped
;;        // by inner loop, then break
;;        if (swapped == false)
;;            break;
;;    }
;;}
;
;// Function to print an array
;void printArray(int arr[], int size)
;{
;    int i;
;    for (i = 0; i < size; i++)
;        cout << " " << arr[i];
;}
;
;// Driver program to test above functions
;int main()
;{
;    int arr[] = { 64, 34, 25, 12, 22, 11, 90 };
;    int N = sizeof(arr) / sizeof(arr[0]);
;    bubbleSort(arr, N);
;    cout << "Sorted array: \n";
;    printArray(arr, N);
;    return 0;
;};;;

.data
array DWORD 64h, 34h, 25h, 12h, 22h, 11h, 90h
message1 BYTE "Sorted array: ",0dh,0ah, 0	    ; new line in windows OS is a combination
												;of two characters 0xD and 0xA
												;0xA linefeed (\n),
												;0xD carriage return(\r),
delimeter BYTE ", ",0
.code
bubbleSort Proc
push ebp
mov ebp, esp
pushad


popad
mov esp, ebp
pop ebp
ret	8
bubbleSort Endp
printArray Proc
push ebp
mov ebp, esp
pushad

;void printArray(int arr[], int size)
;{
;    int i;
;    for (i = 0; i < size; i++)

	 ;initialization
	 mov ebx,0 ; i = 0 loop counter
	 mov edi, [ebp + 8] ; array base address
	 jmp COND
	 ;body
	 BODY:
	;cout << " " << arr[i];
	    mov eax, [edi + ebx * 4] ; eax <- array[i] 
		call WriteHex
		
		; check if it is the last element
		mov edx, [ebp +12]
		dec edx
		cmp ebx, edx ; i == size-1
		je STEP
		mov edx, OFFSET delimeter
		call WriteString
	 ;step
	 STEP:
		inc ebx
	 ;condition		
	 COND:
	    cmp ebx, [ebp + 12] ; i < size
		jl BODY

popad
mov esp, ebp
pop ebp
ret
printArray Endp
main PROC

;int main()
;{
;    int arr[] = { 64, 34, 25, 12, 22, 11, 90 };
;    int N = sizeof(arr) / sizeof(arr[0]);
;    bubbleSort(arr, N);
	 push LengthOf array
	 push OFFSET array
	 call bubbleSort
	 
;    cout << "Sorted array: \n";
	 mov edx, OFFSET message1
	 call WriteString

;    printArray(arr, N);
	 push LengthOf array
	 push OFFSET array
	 call printArray
;    return 0;
;};;;

exit
main ENDP
END main



