# Welcome to the experimental edutainment/multi-tutorial repository. 

__________________________________________________________________________
ANNOUNCEMENT :

If somebody can create open-source software that's like the Google Maps
of VLSI (designing chips) that'd be great.

 . or I can do that myself
 . a game for making games 
__________________________________________________________________________
__________________________________________________________________________
The PURPOSE of this repo:
__________________________________________________________________________

To help individuals, with or without a technical background, to:
- fill in the gaps left by their formal education or, if they didn't have any,
  provide them with comprehensive alternative education;
  - (especially for beginners)
    - hone their programming skills,
    - internalize key programming and engineering concepts,
    - learn about different systems,
    - understand and build a perspective on modern computing through studying
      its history.
- grow a portfolio; 
- improve their productivity in general (combatting ADD, figuring out
  alternatives to unhealthy solutions, etc.);     
__________________________________________________________________________
The MANIFESTO is:
__________________________________________________________________________

> to run
  - to use for practical or artistic reasons
> to share
  - to show off
> to study
  - to learn
> to modify
  - to hack ethically and creatively
__________________________________________________________________________
CHOSEN PERSONAL PROJECT:
__________________________________________________________________________
TOPICS AND METHODS EXPLORED TO AN EXTENT OVER THE PAST FEW DAYS :
__________________________________________________________________________

Quantum computing : 
 . contrast with classical binary computing 
 . benefits
 . technology 
 . qubits 
 . hardware (processors) 
 . algorithms 

Legacy (real-mode) assembly programming :
 . emu8086 vs. DOSBox vs. actual DOS
 . BIOS calls vs. DOS calls
 . SI and DI registers
 . data segment vs. extra segment
 . proper linear scanning of bytes within a buffer 
 . optimization heuristics
 . real-mode memory segmentation
 . endiannesses
 . monitoring and amending bytes in memory 
 . using and creating interrupts 

Raw binary images of :
  (1) BIOS
  (2) OS and related contents towards drive partitions : 
      . boot partition (bootloaders) 
      . OS partition
	. OS (kernel + build utilities) 
	. drivers 
      . swap partition 
      . data partition       

Process memory layout :
 . arguments + environment variables
 . stack (segment)
   . base pointer (frame pointer)
   . stack pointer
 . shared libraries
 . memory mapping segment
 . heap (segment)
 . BSS segment 
 . data segment
 . text segment 

Compile time vs. runtime :
 . dynamically allocated structures	      -> the heap segment at runtime after the main entry 
 . statically allocated data + function calls -> the stack segment at runtime after the main entry
 . uninitialized global variables 	      -> BSS segment at runtime before the main entry 
 . initialized global variables 	      -> data segment at runtime before the main entry 

Types of binary file formats in Unix-like systems : 
 . .bin vs. ELF executable vs. .out , etc. 

Hexadecimal byte code writing :
 . understanding of the different types of binary files
 . (their headers)
 . (32-bit vs. 64-bit)
 . (ELF vs. raw binary vs. others)

Applications of various programming, logic, query, and other languages. 

Assembly programming :
 . assemblers 
 . syntaxes 
 . directives in MASM , NASM , GAS , gcc ARM , etc.
 . NASM : 
   . directives , statements , markers : db , equ , $ , times , dup
   . address labels 
 . bss and resb 
 . optimizations (light coverage) 
 . ASCII conversion between digits as codes and digits as text characters
 . system calls and interrupts
 |
 . register renaming
 . instruction read dependency
 . instruction pipelining
 . inefficient pipeline stall 

DIY project : research -and- building my own dumb laptop / motherboard / CPU / EEPROMS 
 |
 . instruction queue/decode buffer
 |
 . reset vector :
 | . hardwired/integrated into the CPU 
 | . "double indirection"
 | . near/far jump to BIOS 
 |
 . flash firmware programming :
 | . POST imitation 
 | . BIOS (not UEFI) imitation
 |
 . system bus vs. chipset

__________________________________________________________________________
CHOSEN PROFESSIONAL PROJECT: 
__________________________________________________________________________

[REJECTED - PROPRIETARY SOFTWARE]
  | 
  A legacy BIOS/UEFI (x86) -based OS :
  - 32-bit
  ? multiboot2 -compliant ?? 
  - to be tested in QEMU
  - to be shipped for Raspberry Pi
__________________________________________________________________________
ABANDONED PROJECT IDEAS:
__________________________________________________________________________

- a game for Linux 
  - OpenGL 
  - drivers (dev's)
    - framebuffer
    - SDL mixer / ALSA 

- a game like a built-in OS

- a game for DosBox
- an emulator (VM) 
- learn BIOS-kernel-API/DSP-distro ladder for that 
- An API / display server protocol for a 13h-like mode portable to any server-like system.

.