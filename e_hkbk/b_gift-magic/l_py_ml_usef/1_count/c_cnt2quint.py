# Need the right package. 

timeit.timeit(
    "len(range(1_000_000_000_000_000_000))",
    number=1_000_000
) / 1_000_000
