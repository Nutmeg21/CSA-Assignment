.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
INCLUDE Irvine32.inc

.data
	array WORD 0, 2, 5, 9, 10
	arraySize = ($ - array) / 2
	sum DWORD 0

.code
main PROC
	mov esi, 0
	mov ecx, arraySize
	dec ecx

L1:
	movzx eax, array[esi + 2]
	movzx ebx, array[esi]
	sub eax, ebx
	add sum, eax
	add esi, 2
	loop L1

	mov eax, sum
	call WriteDec
	call CrLf

	invoke ExitProcess, 0
main ENDP
END main