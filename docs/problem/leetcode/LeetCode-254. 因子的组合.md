# LeetCode: 254. 因子的组合

[TOC]

## 1、题目描述

整数可以被看作是其因子的乘积。

例如：

8 = 2 x 2 x 2;
  = 2 x 4.
请实现一个函数，该函数接收一个整数 n 并返回该整数所有的因子组合。

**注意：**

你可以假定 n 为永远为正数。
因子必须大于 1 并且小于 n。

```
示例 1：

输入: 1
输出: []
示例 2：

输入: 37
输出: []
示例 3：

输入: 12
输出:
[
  [2, 6],
  [2, 2, 3],
  [3, 4]
]
示例 4:

输入: 32
输出:
[
  [2, 16],
  [2, 2, 8],
  [2, 2, 2, 4],
  [2, 2, 2, 2, 2],
  [2, 4, 4],
  [4, 8]
]
```



## 2、解题思路

- 从2开始除，能除尽，则则加入结果集，并将商进行因式分解

- 将同样的组合去重

```python
class Solution:

    def getFactors(self, n: int) -> List[List[int]]:

        res = []
        barrier = n // 2 + 1

        pointer = 2
        while pointer < barrier:

            if n % pointer == 0:
                nex = n // pointer
                res.append([pointer, nex])
                barrier = nex
                res.extend([sorted([pointer] + t) for t in self.getFactors(nex)])

            pointer += 1

        temp = set([tuple(x) for x in res])
        return [ list(x) for x in temp]
```

