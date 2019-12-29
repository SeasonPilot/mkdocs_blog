# LeetCode: 694. 不同岛屿的数量

[TOC]

## 1、题目描述

给定一个非空`01`二维数组表示的网格，一个岛屿由四连通（上、下、左、右四个方向）的 `1` 组成，你可以认为网格的四周被海水包围。

请你计算这个网格中共有多少个形状不同的岛屿。两个岛屿被认为是相同的，当且仅当一个岛屿可以通过平移变换（不可以旋转、翻转）和另一个岛屿重合。

 

**样例 1:**

```
11000
11000
00011
00011
给定上图，返回结果 1。
```

**样例 2:**

```
11011
10000
00001
11011
给定上图，返回结果 3。
```

**注意:**

```
11
1
```

和

```
 1
11
```

是不同的岛屿，因为我们不考虑旋转、翻转操作。

 

**注释 :**  二维数组每维的大小都不会超过`50`。



## 2、解题思路

-   关键点在于如何唯一确定一个形状
-   使用岛屿的左上角的节点做起始节点，使用`BFS`，找出所有节点，相对距离作为标识



```python
from collections import deque


class Solution:
    def numDistinctIslands(self, grid: List[List[int]]) -> int:
        if not grid:
            return 0
        row, col = len(grid), len(grid[0])
        visited = [[0 for _ in range(col)] for _ in range(row)]
        res = set()
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        def bfs(x, y):
            ans = []
            d = deque()
            d.append((x, y))
            visited[x][y] = 1
            while d:
                i, j = d.popleft()
                for di, dj in surround:
                    ni, nj = i + di, j + dj
                    if available(ni, nj) and not visited[ni][nj] and grid[ni][nj]:
                        ans.append(str(ni - x) + str(nj - y))
                        d.append((ni, nj))
                        visited[ni][nj] = 1
            return "".join(ans)

        for x in range(row):
            for y in range(col):
                if not visited[x][y] and grid[x][y] == 1:
                    res.add(bfs(x, y))
        return len(res)

```

