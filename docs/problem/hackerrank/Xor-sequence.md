# Xor-sequence

[TOC]

## 1、题目描述

An array,$A$ , is defined as follows:

-   $A_{0}=0$
-   $A_{x} = A_{x-1}\oplus x$ for$s \lt 0$ , where  is the symbol for [XOR](https://en.wikipedia.org/wiki/Exclusive_or)

You will be given a left and right index  $l,r$ . You must determine the XOR sum of the segment of  $A$ as$A[l]\oplus A[l+1]\oplus ...\oplus A[r]$ .

For example $A=[0,1,3,0,4,1,7,0,8]$, . The segment  from $l=1$ to$r=4$  sums to $1\oplus 3 \oplus 0\oplus 4=6$.

Print the answer to each question.

**Function Description**

Complete the *xorSequence* function in the editor below. It should return the integer value calculated.

xorSequence has the following parameter(s):

-   *l*: the lower index of the range to sum
-   *r*: the higher index of the range to sum

**Input Format**

The first line contains an integer $q$ , the number of questions.
Each of the next  $q$  lines contains two space-separated integers,  $l[i]$ and $r[i]$ , the inclusive left and right indexes of the segment to query.

**Constraints**

-   $1\le q \le 10^{5}$ 
-   $1 \le l[i] \le r[i] \le 10^{15}$ 

**Output Format**

On a new line for each test case, print the *XOR-Sum* of $A$'s elements in the inclusive range between indices  $l[i]$ and $r[i]$ .



**Sample Input 0**

```
3
2 4
2 8
5 9
```

**Sample Output 0**

```
7
9
15
```

**Explanation 0**

The beginning of our array looks like this: $A=[0,1,3,0,4,1,7,0,8,1,11...]$

*Test Case 0:*

$3\oplus 0\oplus 4=7$

*Test Case 1:*

$3\oplus 0\oplus 4\oplus1\oplus7\oplus0\oplus8=9$

*Test Case 2*:

$1\oplus7\oplus0\oplus8\oplus1=15$

**Sample Input 1**

```
3
3 5
4 6
15 20
```

**Sample Output 1**

```
5
2
22
```

**Explanation 1**

$A=[0,1,3,0,4,1,7,0,8,1,11,0,12,1,15,0,16,1,19,0,20,1,23,0,24,1,...]$. Perform the xor sum on each interval:

$3-5: 0\oplus4\oplus1=5$

$4-6: 4\oplus1\oplus7=2$

$15-20: 0\oplus16\oplus1\oplus19\oplus0\oplus20=22$



## 2、解题思路

-   首先明确一下，想要求解[l,r]之间的异或值，如果按照前缀和来算，就相当于

```
l1 = l-1
xor_lr = xor_r ^ xor_l1
```

-   相当于求解前面r个数字的异或，然后异或上(l-1)个

上面的数组，实际上是有规律的，4个一组，令i作为下标

```
每一组4个
i 1 i+2 0
i从0开始
例如：
[0,1,3,0,4,1,7,0,8,1,11,0,12,1,15,0,16,1,19,0,20,1,23,0]
我们实际可以将之分组：
[0,1,3,0]
[4,1,7,0]
[8,1,11,0]
[12,1,15,0]
[16,1,19,0]
[20,1,23,0]
每一组满足上面的规律，并且每一组的异或值都为2

因此，如果得到下标为l-1的异或值，以及下标r的前面所有数字的异或值，就得到了结果

- 首先判断是否能够整除4
	- 能够整除，判断是奇数个还是偶数个，奇数个异或为0，偶数个异或为2
	- 不能整除的话，按照上面的规律，找出剩余的值进行异或即可
```



```python
#!/bin/python3

import math
import os
import random
import re
import sys


# Complete the xorSequence function below.
def xorSequence(l, r):
    left, right = 2 if (l // 4 % 2) else 0, 2 if ((r + 1) // 4 % 2) else 0

    left_remainder = l % 4
    right_remainder = (r + 1) % 4

    if left_remainder:
        if left_remainder == 1:
            left ^= l - 1
        elif left_remainder == 2:
            left ^= (l - 2) ^ 1
        elif left_remainder == 3:
            left ^= (l - 3) ^ 1 ^ l
    if right_remainder:
        if right_remainder == 1:
            right ^= r
        elif right_remainder == 2:
            right ^= (r - 1) ^ 1

        elif right_remainder == 3:
            right ^= (r - 2) ^ 1 ^ (r + 1)

    return left ^ right


if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    q = int(input())

    for q_itr in range(q):
        lr = input().split()

        l = int(lr[0])

        r = int(lr[1])

        result = xorSequence(l, r)

        fptr.write(str(result) + '\n')

    fptr.close()

```

