# This is an experimental edutainment/tutorial repository - a work in progress. 

__________________________________________________________________________
The PURPOSE of this repo:
__________________________________________________________________________

To help individuals, with or without a technical background, to: 
- improve their productivity in general (combatting ADD, figuring out
  alternatives to unhealthy solutions, etc.) 
- (especially for beginners)
  - hone their programming skills,
  - internalize key programming and engineering concepts,
  - learn about different systems,
  - understand and build a perspective on modern computing through studying
    its history.
    
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
TOPICS AND METHODS EXPLORED TO AN EXTENT OVER THE PAST 24-48 HOURS:
__________________________________________________________________________

- Bash :
  - command substitution (with cat, grep, etc.)
  - argument and variable management in scripts and sessions, 
  - understanding the role, the value, the pros, and the cons of :
    - local variables
    - environment variables
    - the tree-like nature of the shell and its processes
    - aliases
    - executable scripts
    - functions in Bash configs
  - forging and deploying custom bash funcs (which was painful but fun) 
  - hacks/aliases to expedite the workflow with Git. 
- more networking protocols, architectures, paradigms
  - genesis
  - purpose
  - evolution
  - potential replacements
  
__________________________________________________________________________
TECHNICAL OBSERVATIONS MADE OVER THE PAST 24-48 HOURS:
__________________________________________________________________________

I created a variable in .bash_aliases for storing a path to the root of
the working repo. It wasn't working for a while until I sourced .bashrc,
and then it worked. "git add ." can only take you so far - it won't take
care of untracked files. So I'm forced to come up with a trick for that.

Edit: Using pwd, cut, and command substitution and concatenation, I managed
to forge a powerful alias that could really save me a lot of time in every
attempt to update any repo tied to my account GitHub account.

__________________________________________________________________________
CHOSEN PROFESSIONAL PROJECT:
__________________________________________________________________________

- maintaining [the Linux kernel] >>>or<<< systemd

__________________________________________________________________________
CHOSEN PERSONAL PROJECT:
__________________________________________________________________________

- Just A GAME FOR DOSBOX is fine.
|
|
- a virtual machine,
- an emulator,
- or a video game that poses as an operating system (a la Last Call BBS).
  - Can I use the Unity Engine for that?
  - research dedicated toolchains. 
- challenge: faithful resolution
- plan of attack:
  - fide: 320x200
  - now: 1920x1200, 6 times both ways.
  - consider fair, authentic scaling. 
- learn BIOS-kernel-API/DSP-distro ladder for that 
- An API / display server protocol for a 13h-like mode portable to any headless system.

