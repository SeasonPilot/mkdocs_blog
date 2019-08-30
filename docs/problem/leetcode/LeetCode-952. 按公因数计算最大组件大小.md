# LeetCode: 952. 按公因数计算最大组件大小

[TOC]

## 1、题目描述

给定一个由不同正整数的组成的非空数组 `A`，考虑下面的图：

有 `A.length` 个节点，按从 `A[0]` 到 `A[A.length - 1]` 标记；
只有当 `A[i]` 和 `A[j]` 共用一个大于 `1` 的公因数时，`A[i]` 和 `A[j]` 之间才有一条边。
返回图中最大连通组件的大小。

 

**示例 1：**

```
输入：[4,6,15,35]
输出：4
```

**示例 2：**

```
输入：[20,50,9,63]
输出：2
```

**示例 3：**

```
输入：[2,3,6,7,4,12,21,39]
输出：8
```

 

**提示：**

- `1 <= A.length <= 20000`
- `1 <= A[i] <= 100000`



## 2、解题思路

- 首先将数字所有的质数因子计算出来
- 然后判断一共出现了多少因子
- 同一个数字对应的所有的因子进行合并
- 然后统计每个数字第一个因子的父节点出现的次数，找到最大值即可



```python
from collections import defaultdict
from collections import Counter


class DFU:
    def __init__(self, length):
        self.data = list(range(length))
        self.size = [1] * length

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.size[xp] += self.size[yp]
            self.data[yp] = xp

    def get_size(self, x):
        return self.size[x]

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution(object):

    def largestComponentSize(self, A):
        """
        :type A: List[int]
        :rtype: int
        """
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101,
                  103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199,
                  211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317,
                  331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443,
                  449, 457, 461, 463, 467, 479, 487, 491, 493, 497, 499]

        result = defaultdict(list)
        res = []
        for num in A:
            temp = []
            for prime in primes:
                if prime * prime <= num:
                    if num % prime == 0:
                        temp.append(prime)
                        while num % prime == 0:
                            num //= prime
            if num > 1 or not temp:
                temp.append(num)
            res.append(temp)
        num_primes = list({x for t in res for x in t})
        prime_index = {key: value for value, key in enumerate(num_primes)}

        d = DFU(len(num_primes))

        for t in res:
            for x in t:
                d.union(prime_index[t[0]], prime_index[x])
        return max(Counter(d.find(prime_index[t[0]]) for t in res).values())

```

