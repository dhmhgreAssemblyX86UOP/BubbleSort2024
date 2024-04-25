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
; -- Swap function --
; Description : This function swaps the values of two integers given as pointers.
; Input : EBP+8 -> Pointer to the first integer
;         EBP+12 -> Pointer to the second integer
; Output : The values of the two integers are swapped.
swap PROC
push ebp
mov ebp,esp
pushad

mov edi ,[ebp+8]
mov eax , [edi]  ; eax <- *a

mov esi ,[ebp+12]
mov ebx , [esi]  ; ebx <- *b

mov [esi],eax    ; *b <- *a
mov [edi],ebx    ; *a <- *b

popad
mov esp,ebp
pop ebp
ret 8
swap ENDP

bubbleSort Proc
push ebp
mov ebp, esp
sub esp, 4
pushad

;;;void bubbleSort(int arr[], int n)
;;;{
;;;    int i, j;
;;;    bool swapped;
;;;    for (i = 0; i < n - 1; i++) {
	   ; initialization
	   mov ebx, 0 ; i = 0 loop counter
	   mov esi, [ebp + 8] ; array base address
	   mov edx, [ebp + 12] ; edx <- length of array
	   dec edx ; edx <- n - 1
	   ; body
	   BODY1:
	   ;;; swapped = false;					
			mov [ebp - 4], DWORD PTR 0 ; swapped = false

			push ebx ; save i
			push edx ; save n-1

			;for (j = 0; j < n - i - 1; j++) {
			; initialization
			sub edx, ebx
			mov ebx, 0 ; j = 0 loop counter
			jmp COND2
			; body
			BODY2:
			  ; if (arr[j] > arr[j + 1]) {
			  mov eax, [esi + ebx * 4] ; eax <- arr[j]
			  mov edi,ebx
			  inc edi
			  mov ecx, [esi + edi * 4] ; ecx <- arr[j+1]
			  cmp eax, ecx ; arr[j] > arr[j+1]
			  jle STEP2
              ;  swap(arr[j], arr[j + 1]);
			  lea eax , [esi + ebx * 4] ; eax <- &arr[j]
			  lea ecx , [esi + edi * 4] ; ecx <- &arr[j+1]
			  push eax 
			  push ecx
			  call swap
	          ;    swapped = true;
			  mov [ebp - 4], DWORD PTR 00000001h ; swapped = true
			  


			; step
			STEP2:
			inc ebx ; j++
			; condition
			COND2:
			cmp ebx, edx ; j < n - i - 1
			jl BODY2  		

			pop edx ; restore i
			pop ebx ; restore n-1


;;        // If no two elements were swapped
;;        // by inner loop, then break
;;        if (swapped == false
		  cmp [ebp - 4],DWORD PTR 0 ; swapped == false
		  je EXITBUBBLESORT

	   ; step
			inc ebx ; i++
	   ; condition
	   COND1:
			cmp ebx, edx ; i < n - 1 
			jl BODY1

EXITBUBBLESORT:

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
	 mov edx, [ebp +12]
	 dec edx	; edx <- size - 1
	 jmp COND
	 ;body
	 BODY:
	;cout << " " << arr[i];
	    mov eax, [edi + ebx * 4] ; eax <- array[i] 
		call WriteHex 		
		; check if it is the last element		
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

;    printArray(arr, N);
	 push LengthOf array
	 push OFFSET array
	 call printArray
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


exit
main ENDP
END main



