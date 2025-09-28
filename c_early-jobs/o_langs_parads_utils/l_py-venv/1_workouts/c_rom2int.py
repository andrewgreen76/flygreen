
class Solution:
    def romanToInt(self, s: str) -> int:
        
        c = len(s)
        sum = 0

        chart = {
            'I': 1,
            'V': 5,
            'X': 10,
            'L': 50,
            'C': 100,
            'D': 500,
            'M': 1000
        }
        
        i = 0
        while i < len(s) :    # Still chars to scan.
            if i==len(s)-1:   # A special case: last char before overscan.
                sum += chart[ s[i] ]
                return sum
            else:
                if chart[s[i]] < chart[s[i+1]]:   # subtrahend detected to precede the minuend
                    sum+= chart[s[i+1]] - chart[s[i]]
                    i+=2
                else:
                    sum+= chart[s[i]]
                    i+=1
            
        return sum
        
    
if __name__ == "__main__":
    sol = Solution()
    print( sol.romanToInt("III") )
    # CMXCIX
