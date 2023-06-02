alias c='clear ; l -1'
alias s='source ~/.bashrc'		# to reload the path to root of working repo. 


# Git aliases:
#
# Exclusively for the edutain repo, now unnecessary: 
#alias t='git add ~/flygreen/. ; git commit -m "x" ; echo $GIT_TOKEN | xclip -selection clipboard ; git push'
#alias t='echo "t: command not found"'
#
#
# Rather unwieldy:
#alias t='git add ~/flygreen/. ; git add ~/g_img-proc/. ; git commit -m "x" ; echo $GIT_TOKEN | xclip -selection clipboard ; git push'
#
#
# Solution : formulate a "git add"-friendly path to stage all changes made within the repo.
#alias t='s ; echo $doctpath ; git add $doctpath ; git commit -m "x" ; echo $GIT_TOKEN | xclip -selection clipboard ; git push'
# Pretty cool, but also annoying as it usually goes with solving problems. WELCOME TO THE WORLD OF PROBLEM-SOLVING !!!
# Let's solve this without the intensive sourcing:
alias g='  root_of_repo=$(pwd | cut -d/ -f-4) ;
	   apd="/." ; 
	   doctpath=$root_of_repo$apd ;
	   echo $doctpath ;
	   git add $doctpath ; 
	   git commit -m "x" ; echo $GIT_TOKEN | xclip -selection clipboard ; git push'
#
#
# Doesn't work for untracked files in the repo: 
# alias t='git add . ; git commit -m "x" ; echo $GIT_TOKEN | xclip -selection clipboard ; git push'


# misc:
alias f='cd ~/flygreen ; c'
alias h='cd ~/flygreen/e_hkbk ; c'
alias d='find . -name'
alias b='find ~/flygreen/ -name'
alias i='emacs ~/flygreen/i_to-do_py_mrg_cache.note'
alias m='emacs ~/flygreen/README.md'
alias y='firefox ; firefox https://www.youtube.com/watch?v=u84ZX277TjM'
alias o='xdg-open'
alias a='emacs ~/.bash_aliases'
