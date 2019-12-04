# LeetCode: 1210. 穿过迷宫的最少移动次数

[TOC]

## 1、题目描述

你还记得那条风靡全球的贪吃蛇吗？

我们在一个 `n*n` 的网格上构建了新的迷宫地图，蛇的长度为 `2`，也就是说它会占去两个单元格。蛇会从左上角`（(0, 0)` 和 `(0, 1)）`开始移动。我们用 `0` 表示空单元格，用 `1` 表示障碍物。蛇需要移动到迷宫的右下角`（(n-1, n-2)` 和 `(n-1, n-1)）`。

每次移动，蛇可以这样走：

-   如果没有障碍，则向右移动一个单元格。并仍然保持身体的水平／竖直状态。
-   如果没有障碍，则向下移动一个单元格。并仍然保持身体的水平／竖直状态。
-   如果它处于水平状态并且其下面的两个单元都是空的，就顺时针旋转 `90` 度。蛇从`（(r, c)、(r, c+1)）`移动到 `（(r, c)、(r+1, c)）`。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-04-065754.png)

-   如果它处于竖直状态并且其右面的两个单元都是空的，就逆时针旋转 `90` 度。蛇从`（(r, c)、(r+1, c)）`移动到`（(r, c)、(r, c+1)）`。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-04-065800.png)

返回蛇抵达目的地所需的最少移动次数。

如果无法到达目的地，请返回 `-1`。

 

**示例 1：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-04-065817.png" alt="img" style="zoom:50%;" />

```
输入：grid = [[0,0,0,0,0,1],
               [1,1,0,0,1,0],
               [0,0,0,0,1,1],
               [0,0,1,0,1,0],
               [0,1,1,0,0,0],
               [0,1,1,0,0,0]]
输出：11
解释：
一种可能的解决方案是 [右, 右, 顺时针旋转, 右, 下, 下, 下, 下, 逆时针旋转, 右, 下]。
```


**示例 2：**

```
输入：grid = [[0,0,1,1,1,1],
               [0,0,0,0,1,1],
               [1,1,0,0,0,1],
               [1,1,1,0,0,1],
               [1,1,1,0,0,1],
               [1,1,1,0,0,0]]
输出：9
```

**提示：**

-   $2 <= n <= 100$
-   $0 <= grid[i][j] <= 1$
-   蛇保证从空单元格开始出发。



## 2、解题思路

-   使用`Dijkstra`算法
-   将每个点可能的通路保存到图中，找出最短路径



```python
from collections import defaultdict
import heapq


class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])

        graph = defaultdict(list)

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        # 转换成图
        for i in range(row):
            for j in range(col):
                if available(i, j) and not grid[i][j] and available(i, j + 1) and not grid[i][j + 1]:
                    # 水平
                    cur = (i * col + j, i * col + j + 1)
                    if available(i, j + 2) and not grid[i][j + 2]:
                        # 右移
                        graph[cur].append((i * col + j + 1, i * col + j + 2))
                    if available(i + 1, j) and not grid[i + 1][j] and available(i + 1, j + 1) and not grid[i + 1][j + 1]:
                        # 下移
                        graph[cur].append(((i + 1) * col + j, (i + 1) * col + j + 1))
                    if available(i + 1, j) and not grid[i + 1][j] and available(i + 1, j + 1) and not grid[i + 1][j + 1]:
                        # 顺时针旋转
                        graph[cur].append((i * col + j, (i + 1) * col + j))
                if available(i, j) and not grid[i][j] and available(i + 1, j) and not grid[i + 1][j]:
                    # 垂直
                    cur = (i * col + j, (i + 1) * col + j)
                    if available(i + 2, j) and not grid[i + 2][j]:
                        # 下移
                        graph[cur].append(((i + 1) * col + j, (i + 2) * col + j))
                    if available(i, j + 1) and not grid[i][j + 1] and available(i + 1, j + 1) and not grid[i + 1][j + 1]:
                        # 右移
                        graph[cur].append((i * col + j + 1, (i + 1) * col + j + 1))
                    if available(i, j + 1) and not grid[i][j + 1] and available(i + 1, j + 1) and not grid[i + 1][j + 1]:
                        # 逆时针旋转
                        graph[cur].append((i * col + j, i * col + j + 1))

        source = (0, 1)
        target = (row * col - 2, row * col - 1)
        dis = {source: 0}
        q = []

        for n in graph[source]:
            heapq.heappush(q, [1, n])
        while q:
            weight, node = heapq.heappop(q)
            if node in dis:
                continue
            dis[node] = weight
            for next_node in graph[node]:
                if next_node not in dis:
                    heapq.heappush(q, [weight + 1, next_node])
        return -1 if target not in dis else dis[target]

```

