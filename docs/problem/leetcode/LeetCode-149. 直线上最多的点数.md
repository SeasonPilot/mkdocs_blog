# LeetCode: 149. 直线上最多的点数

[TOC]

## 1、题目描述

给定一个二维平面，平面上有 `n` 个点，求最多有多少个点在同一条直线上。

**示例 1:**

```
输入: [[1,1],[2,2],[3,3]]
输出: 3
解释:
^
|
|        o
|     o
|  o  
+------------->
0  1  2  3  4
```


**示例 2:**

```
输入: [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
输出: 4
解释:
^
|
|  o
|     o        o
|        o
|  o        o
+------------------->
0  1  2  3  4  5  6
```



## 2、解题思路

-   这个题目主要是基于斜率进行判断
-   首先做一下去重
-   首先是节点a，对其他所有节点判断一次斜率，将斜率相同的加起来
-   然后将a点移除，然后重新选择一个节点，执行上面的操作，直到集合中只有一个元素为止



```python
import fractions
import collections


class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        count = collections.Counter([tuple(p) for p in points])
        if len(count) <= 2:
            return len(points)
        length = len(count)

        ans = 0
        for _ in range(1, length):
            (x, y), nums = count.popitem()
            slope = collections.defaultdict(lambda: nums)

            for (m, n), c in count.items():
                if x == m and y != n:
                    slope["0/" + str(x)] += c
                elif x != m and y == n:
                    slope[str(y) + "/0"] += c
                else:
                    slope[str(fractions.Fraction(n - y, m - x))] += c

            ans = max(ans, max(slope.values()))

        return ans

```

