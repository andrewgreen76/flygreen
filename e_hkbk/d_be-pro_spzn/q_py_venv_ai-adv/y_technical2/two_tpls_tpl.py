import sys

int_val = 1
two_ints_tpl = (int_val, int_val)
two_tpls_tpl = (two_ints_tpl, two_ints_tpl)

print(f"{sys.getsizeof(two_tpls_tpl) = }")
