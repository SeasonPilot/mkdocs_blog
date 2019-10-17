# LeetCode: 808. 分汤

[TOC]

## 1、题目描述

有 A 和 B 两种类型的汤。一开始每种类型的汤有 N 毫升。有四种分配操作：

1.  提供 100ml 的汤A 和 0ml 的汤B。
2.  提供 75ml 的汤A 和 25ml 的汤B。
3.  提供 50ml 的汤A 和 50ml 的汤B。
4.  提供 25ml 的汤A 和 75ml 的汤B。

当我们把汤分配给某人之后，汤就没有了。每个回合，我们将从四种概率同为0.25的操作中进行分配选择。如果汤的剩余量不足以完成某次操作，我们将尽可能分配。当两种类型的汤都分配完时，停止操作。

-   注意不存在先分配100 ml汤B的操作。

需要返回的值： `汤A先分配完的概率` + `汤A和汤B同时分配完的概率 / 2`。

**示例:**
```
输入: N = 50
输出: 0.625
解释:
如果我们选择前两个操作，A将首先变为空。对于第三个操作，A和B会同时变为空。对于第四个操作，B将首先变为空。
所以A变为空的总概率加上A和B同时变为空的概率的一半是 0.25 *(1 + 1 + 0.5 + 0)= 0.625。
```


**注释:**

-   `0 <= N <= 10^9。`
-   `返回值在 10^-6 的范围将被认为是正确的。`



## 2、解题思路

-   DFS+记忆化



```python
from functools import lru_cache


class Solution:
    def soupServings(self, N: int) -> float:
        if N > 5000:
            return 1.0

        @lru_cache(None)
        def dfs(a, b):
            ans = 0

            if a <= 100 and b > 0:
                ans += 0.25
            elif a <= 100 and b <= 0:
                ans += 0.125
            elif a > 100 and b > 0:
                ans += 0.25 * dfs(a - 100, b)

            if a <= 75 and b > 25:
                ans += 0.25
            elif a <= 75 and b <= 25:
                ans += 0.125
            elif a > 75 and b > 25:
                ans += 0.25 * dfs(a - 75, b - 25)

            if a <= 50 and b > 50:
                ans += 0.25
            elif a <= 50 and b <= 50:
                ans += 0.125
            elif a > 50 and b > 50:
                ans += 0.25 * dfs(a - 50, b - 50)

            if a <= 25 and b > 75:
                ans += 0.25
            elif a <= 25 and b <= 75:
                ans += 0.125
            elif a > 25 and b > 75:
                ans += 0.25 * dfs(a - 25, b - 75)

            return ans

        return dfs(N, N)

```

