
class Solution:
    from typing import List
    def longestCommonPrefix(self, strs: List[str]) -> str:

        lcp = ""
        endchar_reached = False

        # Scan through chars of first word: 
        for fwchi in range(len(strs[0])) :

            # Match char at i of first word with char at i of every other word: 
            for subseqwdi in strs[1:] :

                if subseqwdi == "":
                    return lcp
                
                # "Lookahead" to detect final character. 
                if fwchi == len(subseqwdi)-1 :
                    endchar_reached = True

                # Finally a "break" character. 
                if not (strs[0])[fwchi] == subseqwdi[fwchi]:   
                    return lcp
                
            lcp = lcp + ( (strs[0])[fwchi] )
            if (endchar_reached):
                return lcp

        #############    
        return lcp
        #############
    
if __name__ == "__main__":
    sol = Solution()
    print( sol.longestCommonPrefix( ["ab", "a", ""] ) )
