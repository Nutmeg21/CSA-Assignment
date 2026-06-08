.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
INCLUDE Irvine32.inc

.data
	prompt BYTE "Enter 32-bit integer : ", 0
	message BYTE "The sum of 32-bit integers is : ", 0
	array DWORD 3 DUP(0)

.code
main PROC
	mov esi, 0
	mov ecx, 3
	
inputLoop:
	mov edx, OFFSET prompt
	call WriteString
	call ReadInt
	mov array[esi], eax
	add esi, 4
	loop inputLoop

	mov eax, array[0]
	add eax, array[4]
	add eax, array[8]
	mov edx, OFFSET message
	call WriteString
	call WriteInt
	call CrLf

	invoke ExitProcess, 0
main ENDP
end main