# LeetCode: 1254. 统计封闭岛屿的数目

[TOC]

## 1、题目描述

有一个二维矩阵 `grid` ，每个位置要么是陆地（记号为 `0` ）要么是水域（记号为 `1` ）。

我们从一块陆地出发，每次可以往上下左右 `4` 个方向相邻区域走，能走到的所有陆地区域，我们将其称为一座「岛屿」。

如果一座岛屿 完全 由水域包围，即陆地边缘上下左右所有相邻区域都是水域，那么我们将其称为 「封闭岛屿」。

请返回封闭岛屿的数目。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-12-105038.png)

```
输入：grid = [[1,1,1,1,1,1,1,0],[1,0,0,0,0,1,1,0],[1,0,1,0,1,1,1,0],[1,0,0,0,0,1,0,1],[1,1,1,1,1,1,1,0]]
输出：2
解释：
灰色区域的岛屿是封闭岛屿，因为这座岛屿完全被水域包围（即被 1 区域包围）。
```


**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-12-105048.png)

```
输入：grid = [[0,0,1,0,0],[0,1,0,1,0],[0,1,1,1,0]]
输出：1
示例 3：

输入：grid = [[1,1,1,1,1,1,1],
             [1,0,0,0,0,0,1],
             [1,0,1,1,1,0,1],
             [1,0,1,0,1,0,1],
             [1,0,1,1,1,0,1],
             [1,0,0,0,0,0,1],
             [1,1,1,1,1,1,1]]
输出：2
```

**提示：**

-   $1 <= grid.length, grid[0].length <= 100$
-   $0 <= grid[i][j] <=1$



## 2、解题思路

-   使用并查集
-   将所有的水以及靠边的陆地都放到同一个集合中
-   最后统计集合数量减一即可

也可以使用`dfs`标记法，标记以后判断标记的数量即可



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            if xp > yp:
                self.data[yp] = xp
            else:
                self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def closedIsland(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])
        length = row * col
        d = DFU(length + 1)
        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        for r, row_line in enumerate(grid):
            for c, item in enumerate(row_line):
                if item == 1 or r in [0, row - 1] or c in [0, col - 1]:
                    d.union(length, r * col + c)
                else:
                    for dx, dy in surround:
                        nr, nc = r + dx, c + dy
                        if available(nr, nc) and grid[nr][nc] == 0:
                            d.union(r * col + c, nr * col + nc)
        return d.count() - 1
```

