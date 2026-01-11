program add_numbers
    integer :: a, b, sum

    a = 2
    b = 3
    sum = a + b

    print *, 'The sum of', a, 'and', b, 'is', sum
    print '(A,I0)', 'The sum of 2 and 3 is ', sum
    print '(A,I0,A,I0,A,I0)', 'The sum of ', a, ' and ', b, ' is ', sum

    ! Q: "Why are there tabs preceding the numerical arguments in the text output?"
    ! A: "The tabs appear because Fortran’s `print *` statement inserts default spacing before each value to align
    !     output in columns."
    !
    ! "In Fortran formats, `'A'` stands for a character string and `'I0'` stands for an integer with minimal width,
    ! printing without leading spaces."
    
end program add_numbers
