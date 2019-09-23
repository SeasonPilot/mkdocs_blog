# Morgan and a String

[TOC]

## 1、题目描述

Jack and Daniel are friends. Both of them like letters, especially upper-case ones.
They are cutting upper-case letters from newspapers, and each one of them has his collection of letters stored in a stack.

One beautiful day, Morgan visited Jack and Daniel. He saw their collections. He wondered what is the lexicographically minimal string made of those two collections. He can take a letter from a collection only when it is on the top of the stack. Morgan wants to use all of the letters in their collections.

As an example, assume Jack has collected  $a=[A,C,A]$  and Daniel has  $b=[B,C,F]$ . The example shows the top at index  for each stack of letters. Assembling the string would go as follows:



```
Jack	Daniel	result
ACA	BCF
CA	BCF	A
CA	CF	AB
A	CF	ABC
A	CF	ABCA
    	F	ABCAC
    		ABCACF
```

**Note** the choice when there was a tie at `CA` and `CF`.

**Function Description**

Complete the *morganAndString* function in the editor below. It should return the completed string.

morganAndString has the following parameter(s):

- *a*: a string representing Jack's letters, top at index 0
- *b*: a string representing Daniel's letters, top at index 0

**Input Format**

The first line contains the an integer `t`, the number of test cases.

The next `t` pairs of lines are as follows:
\- The first line contains string `a`
\- The second line contains string  `b`.

**Constraints**

- $ 1<= T <=5$
- $1<=|a|,|b|<=10^{5}$ 
- `a` and `b`  contain upper-case letters only, `ascii[A-Z]`.

**Output Format**

Output the lexicographically minimal string `result`  for each test case in new line.

**Sample Input**

```
2
JACK
DANIEL
ABACABA
ABACABA
```

**Sample Output**

```
DAJACKNIEL
AABABACABACABA
```

**Explanation**

The first letters to choose from were J and D since they were at the top of the stack. D was chosen, the options then were J and A. A chosen. Then the two stacks have J and N, so J is chosen. (Current string is DAJ) Continuing this way till the end gives us the resulting string.

## 2、解题思路

题目看起来很简单，但是里面有一些隐含条件没说明，而且测试用例超级长，不好排障

关键点在于当栈顶两个元素相同的时候选择哪一个

- 栈顶元素相同时
  - 剩余元素中选取长度较小的进行判断，如果能够判断大小，就选择小的
  - 如果相同，那么就选择长度较长的那个

```
ABCD
ABCDEEE
```

例如上面的情况，前面的`ABCD`都是一样的，因此选择更长的那个，`ABCDEEE`



```python
#!/bin/python3

import math
import os
import random
import re
import sys


# Complete the morganAndString function below.
def morganAndString(a, b):
    la, lb = len(a), len(b)
    res = []
    pa, pb = 0, 0

    while pa < la and pb < lb:
        temp_a = a[pa:]
        temp_b = b[pb:]

        len_temp = min(len(temp_a), len(temp_b))

        if temp_a[:len_temp] < temp_b[:len_temp] or (temp_a[:len_temp] == temp_b[:len_temp] and len(temp_a) >= len(
                temp_b)):
            start = pa
            pa += 1
            while pa < la:
                if a[pa] < b[pb]:
                    pa += 1
                else:
                    break

            res.extend(a[start:pa])

        elif temp_a[:len_temp] > temp_b[:len_temp] or (temp_a[:len_temp] == temp_b[:len_temp] and len(temp_a) < len(
                temp_b)):
            start = pb

            pb += 1
            while pb < lb:
                if b[pb] < a[pa]:
                    pb += 1
                else:
                    break

            res.extend(b[start:pb])

    if pa < la:
        res.extend(a[pa:])
    if pb < lb:
        res.extend(b[pb:])

    return "".join(res)


if __name__ == '__main__':
    fptr = open("output.txt", 'w')

    t = int(input())

    for t_itr in range(t):
        a = input()

        b = input()

        result = morganAndString(a, b)

        fptr.write(result + '\n')

    fptr.close()

```

