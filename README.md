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

Assembly programming :
 . assemblers 
 . syntaxes 
 . directives : MASM , NASM , GAS , gcc ARM , etc.
 . optimizations
 . ASCII conversion between digits as codes and digits as text characters
 . system calls and interrupts
 . equ , $
 . bss and resb 
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