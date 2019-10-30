# Count Triplets

[TOC]

## 1、题目描述

You are given an array and you need to find number of tripets of indices $(i,j,k)$ such that the elements at those indices are in [geometric progression](https://en.wikipedia.org/wiki/Geometric_progression) for a given common ratio  $r$and $i<j<k$.

For example, $arr=[1,4,16,64]$. If $r=4$, we have $[1,4,16]$ and $[4,16,64]$ at indices $(0,1,2)$and $(1,2,3)$.

**Function Description**

Complete the *countTriplets* function in the editor below. It should return the number of triplets forming a geometric progression for a given $r$as an integer.

countTriplets has the following parameter(s):

-   *arr*: an array of integers
-   *r*: an integer, the common ratio

**Input Format**

The first line contains two space-separated integers $n$  and$r$ , the size of$arr$ and the common ratio.
The next line contains $n$space-seperated integers $arr[i]$.

**Constraints**

-   $1\le n \le 10^{5}$
-   $1\le r \le 10^{5}$
-   $1\le arr[i] \le 10^{9}$

**Output Format**

Return the count of triplets that form a geometric progression.

**Sample Input 0**

```
4 2
1 2 2 4
```

**Sample Output 0**

```
2
```

**Explanation 0**

There are $2$triplets in satisfying our criteria, whose indices are $(0,1,3)$and$(0,2,3)$ 

**Sample Input 1**

```
6 3
1 3 9 9 27 81
```

**Sample Output 1**

```
6
```

**Explanation 1**

The triplets satisfying are index $(0,1,2)$,$(0,1,3)$ ,$(1,2,4)$ ,$(1,3,4)$ ,$(2,4,5)$ and $(3,4,5)$.

**Sample Input 2**

```
5 5
1 5 5 25 125
```

**Sample Output 2**

```
4
```

**Explanation 2**

The triplets satisfying are index $(0,1,3)$,$(0,2,3)$ ,$(1,3,4)$ , $(2,3,4)$.

## 2、解题思路

-   统计等比三元组的数量
-   因为是等比三元组，因此，假设固定了中间的元素$num$，那么在左面找到$num/r$的数量`left_count`，在右面找出$num*r$的数量`right_count`，那么当前元素能够形成的等比三元组数量为：`left_count*right_count`
-   因此，只需要设置两个统计字典，分别统计出当前元素左面和右面的等比元素的数量，更新结果即可



```python
#!/bin/python3

import math
import os
import random
import re
import sys

from collections import defaultdict


# Complete the countTriplets function below.
def countTriplets(arr, r):
    left = defaultdict(int)
    right = defaultdict(int)
    left[arr[0]] += 1
    for num in arr[1:]:
        right[num] += 1
    res = 0
    for num in arr[1:-1]:
        right[num] -= 1
        res += left[num / r] * right[num * r]
        left[num] += 1
    return res
    
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    nr = input().rstrip().split()

    n = int(nr[0])

    r = int(nr[1])

    arr = list(map(int, input().rstrip().split()))

    ans = countTriplets(arr, r)

    fptr.write(str(ans) + '\n')

    fptr.close()

```

