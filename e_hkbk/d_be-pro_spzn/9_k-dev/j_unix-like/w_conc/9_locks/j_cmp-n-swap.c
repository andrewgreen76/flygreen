/*
Compare-And-Swap (CAS) :
. usually employed in SPARC ISA 
. also used in x86 (called "compare-and-exchange") : 
. similar to test-and-set , but more robust
. ATOMIC  
. pseudocode :
*/

    //			   v addr   v to-match   v to-update
    int CompareAndSwap(int *ptr, int expected, int new) {
	int original = *ptr;

	if (original == expected)
	   *ptr = new;

	return original;	// ret old addr.data
    }


    // (1) ret ADDR.OLD-DATA 
    // 	   update [ADDR] to NEW-DATA
    //
    // (2) ret ADDR.OLD-DATA
    // 	   keep [ADDR]
    //
