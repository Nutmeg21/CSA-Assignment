.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
INCLUDE Irvine32.inc

.data
	num DWORD 8
	space BYTE " ", 0

.code
main PROC
	mov ebx, 1
	
outer:
	cmp ebx, num
	jg finish
	mov esi, ebx

inner:
	cmp esi, num
	jg newLine
	mov eax, esi
	call WriteDec
	mov edx, OFFSET space
	call WriteString
	inc esi
	jmp inner
	
newLine:
	call CrLf
	inc ebx
	jmp outer

finish:
	invoke ExitProcess, 0
main ENDP
end main