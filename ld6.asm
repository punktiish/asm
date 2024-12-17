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
S           equ  size Matrix

.data?
vector      word N dup (?)

.code
FormVector  proc
            enter 4, 0 
            push ecx
            push ebx
            push edi
            push eax 
            mov  ecx, [ebp + 12]   ; M (columns)    
            mov  ebx, [ebp + 16]   ; Matrix address
            mov  edi, [ebp + 20]   ; Vector address
Cols:       
            ; Calculate current column position first
            mov  eax, M            ; Start with total columns
            sub  eax, ecx          ; 4-4=0, 4-3=1, 4-2=2, 4-1=3
            imul eax, S            ; Multiply by element size
            mov  ebx, [ebp + 16]   ; Reset to matrix start
            add  ebx, eax          ; Add offset to get to column

            push ecx               ; Save column counter
            mov  ecx, [ebp + 8]    ; N (rows)
            xor  ax, ax

Rows:       mov  dx, [ebx]
            test dx, 1
            jz   False
            add  ax, dx
False:      add  ebx, M*S         
            loop Rows

            mov  [edi], ax        
            add  edi, S            
            pop  ecx               ; Get column counter back
            loop Cols

            pop eax 
            pop edi
            pop ebx
            pop ecx
            leave
            ret 4*4
FormVector  endp

Print       proc
            push ebp
            mov  ebp, esp

            push ecx
            push ebx
            push eax

            mov  ecx, [ebp + 8]
            mov  ebx, [ebp + 12]
Pr:         mov  ax, [ebx]
            add  ebx, S
            loop Pr

            pop  eax
            pop  ebx
            pop  ecx

            pop  ebp
            ret  2*4
Print       endp


start       proc
            push offset vector
            push offset Matrix
            push M
            push N
            call FormVector            

            push offset vector
            push M
            call Print

            push 0
            call ExitProcess
    
start       endp
            end start


