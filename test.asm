Comment &
   7. Izslegt no rakstzimju virknes visas atstarpes, kas ir beigas aiz pedeja simbola.
&
.386
.model flat, stdcall
option casemap:none
include     \masm32\include\kernel32.inc
include     \masm32\include\masm32.inc
includelib  \masm32\lib\kernel32.lib
includelib  \masm32\lib\masm32.lib

Space       equ   '*'

.stack      4096

.data
buffer      byte   'test*************', 0
BufLen      equ    $ - buffer - 1

.code
start       proc
            push  es
            push  ds
            pop   es

            mov   ecx, BufLen
            lea   edi, buffer + BufLen - 1
            mov   al,  Space

            std
            repe scasb
            je Exit

            cld
            inc edi
            inc edi
            xor al, al
            stosb
Exit:
            invoke StdOut, addr buffer

            pop   es
            push  0
            call  ExitProcess
start       endp
            end start
