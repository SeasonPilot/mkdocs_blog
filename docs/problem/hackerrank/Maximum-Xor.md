# Maximum Xor 

[TOC]

## 1、题目描述

You are given an array  $arr$ of  $n$ elements. A list of integers,$queries$  is given as an input, find the maximum value of $queries[j]\oplus each\ arr[i]$   for all $0\le i\lt n$  , where  represents [xor](https://en.wikipedia.org/wiki/Exclusive_or) of two elements.

Note that there are multiple test cases in one input file.

For example:

$arr = [3,7,15,10]$

$queries[j] = 3$

$3\oplus3=0,max=0$

$3\oplus7=4,max=4$

$3\oplus15=12,max=12$

$3\oplus10=9,max=12$ 

**Function Description**

Complete the *maxXor* function in the editor below. It must return an array of integers, each representing the maximum xor value for each element $queries[j]$   against all elements of $arr$.

maxXor has the following parameter(s):

-   *arr*: an array of integers
-   *queries*: an array of integers to query

**Input Format**

The first line contains an integer $n$ , the size of the array  $arr$.

The second line contains $n$  space-separated integers,$arr[i]$  from $0\le i \lt n$.

The third line contain $m$ , the size of the array $queries$.

Each of the next  $m$ lines contains an integer $queries[j]$ where  $0\le j \lt m$.

**Constraints**

$1\le n,m \lt 10^{5}$

$0\le arr[i],queries[j]\le 10^{9}$

**Output Format**

The output should contain $m$ lines with each line representing output for the corresponding input of the testcase.

**Sample Input 0**

```
3
0 1 2
3
3
7
2
```

**Sample Output 0**

```
3 
7 
3 
```

**Explanation 0**

$arr=[0,1,2]$

$queries[0]= 3$

$3\oplus 0=3,max=3$

$3\oplus 1=2,max=3$

$3\oplus 2=1,max=3$

$queries[1]=7$

$7\oplus 0=7,max=7$

$7\oplus 1=6,max=7$

$7\oplus 2=5,max=7$

$queries[2]=2$

$2\oplus 0=2,max=2$

$2\oplus 1=3,max=3$

$2\oplus 2=0,max=3$




**Sample Input 1**

```
5
5 1 7 4 3
2
2
0
```

**Sample Output 1**

```
7 
7 
```

**Explanation 1**

$arr=[5,1,7,4,3]$ 

$queries[0]=2$ 

$2\oplus 5=7,max=7$ 

$2\oplus 1=3,max=7$ 

$2\oplus 7=5,max=7$ 

$2\oplus 4=6,max=7$ 

$2\oplus 3=1,max=7$ 

$queries[1]=0$ 

$0\oplus 5=5,max=5$ 

$0\oplus 1=1,max=5$ 

$0\oplus 7=7,max=7$ 

$0\oplus 4=4,maa=7$ 

$0\oplus 3=3,max=7$ 




**Sample Input 2**

```
4
1 3 5 7
2
17
6
```

**Sample Output 2**

```
22
7
```

**Explanation 2**

$arr=[1,3,5,7]$ 

$queries[0]= 17$ 

$17\oplus 1=16,max=16$ 

$17\oplus 3=18,max=18$ 

$17\oplus 5=20,max=20$ 

$17\oplus 7=22,max=22$ 

$queries[1] = 6$ 

$6\oplus 1=7,max=7$ 

$6\oplus 3=5,max=7$ 

$6\oplus 5=3,max=7$ 

$6\oplus 7=1,max=7$ 




## 2、解题思路

-   使用前缀树
-   每一次尽量找与当前不相同路径



```python
# !/bin/python3

import math
import os
import random
import re
import sys


class Trie:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.head = {}

    def insert(self, num):
        """
        Inserts a word into the trie.
        :type word: str
        :rtype: void
        """
        cur = self.head

        num_str = bin(num)[2:].zfill(32)

        for c in num_str:
            cur = cur.setdefault(c, {})

        cur["value"] = num

    def get_max_xor(self, num):

        num_str = bin(num)[2:].zfill(32)
        cur = self.head
        for c in num_str:
            if c == "0" and "1" in cur:
                cur = cur["1"]
            elif c == "1" and "0" in cur:
                cur = cur["0"]
            else:
                cur = cur[c]
        return num ^ cur["value"]


# Complete the maxXor function below.
def maxXor(arr, queries):
    trie = Trie()
    for n in arr:
        trie.insert(n)

    res = []
    for q in queries:
        res.append(trie.get_max_xor(q))

    return res


# solve here

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input())

    arr = list(map(int, input().rstrip().split()))

    m = int(input())

    queries = []

    for _ in range(m):
        queries_item = int(input())
        queries.append(queries_item)

    result = maxXor(arr, queries)

    fptr.write('\n'.join(map(str, result)))
    fptr.write('\n')

    fptr.close()

```

