# LeetCode: 1281. 整数的各位积和之差

[TOC]

## 1、题目描述

给你一个整数 `n`，请你帮忙计算并返回该整数「各位数字之积」与「各位数字之和」的差。

 

**示例 1：**

```
输入：n = 234
输出：15 
解释：
各位数之积 = 2 * 3 * 4 = 24 
各位数之和 = 2 + 3 + 4 = 9 
结果 = 24 - 9 = 15
```


**示例 2：**

```
输入：n = 4421
输出：21
解释： 
各位数之积 = 4 * 4 * 2 * 1 = 32 
各位数之和 = 4 + 4 + 2 + 1 = 11 
结果 = 32 - 11 = 21
```

**提示：**

-   $1 <= n <= 10^5$

## 2、解题思路

-   转换成字符串，然后每一位直接计算即可



```python
from functools import reduce


class Solution:
    def subtractProductAndSum(self, n: int) -> int:
        nums = str(n)
        plus = reduce(lambda x, y: int(x) * int(y), nums)
        sums = reduce(lambda x, y: int(x) + int(y), nums)
        return int(plus) - int(sums)
```

