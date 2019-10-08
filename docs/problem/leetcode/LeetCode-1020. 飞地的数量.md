# LeetCode: 1020. 飞地的数量

[TOC]

## 1、题目描述

给出一个二维数组 `A`，每个单元格为 `0`（代表海）或 `1`（代表陆地）。

移动是指在陆地上从一个地方走到另一个地方（朝四个方向之一）或离开网格的边界。

返回网格中无法在任意次数的移动中离开网格边界的陆地单元格的数量。

 

**示例 1：**

```
输入：[[0,0,0,0],[1,0,1,0],[0,1,1,0],[0,0,0,0]]
输出：3
解释： 
有三个 1 被 0 包围。一个 1 没有被包围，因为它在边界上。
```


**示例 2：**

```
输入：[[0,1,1,0],[0,0,1,0],[0,0,1,0],[0,0,0,0]]
输出：0
解释：
所有 1 都在边界上或可以到达边界。
```

**提示：**

-   `1 <= A.length <= 500`
-   `1 <= A[i].length <= 500`
-   `0 <= A[i][j] <= 1`
-   `所有行的大小都相同`



## 2、解题思路

-   使用并查集，将所有的边界以及边界相连的都连接起来，不能连接的点就表示不能出边界



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))
        self.size = [1] * length

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            if xp > yp:
                self.size[xp] += self.size[yp]
                self.data[yp] = xp
            else:
                self.size[yp] += self.size[xp]
                self.data[xp] = yp

    def get_size(self, x):
        return self.size[x]

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def numEnclaves(self, A: List[List[int]]) -> int:
        ones_count = 0

        row, col = len(A), len(A[0])

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        last = row * col
        d = DFU(row * col + 1)

        for i in range(row):
            for j in range(col):
                if A[i][j]:
                    ones_count += 1
                    if i == 0 or j == 0 or i == row - 1 or j == col - 1:
                        d.union(i * col + j, last)

                    for dx, dy in surround:
                        x1, y1 = i + dx, j + dy
                        if available(x1, y1) and A[x1][y1]:
                            d.union(i * col + j, x1 * col + y1)
        return ones_count - d.get_size(last) + 1
```



也可以不使用并查集，直接利用一个集合，将所有的与边界相连接的点放进去，集合之外的点就表示不能出边界

