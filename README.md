# CSA-Assignment
CSA Lab Assignment 25/26
# Computer Systems Architecture Lab Assignment
> **MASM Assembly Programming Using Visual Studio and Irvine32**

[![Language](https://img.shields.io/badge/Language-x86_Assembly-blue.svg)](https://en.wikipedia.org/wiki/X86_assembly_language)
[![Environment](https://img.shields.io/badge/Environment-Visual_Studio-purple.svg)](https://visualstudio.microsoft.com/)
[![Library](https://img.shields.io/badge/Library-Irvine32-orange.svg)](http://www.asmirvine.com/)

This repository contains four assembly-language programs developed for the Computer Systems Architecture lab assignment. The programs are designed for a 32-bit MASM project in Microsoft Visual Studio and use the Irvine32 library to handle input and output from the console. 

**GitHub Repository:** [Nutmeg21/CSA-Assignment](https://github.com/Nutmeg21/CSA-Assignment.git)

---

## 📋 Project Details

| Field | Details |
| :--- | :--- |
| **Student Name** | LOO JIUN WEI |
| **Matric Number** | 25006149 |
| **Course / Section** | WIA1003 COMPUTER SYSTEM ARCHITECTURE |
| **Lecturer** | DR. BRYAN RAJ A/L PETER JABARAJ |

---

## 🎯 Objectives

Here is a summary of the four programs included in this assignment:

| Question | Program Objective | Main Concept |
| :---: | :--- | :--- |
| **1** | Calculate the sum of gaps between adjacent WORD array elements. | Indexed addressing and array traversal |
| **2** | Generate a triangular incremental number pattern from 1 to 8. | Nested loops and register control |
| **3** | Read three 32-bit integers, store them in an array, and calculate the sum. | Input, storage, and array processing |
| **4** | Use a logical procedure to determine a grade based on an input, mark integer (0-100) | Procedures and conditional jumps |

---

## 💻 Development Environment

To run these programs, the following environment is required:

* **IDE:** Microsoft Visual Studio Enterprise with the Desktop development with C++ workload.
* **Assembler:** Microsoft Macro Assembler (MASM) using a 32-bit x86 / Win32 project.
* **Dependencies:** Irvine32 library for procedures such as `ReadInt`, `WriteDec`, `WriteString`, and `CrLf`.
* **Configuration:** The Irvine32 include and library files must be available to the project. A common configuration uses the folder `C:\Irvine`. If Visual Studio reports that `Irvine32.inc` cannot be opened, the file location and include path must be checked before building the programs.

---

## 🚀 Programs

### Question 1: Sum of Gaps Between Array Elements

**Objective:** The first program calculates the total difference between adjacent elements in the non-decreasing array of `{0, 2, 5, 9, 10}`. The individual gaps are 2, 3, 4, and 1, providing a sum of 10.

**Program Logic:**
* Initialize `ESI` to 0 to act as the array index multiplier.
* Set the loop counter `ECX` to the array size minus 1.
* Read the next element at `array[esi + 2]` and the current element at `array[esi]`.
* Subtract the current value from the next value to obtain the gap.
* Add the gap to the sum memory variable.
* Increment `ESI` by 2 (the size of a WORD) and repeat the loop.

| Register | Purpose |
| :--- | :--- |
| **ESI** | Points to the current array element. |
| **EAX** | Stores the current element. |
| **EBX** | Stores the running total. |
| **ECX** | Controls the loop count. |

**Source Code:**
```assembly
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
```

*(Note: Refer to `images/Q1_Output.png` in the repository for the output visualization).*

---

### Question 2: Number Sequence Pattern

**Objective:** The second program generates eight rows. The first row prints the numbers 1 to 8, while every following row starts one number later and still ends at 8.

**Program Logic:**
* Use `EBX` as the starting number of the current row (initialized to 1).
* Use the outer loop to check if `EBX` has exceeded the maximum number (8).
* Copy `EBX` into `ESI` at the beginning of each row.
* Use the inner loop to print values from `ESI` up to 8, separated by spaces.
* After one row is complete (when `ESI` > 8), print a newline, increment `EBX`, and jump back to the outer loop.

| Register | Purpose |
| :--- | :--- |
| **EBX** | Stores the maximum number, 8. |
| **ESI** | Stores the starting number of the current row. |
| **EDX** | Supplies the space string address to the `WriteString` procedure. |
| **EAX** | Supplies the number to the `WriteDec` procedure. |

**Source Code:**
```assembly
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
```

*(Note: Refer to `images/Q2_Output.png` in the repository for the output visualization).*

---

### Question 3: Store and Sum Three Integers

**Objective:** The third program prompts the user for three signed 32-bit integers, stores the values in an array, traverses the array, and displays the calculated sum.

**Program Logic:**
* Reserve a DWORD array with space for three 32-bit values.
* Use a loop (`inputLoop`) to prompt the user and receive integers using `ReadInt`.
* Store each input value at the base address of `array` plus the offset in `ESI`.
* Increment `ESI` forward by four bytes (size of a DWORD) for each iteration.
* After input collection, bypass a second loop and calculate the sum directly using static index addressing (`array[0]`, `array[4]`, `array[8]`), accumulating the total in `EAX`.

**Source Code:**
```assembly
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
```

*(Note: Refer to `images/Q3_Output_1.png` and `images/Q3_Output_2.png` in the repository for the output visualization).*

---

### Question 4: Grade Classification Procedure

**Objective:** The fourth program receives a mark between 0 and 100 and uses a separate procedure to return the corresponding capital letter grade.

| Mark Range | Grade |
| :--- | :--- |
| **90 to 100** | A |
| **80 to 89** | B |
| **70 to 79** | C |
| **60 to 69** | D |
| **0 to 59** | F |
| **Less than 0 or More than 100** | Invalid |

**Program Logic:**
* Store all possible grades in a continuous null-terminated byte array (`grades`).
* Receive the mark into `EAX` and use a cascading series of conditional jump instructions (`jg`, `jge`) to check the thresholds from highest to lowest.
* Jump to specific labels (`displayA`, `displayB`, etc.) which assign a distinct numeric offset (0, 2, 4, 6, 8, 10) to `ESI`.
* Jump to a final display block that adds the `ESI` offset to the base address of the `grades` string, resolving the correct grade letter to print.

**Source Code:**
```assembly
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
```

*(Note: Refer to `images/Q4_Output_1.png` and `images/Q4_Output_2.png` in the repository for the output visualization).*

---

## 📝 Conclusion

The four programs demonstrate distinct assembly-language techniques for solving fundamental problems. Question 1 utilizes direct offset addressing to traverse an array and calculate differences. Question 2 uses nested jump instructions acting as loops to manipulate a printing sequence. Question 3 collects input into a statically sized array and employs direct memory addition to process the sum. Finally, Question 4 applies structured control flow via conditional jumps and utilizes string array offsets to classify data efficiently. Together, these files reflect practical usage of memory addressing, register manipulation, and conditional logic.
