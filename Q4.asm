.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
INCLUDE Irvine32.inc

.data
	grades BYTE "A", 0, "B", 0, "C", 0, "D", 0, "F", 0, "Invalid", 0
	prompt BYTE "Enter mark (0-100): ", 0
	result BYTE "Grade: ", 0

.code
main PROC
	mov edx, OFFSET prompt
	call WriteString
	call ReadInt
	cmp eax, 100
	jg displayInvalid
	cmp eax, 90
	jge displayA
	cmp eax, 80
	jge displayB
	cmp eax, 70
	jge displayC
	cmp eax, 60
	jge displayD
	cmp eax, 0
	jge displayF
	jmp displayInvalid

displayA:
	mov esi, 0
	jmp display

displayB:
	mov esi, 2
	jmp display

displayC:
	mov esi, 4
	jmp display

displayD:
	mov esi, 6
	jmp display

displayF:
	mov esi, 8
	jmp display

displayInvalid:
	mov esi, 10
	jmp display

display:
	call CrLf
	mov edx, OFFSET result
	call WriteString
	mov edx, OFFSET grades
	add edx, esi
	call WriteString
	call CrLf

	invoke ExitProcess, 0
main ENDP
end main