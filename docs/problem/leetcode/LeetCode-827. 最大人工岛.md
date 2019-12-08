# LeetCode: 827. 最大人工岛

[TOC]

## 1、题目描述

在二维地图上， `0`代表海洋， `1`代表陆地，我们最多只能将一格 `0` 海洋变成 `1`变成陆地。

进行填海之后，地图上最大的岛屿面积是多少？（上、下、左、右四个方向相连的 `1` 可形成岛屿）

**示例 1:**

```
输入: [[1, 0], [0, 1]]
输出: 3
解释: 将一格0变成1，最终连通两个小岛得到面积为 3 的岛屿。
```


**示例 2:**

```
输入: [[1, 1], [1, 0]]
输出: 4
解释: 将一格0变成1，岛屿的面积扩大为 4。
```


**示例 3:**

```
输入: [[1, 1], [1, 1]]
输出: 4
解释: 没有0可以让我们变成1，面积依然为 4。
```


**说明:**

-   $1 <= grid.length = grid[0].length <= 50$
-   $0 <= grid[i][j] <= 1$

## 2、解题思路

-   使用并查集
-   首先将所有的1以及相邻的1放入并查集中，并统计数量
-   然后对每一个0进行遍历，找出上下左右中在并查集中的数量(不同集合)
-   更新结果即可



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))
        self.size = [0] * length

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            if self.size[xp] > self.size[yp]:
                self.size[xp] += self.size[yp]
                self.data[yp] = xp
            else:
                self.size[yp] += self.size[xp]
                self.data[xp] = yp

    def get_size(self, x):
        return self.size[self.find(x)]


class Solution:
    def largestIsland(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])

        d = DFU(row * col)
        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        ans = 0
        for i in range(row):
            for j in range(col):
                cur = i * col + j
                top = (i - 1) * col + j
                left = i * col + j - 1
                if grid[i][j]:
                    d.size[cur] = 1
                else:
                    continue
                if available(i - 1, j) and grid[i - 1][j]:
                    d.union(cur, top)
                if available(i, j - 1) and grid[i][j - 1]:
                    d.union(cur, left)
                ans = max(ans, d.get_size(cur))

        for i in range(row):
            for j in range(col):
                if grid[i][j]:
                    continue
                current = 1
                temp = set()
                for dx, dy in surround:
                    nx, ny = i + dx, j + dy
                    if available(nx, ny):
                        size_ancestor = d.find(nx * col + ny)
                        if size_ancestor in temp:
                            continue
                        current += d.get_size(size_ancestor)
                        temp.add(size_ancestor)

                ans = max(ans, current)

        return ans

```

