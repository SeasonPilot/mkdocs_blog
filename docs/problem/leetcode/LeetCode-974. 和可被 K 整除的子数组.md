# LeetCode: 974. 和可被 K 整除的子数组

[TOC]

## 1、题目描述

给定一个整数数组 `A`，返回其中元素之和可被 `K` 整除的（连续、非空）子数组的数目。

 

**示例：**

```
输入：A = [4,5,0,-2,-3,1], K = 5
输出：7
解释：
有 7 个子数组满足其元素之和可被 K = 5 整除：
[4, 5, 0, -2, -3, 1], [5], [5, 0], [5, 0, -2, -3], [0], [0, -2, -3], [-2, -3]
```

**提示：**

-   $1 <= A.length <= 30000$
-   $-10000 <= A[i] <= 10000$
-   $2 <= K <= 10000$



## 2、解题思路

-   使用取余的方式判断
-   如果中间一段能够整除5，那么这两个位置的前缀和对于`K`取余数肯定是相同的

-   根据余数相同的数量，这一段组成的数量为`x*(x-1)//2`



```python
from collections import defaultdict


class Solution:
    def subarraysDivByK(self, A: List[int], K: int) -> int:
        d = defaultdict(int)
        d[0] = 1
        sums = 0
        for num in A:
            sums = (sums + num) % K
            d[sums] += 1


        return sum([x * (x - 1) // 2 for x in d.values()])
```

