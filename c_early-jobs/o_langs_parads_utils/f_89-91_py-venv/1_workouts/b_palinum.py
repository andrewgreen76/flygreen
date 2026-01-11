
class Solution:
    def isPalindrome(self, x: int) -> bool:
        if x<0:
            return False
        if x==0:
            return True

        digs=0
        leastsigs=[]
        while x:
            leastsigs.append(x%10)
            x//=10
            digs+=1
        print(f"Leastsigs: {leastsigs}")

        lctr=0
        rctr=digs-1
        digs//=2
        print(f"Pairs to match: {digs}")
        while lctr<=digs and ( leastsigs[lctr] == leastsigs[rctr] ) :
            lctr+=1
            rctr-=1
        return lctr>digs
    
    
if __name__ == "__main__":
    sol = Solution()
    print( sol.isPalindrome(10201) )
