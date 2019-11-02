# LeetCode: 1091. 二进制矩阵中的最短路径

[TOC]

## 1、题目描述

在一个 `N × N` 的方形网格中，每个单元格有两种状态：空`（0）`或者阻塞`（1）`。

一条从左上角到右下角、长度为 `k` 的畅通路径，由满足下述条件的单元格 `C_1, C_2, ..., C_k` 组成：

-   `相邻单元格 C_i 和 C_{i+1} 在八个方向之一上连通（此时，C_i 和 C_{i+1} 不同且共享边或角）`
-   `C_1 位于 (0, 0)（即，值为 grid[0][0]）`
-   `C_k 位于 (N-1, N-1)（即，值为 grid[N-1][N-1]）`
-   `如果 C_i 位于 (r, c)，则 grid[r][c] 为空（即，grid[r][c] == 0）`


返回这条从左上角到右下角的最短畅通路径的长度。如果不存在这样的路径，返回 `-1` 。

 


**示例 1：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-02-060432.png" alt="img" style="zoom:33%;" />

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-02-060435.png" alt="img" style="zoom:33%;" />

```
输入：[[0,1],[1,0]]

输出：2
```

**示例 2：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-02-060505.png" alt="img" style="zoom:33%;" />

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-02-060507.png" alt="img" style="zoom:33%;" />

```
输入：[[0,0,0],[1,1,0],[1,1,0]]

输出：4
```

 

**提示：**

-   $1 <= grid.length == grid[0].length <= 100$
-   $grid[i][j] 为 0 或 1$



## 2、解题思路

-   广度优先搜索
-   需要注意的就是初始值可能为0，需要处理一下



```python
class Solution:
    def shortestPathBinaryMatrix(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])

        visited = {(0, 0), }

        def get_surround(m, n):
            surround = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            for dm, dn in surround:
                m1, n1 = m + dm, n + dn
                if 0 <= m1 < row and 0 <= n1 < col:
                    yield m1, n1
        d = []
        if grid[0][0] == 0:
            d.append((0, 0))
        step = 1
        while d:
            next_d = []
            for x, y in d:
                if x == row - 1 and y == col - 1:
                    return step

                for x1, y1 in get_surround(x, y):
                    if grid[x1][y1] == 0 and (x1, y1) not in visited:
                        next_d.append((x1, y1))
                        visited.add((x1, y1))
            d = next_d
            step += 1

        return -1
```

