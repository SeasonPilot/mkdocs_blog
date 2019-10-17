# LeetCode: 939. 最小面积矩形

[TOC]

## 1、题目描述

给定在 `xy` 平面上的一组点，确定由这些点组成的矩形的最小面积，其中矩形的边平行于 `x` 轴和 `y` 轴。

如果没有任何矩形，就返回 `0`。

 

**示例 1：**

```
输入：[[1,1],[1,3],[3,1],[3,3],[2,2]]
输出：4
```


**示例 2：**

```
输入：[[1,1],[1,3],[3,1],[3,3],[4,1],[4,3]]
输出：2
```

**提示：**

-   `1 <= points.length <= 500`
-   `0 <= points[i][0] <= 40000`
-   `0 <= points[i][1] <= 40000`
-   `所有的点都是不同的。`



## 2、解题思路

-   首先按照横坐标为key，纵坐标放入对应的set中
-   判断两个横坐标对应的set中，是否存在交集，并且交集超过2，排序交集纵坐标，更新面积



```python
from collections import defaultdict
from itertools import combinations


class Solution:
    def minAreaRect(self, points: List[List[int]]) -> int:
        pos_map = defaultdict(set)
        inf = float('inf')
        ans = inf

        for x, y in points:
            pos_map[x].add(y)

        for x1, x2 in combinations(pos_map.keys(), 2):
            row = abs(x1 - x2)
            temp = list(sorted(pos_map[x1] & pos_map[x2]))
            for i in range(1, len(temp)):
                col = temp[i] - temp[i - 1]
                if col:
                    ans = min(ans, row * col)

        return ans if ans != inf else 0
```

