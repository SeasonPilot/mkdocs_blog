# LeetCode: 5139. 第 N 个泰波那契数

[TOC]

## 1、题目描述

泰波那契序列 Tn 定义如下： 

T0 = 0, T1 = 1, T2 = 1, 且在 n >= 0 的条件下 Tn+3 = Tn + Tn+1 + Tn+2

给你整数 `n`，请返回第 n 个泰波那契数 Tn 的值。

 

**示例 1：**

```
输入：n = 4
输出：4
解释：
T_3 = 0 + 1 + 1 = 2
T_4 = 1 + 1 + 2 = 4
```

**示例 2：**

```
输入：n = 25
输出：1389537
```

 

**提示：**

- `0 <= n <= 37`
- 答案保证是一个 32 位整数，即 `answer <= 2^31 - 1`。



## 2、解题思路

- 递归加缓存

```python
from functools import lru_cache
class Solution:
    def tribonacci(self, n: int) -> int:

        @lru_cache(5)
        def tri(num):
            if num == 0:
                return 0
            elif num in (1, 2):
                return 1
            else:
                return tri(num - 1) + tri(num - 2) + tri(num - 3)
        
        return tri(n)
```

- 循环法

```python
class Solution:
    def tribonacci(self, n: int) -> int:
        if n == 0:
            return 0
        elif n in (1, 2):
            return 1
        else:
            temp = n - 2
            a = 0
            b = 1
            c = 1
            d = 2
            while temp:
                a, b, c = b, c, a + b + c
                temp -= 1
            return c
```

