ifdef BuildDOS
	ifdef DosVGA
		include \SrcDOS\PrintCharVGA.asm
	endif
	
	ifdef DosCGA
		include \SrcDOS\PrintCharCGA.asm
	endif
	
	ifdef DosEGA
		include \SrcDOS\PrintCharEGA.asm
	endif
	
	ifndef DosVGA
		ifndef DosEGA
			ifndef DosCGA
				include \SrcDOS\V1_BitmapMemory_DosDirect.asm
			endif
		endif
	endif
	
endif

ifdef BuildWSW
		include \SrcWSW\V1_BitmapMemory.asm	
endif