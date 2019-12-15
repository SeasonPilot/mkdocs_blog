# LeetCode: 1293. 网格中的最短路径

[TOC]

## 1、题目描述

给你一个 `m * n` 的网格，其中每个单元格不是 `0`（空）就是 `1`（障碍物）。每一步，您都可以在空白单元格中上、下、左、右移动。

如果您 最多 可以消除 `k` 个障碍物，请找出从左上角 `(0, 0)` 到右下角 `(m-1, n-1)` 的最短路径，并返回通过该路径所需的步数。如果找不到这样的路径，则返回 `-1`。

 

**示例 1：**

```
输入： 
grid = 
[[0,0,0],
 [1,1,0],
 [0,0,0],
 [0,1,1],
 [0,0,0]], 
k = 1
输出：6
解释：
不消除任何障碍的最短路径是 10。
消除位置 (3,2) 处的障碍后，最短路径是 6 。该路径是 (0,0) -> (0,1) -> (0,2) -> (1,2) -> (2,2) -> (3,2) -> (4,2).
```

**示例 2：**

```
输入：
grid = 
[[0,1,1],
 [1,1,1],
 [1,0,0]], 
k = 1
输出：-1
解释：
我们至少需要消除两个障碍才能找到这样的路径。
```

**提示：**

-   $grid.length == m$
-   $grid[0].length == n$
-   $1 <= m, n <= 40$
-   $1 <= k <= m*n$
-   $grid[i][j] == 0 or 1$
-   $grid[0][0] == grid[m-1][n-1] == 0$



## 2、解题思路

-   深度优先DFS

-   如果`k`大于等于`row + col - 2`，可以直接水平垂直过去，也是最短路径
-   最长的路径肯定是每个节点结果一遍，也就是`row*col-1`

-   设置一个三维数组

```
steps[i][j][k] 
表示从左上角[0,0]到达[i,j]节点经过k个障碍物的最小步数
使用深度优先搜索，首先判断当前节点中是否存在到达当前节点经过更少障碍物，并且步数更少，这时候就不需要按照当前路线推进了
如果不存在步数更少的情况，就在上下左右4个节点中进行寻找
```



```python
class Solution:
    def shortestPath(self, grid: List[List[int]], k: int) -> int:
        row, col = len(grid), len(grid[0])
        if k >= row + col - 2:
            return row + col - 2
        max_steps = row * col
        steps = [[[max_steps for _ in range(k + 1)] for _ in range(col)] for _ in range(row)]
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        def dfs(x, y, step, barrier):
            steps[x][y][barrier] = min(steps[x][y][barrier], step)

            if any([steps[x][y][i] < step for i in range(barrier)]):
                return
            next_barrier = barrier if grid[x][y] == 0 else barrier + 1
            if next_barrier > k:
                return

            for dx, dy in surround:
                nx, ny = x + dx, y + dy
                if available(nx, ny) and step + 1 < steps[nx][ny][next_barrier]:
                    dfs(nx, ny, step + 1, next_barrier)

        dfs(0, 0, 0, 0)
        res = min(steps[row - 1][col - 1])
        return res if res < max_steps else -1
```

