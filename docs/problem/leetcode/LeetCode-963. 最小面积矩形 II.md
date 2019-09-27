# LeetCode: 963. 最小面积矩形 II

[TOC]

## 1、题目描述

给定在 `xy` 平面上的一组点，确定由这些点组成的任何矩形的最小面积，其中矩形的边不一定平行于 `x` 轴和 `y` 轴。

如果没有任何矩形，就返回 `0`。

 

**示例 1：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-27-075624.png" alt="img" style="zoom:50%;" />

```
输入：[[1,2],[2,1],[1,0],[0,1]]
输出：2.00000
解释：最小面积的矩形出现在 [1,2],[2,1],[1,0],[0,1] 处，面积为 2。
```


**示例 2：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-27-075639.png" alt="img" style="zoom:50%;" />

```
输入：[[0,1],[2,1],[1,1],[1,0],[2,0]]
输出：1.00000
解释：最小面积的矩形出现在 [1,0],[1,1],[2,1],[2,0] 处，面积为 1。
```


**示例 3：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-27-075651.png" alt="img" style="zoom:50%;" />

```
输入：[[0,3],[1,2],[3,1],[1,3],[2,1]]
输出：0
解释：没法从这些点中组成任何矩形。
```


**示例 4：**

![img](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/21/4c.png)

```
输入：[[3,1],[1,1],[0,1],[2,1],[3,3],[3,2],[0,2],[2,3]]
输出：2.00000
解释：最小面积的矩形出现在 [2,1],[2,3],[3,3],[3,1] 处，面积为 2。
```

**提示：**

-   `1 <= points.length <= 50`
-   `0 <= points[i][0] <= 40000`
-   `0 <= points[i][1] <= 40000`
-   `所有的点都是不同的。`
-   `与真实值误差不超过 10^-5 的答案将视为正确结果。`



## 2、解题思路

-   根据对角线进行归类，如果4个点想要组成一个矩形，肯定是对角线相同

-   按照对角线长度将一对点放入集合中

-   在集合中找出两组，

    -   首先判断是否是对角线
    -   然后判断边是否满足矩形，满足则更新矩形面积

    

```python
from itertools import combinations
from collections import defaultdict
import math


class Solution:
    def minAreaFreeRect(self, points: List[List[int]]) -> float:
        inf = float('inf')
        ans = inf

        diagonal = defaultdict(list)
        for (x1, y1), (x2, y2) in combinations(points, 2):
            diagonal[abs(x1 - x2) ** 2 + abs(y1 - y2) ** 2].append([[x1, y1], [x2, y2]])

        remove_point = []
        for k in diagonal:
            if len(diagonal[k]) < 2:
                remove_point.append(k)

        for remove in remove_point:
            diagonal.pop(remove)

        for values in diagonal.values():
            for t1, t2 in combinations(values, 2):
                if len(set((x, y) for x, y in t1 + t2)) != 4:
                    continue
                # print(t1, t2)
                [x1, y1], [x2, y2] = t1
                [x3, y3], [x4, y4] = t2

                # 判断是否是对角线

                if (x1 + x2 == x3 + x4) and (y1 + y2 == y3 + y4):
                    edge1 = abs(x1 - x3) ** 2 + abs(y1 - y3) ** 2
                    edge2 = abs(x1 - x4) ** 2 + abs(y1 - y4) ** 2
                    edge3 = abs(x2 - x3) ** 2 + abs(y2 - y3) ** 2
                    edge4 = abs(x2 - x4) ** 2 + abs(y2 - y4) ** 2

                    if edge1 == edge4 and edge2 == edge3:
                        ans = min(ans, math.sqrt(edge1 * edge2))

        return ans if ans != inf else 0.0
```

