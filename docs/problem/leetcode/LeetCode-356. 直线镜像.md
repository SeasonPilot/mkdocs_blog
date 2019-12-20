# LeetCode: 356. 直线镜像

[TOC]

## 1、题目描述

在一个二维平面空间中，给你 `n` 个点的坐标。问，是否能找出一条平行于 y 轴的直线，让这些点关于这条直线成镜像排布？

**示例 1：**

```
输入: [[1,1],[-1,1]]
输出: true
```


**示例 2：**

```
输入: [[1,1],[-1,-1]]
输出: false
拓展：
你能找到比 O(n2) 更优的解法吗?


```



## 2、解题思路

-   对称轴检查
-   如果存在多个对称轴，返回`False`



```python
from collections import defaultdict
from fractions import Fraction


class Solution:
    def isReflected(self, points: List[List[int]]) -> bool:
        if not points or len(points) == 1:
            return True

        mid = set()

        d = defaultdict(set)
        for x, y in points:
            d[y].add(x)

        for v in d.values():
            length = len(v)
            half = length // 2
            temp = sorted(v)
            for i in range(half):
                mid.add(Fraction(temp[i] + temp[-1 - i], 2))
            if length % 2:
                mid.add(Fraction(temp[half], 1))
            if len(mid) > 1:
                return False
        return True
```

