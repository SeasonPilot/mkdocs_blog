# LeetCode: 5215. 黄金矿工

[TOC]

## 1、题目描述

你要开发一座金矿，地质勘测学家已经探明了这座金矿中的资源分布，并用大小为 `m * n` 的网格 `grid` 进行了标注。每个单元格中的整数就表示这一单元格中的黄金数量；如果该单元格是空的，那么就是 `0`。

为了使收益最大化，矿工需要按以下规则来开采黄金：

-   每当矿工进入一个单元，就会收集该单元格中的所有黄金。
-   矿工每次可以从当前位置向上下左右四个方向走。
-   每个单元格只能被开采（进入）一次。
-   **不得开采**（进入）黄金数目为 0 的单元格。
-   矿工可以从网格中 **任意一个** 有黄金的单元格出发或者是停止。



**示例 1：**

```
输入：grid = [[0,6,0],[5,8,7],[0,9,0]]
输出：24
解释：
[[0,6,0],
 [5,8,7],
 [0,9,0]]
一种收集最多黄金的路线是：9 -> 8 -> 7。
```


**示例 2：**

```
输入：grid = [[1,0,7],[2,0,6],[3,4,5],[0,3,0],[9,0,20]]
输出：28
解释：
[[1,0,7],
 [2,0,6],
 [3,4,5],
 [0,3,0],
 [9,0,20]]
一种收集最多黄金的路线是：1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7。
```

**提示：**

-   `1 <= grid.length, grid[i].length <= 15`
-   `0 <= grid[i][j] <= 100`
-   `最多 25 个单元格中有黄金。`



## 2、解题思路

-   DFS
-   设置一个访问过数组，在周围首先放置一圈1，代表访问过
-   将黄金为0的设置为访问过，表示不能继续访问



```python
class Solution:
    def getMaximumGold(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        visited = [[0 for _ in range(col + 2)] for _ in range(row + 2)]
        visited[0] = [1] * (col + 2)
        visited[-1] = [1] * (col + 2)

        for i in range(1, row + 1):
            visited[i][0] = 1
            visited[i][-1] = 1

        for i in range(row):
            for j in range(col):
                if not grid[i][j]:
                    visited[i + 1][j + 1] = 1

        ans = 0
        current = 0

        def get_surround(x, y):
            for dx, dy in surround:
                yield x + dx, y + dy

        def get_surround_count(x, y):
            count = 0
            for dx, dy in surround:
                x1, y1 = x + dx, y + dy
                if visited[x1 + 1][y1 + 1]:
                    count += 1
            return count

        def dfs(x, y):
            nonlocal ans, current
            current += grid[x][y]
            visited[x + 1][y + 1] = 1
            if get_surround_count(x, y) == 4:
                ans = max(ans, current)
            else:
                for x1, y1 in get_surround(x, y):
                    if not visited[x1 + 1][y1 + 1]:
                        dfs(x1, y1)

            visited[x + 1][y + 1] = 0
            current -= grid[x][y]

        for i in range(row):
            for j in range(col):
                if grid[i][j]:
                    dfs(i, j)
        return ans
```

