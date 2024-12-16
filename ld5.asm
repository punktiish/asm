.386
.model flat, stdcall
option casemap:none

include    \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

N        equ  3
M        equ  4

.stack   4096

.const
Matrix   word 4, 5, 6, 7
         word 2, 3, 4, 5
         word 1, 2, 3, 4
S        equ  size Matrix

.data?
vector   word M dup (?)

.code
start    proc

         lea  ebx, Matrix
         mov  ecx, M
         xor  edi, edi

Cols:    push ecx
         mov  ecx, N
         xor  esi, esi
         xor  ax, ax

Rows:    mov dx, [ebx][esi]
         test dx, 0001h
         jz False
         add ax, dx
False:
         add  esi, S*M
         loop Rows

         mov  vector[edi], ax
         add  ebx, S
         add  edi, S
         pop  ecx
         loop Cols

         xor  ebx, ebx
         mov  ecx, M
Print:   mov  ax, vector[ebx]
         add  ebx, S
         loop Print

         push 0
         call ExitProcess

start    endp
         end start
