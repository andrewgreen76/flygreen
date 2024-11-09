; Program: A clock that slowly counts to five. 
; Andrew N. Green 

(begin
	(define r 20000000)

	(
	   define (count n)		; define (nameOfFxn arg) 
		  (if (= (* r 6) n)
		   (display (string)) ; base case - stop ticking
		   (begin             ; gen case - keep going. Check for wholeness, act accordingly, and keep ticking.
			 (if (= 0 (remainder n r)) ; if multiple of 10000, then ...
				 (begin
				   (display (/ n r)) ; show the whole
				   (display #\newline) ; display new line
				 )
				 ; otherwise, do nothing.
			 )
			 (count (+ 1 n)) ; keep going till you touch base.
		   )
		  )
	)
	  
	(count 1)
)


(begin
	(define r 20000000)

	(
	   define (count n)		
		  (if (= (* r 6) n)
		   (display (string)) 
		   (begin             
			 (if (= 0 (remainder n r)) 
				 (begin
				   (display (/ n r)) 
				   (display #\newline) 
				 )
				 
			 )
			 (count (+ 1 n)) 
		   )
		  )
	)
	  
	(count 1)
)



; working factorial code: 
(
	(
		(lambda (x) (x x))	; arg var, ?procedures?
		(lambda (fact-gen)	; output: another call, fact-gen is an arg. 
			(lambda (n)		; n is an arg; what follows is ops that return. 
				(if (zero? n)
					1
					(* n ((fact-gen fact-gen) (- n 1)))
				)
			)
		)
	)
	3	; input
)



; personal attempts: 

(
	define (desc n)
		(if (= 0 n)
			1
			( * n (desc (- n 1)) )	; clearly, this is where the fxn calls itself without lambdas. 
		)
)


; the equivalent of what's above: 
(
	define desc (lambda (n)
		(if (= 0 n)
			1
			( * n (desc (- n 1)) )
		)
	)
	
)

; Fibonacci addition: 
(
	define (desc n)
		(if (= 1 n)
			1
			( + n (desc (- n 1)) )	; clearly, this is where the fxn calls itself without lambdas. 
		)
)



(
	(lambda (n)
		(* n 5 3)
	)
	4
)


