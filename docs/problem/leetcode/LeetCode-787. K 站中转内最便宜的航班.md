# LeetCode: 787. K 站中转内最便宜的航班

[TOC]

## 1、题目描述

有 `n` 个城市通过 `m` 个航班连接。每个航班都从城市 `u` 开始，以价格 `w` 抵达 `v`。

现在给定所有的城市和航班，以及出发城市 `src` 和目的地 `dst`，你的任务是找到从 `src` 到 `dst` 最多经过 `k` 站中转的最便宜的价格。 如果没有这样的路线，则输出 `-1`。

示例 1:

```
输入: 
n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
src = 0, dst = 2, k = 1
输出: 200
解释: 
城市航班图如下
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-23-082038.png)





```
从城市 0 到城市 2 在 1 站中转以内的最便宜价格是 200，如图中红色所示。
```

**示例 2:**

```
输入: 
n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
src = 0, dst = 2, k = 0
输出: 500
解释: 
城市航班图如下
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-23-082050.png)

```
从城市 0 到城市 2 在 0 站中转以内的最便宜价格是 500，如图中蓝色所示。
```

**提示：**

-   `n 范围是 [1, 100]，城市标签从 0 到 n - 1.`
-   `航班数量范围是 [0, n * (n - 1) / 2].`
-   `每个航班的格式 (src, dst, price).`
-   `每个航班的价格范围是 [1, 10000].`
-   `k 范围是 [0, n - 1].`
-   `航班没有重复，且不存在环路`



## 2、解题思路

-   动态规划

初始化：

```
dp[i][k]: 表示从src到 i 节点 在k步之内的最短花费
```

状态转换方程：

从下向上更新，首先更新两步花费，然后一直更新到k步

```python
# 从两步开始更新
for step in range(2, steps + 1):
    # 更新所有的节点
    for i in range(n):
        dp[i][step] = dp[i][step - 1]
        for pre in previous[i]:
            # 根据前面的相连接的节点更新当前节点
            dp[i][step] = min(dp[i][step], dp[pre[0]][step - 1] + pre[1])
```

**实例代码：**

```python
from collections import defaultdict


class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, K: int) -> int:
        previous = defaultdict(list)

        steps = K + 1
        inf = float("inf")
        dp = [[inf for _ in range(steps + 1)] for _ in range(n)]

        for s, d, cost in flights:
            previous[d].append([s, cost])
            if s == src:
                dp[d][1] = cost

        for step in range(2, steps + 1):
            for i in range(n):
                dp[i][step] = dp[i][step - 1]
                for pre in previous[i]:
                    dp[i][step] = min(dp[i][step], dp[pre[0]][step - 1] + pre[1])

        return dp[dst][steps] if dp[dst][steps] != inf else -1
```

