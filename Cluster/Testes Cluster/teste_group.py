

# Python3 code to demonstrate
# Categorize by string size
# using sorted() + groupby()
from itertools import groupby

# initializing list
test_list = ['man', 'a', 'geek', 'for', 'b', 'free']

# printing original list
print("The original list : " + str(test_list))

# using sorted() + groupby()
# Categorize by string size
util_func = lambda x: len(x)
temp = sorted(test_list, key = util_func)
res = [list(ele) for i, ele in groupby(temp, util_func)]

# print result
print("The list after Categorization : " + str(res))
