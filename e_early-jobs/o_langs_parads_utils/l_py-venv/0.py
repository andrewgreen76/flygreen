inqcnt = 0
u = 3
l = 1
# => guess space : [1-3] 
a = 2

def half( u , l )
  inqcnt += 1
  g==a	# check the special case
    ? print inqcnt
    : a <= g=(u-l)/2  
      ? half( u , g ) 
      : half( g , l )

half()
