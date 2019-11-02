# LeetCode: 1201. 丑数 III

[TOC]

## 1、题目描述

请你帮忙设计一个程序，用来找出第 `n` 个丑数。

丑数是可以被 `a` 或 `b` 或 `c` 整除的 正整数。

 

**示例 1：**

```
输入：n = 3, a = 2, b = 3, c = 5
输出：4
解释：丑数序列为 2, 3, 4, 5, 6, 8, 9, 10... 其中第 3 个是 4。
```


**示例 2：**

```
输入：n = 4, a = 2, b = 3, c = 4
输出：6
解释：丑数序列为 2, 3, 4, 6, 8, 9, 12... 其中第 4 个是 6。
```


**示例 3：**

```
输入：n = 5, a = 2, b = 11, c = 13
输出：10
解释：丑数序列为 2, 4, 6, 8, 10, 11, 12, 13... 其中第 5 个是 10。
```


**示例 4：**

```
输入：n = 1000000000, a = 2, b = 217983653, c = 336916467
输出：1999999984
```

**提示：**

-   $1 <= n, a, b, c <= 10^9$
-   $1 <= a * b * c <= 10^{18}$
-   `本题结果在 [1, 2 * 10^9] 的范围内`



## 2、解题思路

-   首先计算数字两两之间的最小公倍数
-   然后算出三个数的最小公倍数
-   计算出从最小的数字到最小公倍数之间有多少满足条件的数字，后面的数字将在这里面循环，只是初始值不同
-   通过二分法，找出目标值是这个循环中的第几个数字



```python
import math


class Solution:
    def nthUglyNumber(self, n: int, a: int, b: int, c: int) -> int:
        lcm_ab = a * b // math.gcd(a, b)
        lcm_ac = a * c // math.gcd(a, c)
        lcm_bc = b * c // math.gcd(b, c)

        lcm = lcm_ab * c // math.gcd(lcm_ab, c)

        def find_ugly_nums(k):
            # 找出<=K 的丑数的个数
            cur = 0
            cur += k // a + k // b + k // c - k // lcm_ab - k // lcm_ac - k // lcm_bc + k // lcm
            return cur

        cycle = find_ugly_nums(lcm)
        start = lcm * (n // cycle)
        pos = n % cycle
        if pos == 0:
            return start

        left = min(a, b, c)
        right = lcm

        while left < right:
            mid = (left + right) // 2
            if find_ugly_nums(mid) < pos:
                left = mid + 1
            else:
                right = mid
        return start + left
```

