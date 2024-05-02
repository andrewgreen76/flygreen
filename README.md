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

The mystery of the circular semiconductor wafer.

The "stored program" model. 

DIY project : building my own dumb laptop / motherboard
 |
 . the Manchester Baby , the first stored program , program images 
 . memory (wide) protection , protected mode , virtual memory support 
 . paged memory 
 . clocking schemes and techniques in Intel microprocessors 
 . 8086 innovations :
   . load-store unit
   . bus interface unit 
   . controllers (DMA , PIC , etc.) 
   . register file 
 . history of Intel CPUs , CPU families , microarchitectures
 . AMD CPUs in laptops 
 . hardware/CPU initialization (vanilla) routine - details 
 . all x86 registers 
 . the history of Motorola MPUs 
 . addressing modes in x86
 . the history of component inclusions in x86 CPUs 
 . instruction queue/decode buffer
 . EU (Execution Unit) + BIU (Bus Interface Unit)
 . the history of interrupts
 . the history of BIOS
 . floating-point division in Intel CPU's 
 |
 . x86 protected mode - addressing modes 
 |
 . control logic bits/signals in x86 , ARMv8.
 |
 . cold boot
 | . cold boot vector 
 |
 . reset vector :
 | . hardwired/integrated into the CPU 
 | . "double indirection"
 | . near/far jump to BIOS 
 |
 . boot/EEPROM firmware programming :
 | . [not possible] Raspberry PI 4
 | . [not feasible] laptop motherboards
 | . [TBD] reset vector 
 |
 . flash firmware programming :
 | . POST imitation 
 | . BIOS (not UEFI) imitation
 |
 . system bus vs. chipset



History of security vulnerabilities :
 | 
 . DoS
 . Morris Worm
 . information disclosure on ARPANET
 . session hijacking
 . privilege escalation and authentication bypass on Unix systems
 |
 . illegal access to memory contents 

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