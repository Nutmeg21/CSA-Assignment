# CSA-Assignment
CSA Lab Assignment 25/26
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
| **Submission Date** | 8/6/2026 |

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
.38
