# LeetCode: 305. 岛屿数量II

[TOC]

## 1、题目描述

假设你设计一个游戏，用一个 `m` 行 `n` 列的 `2D` 网格来存储你的游戏地图。

起始的时候，每个格子的地形都被默认标记为`「水」`。我们可以通过使用 `addLand` 进行操作，将位置 `(row, col)` 的`「水」`变成`「陆地」`。

你将会被给定一个列表，来记录所有需要被操作的位置，然后你需要返回计算出来 **每次 addLand 操作后岛屿的数量**。

注意：一个岛的定义是被`「水」`包围的`「陆地」`，通过水平方向或者垂直方向上相邻的陆地连接而成。你可以假设地图网格的四边均被无边无际的`「水」`所包围。

请仔细阅读下方示例与解析，更加深入了解岛屿的判定。

**示例:**

```
输入: m = 3, n = 3, positions = [[0,0], [0,1], [1,2], [2,1]]
输出: [1,1,2,3]
解析:

起初，二维网格 grid 被全部注入「水」。（0 代表「水」，1 代表「陆地」）

0 0 0
0 0 0
0 0 0
操作 #1：addLand(0, 0) 将 grid[0][0] 的水变为陆地。

1 0 0
0 0 0   Number of islands = 1
0 0 0
操作 #2：addLand(0, 1) 将 grid[0][1] 的水变为陆地。

1 1 0
0 0 0   岛屿的数量为 1
0 0 0
操作 #3：addLand(1, 2) 将 grid[1][2] 的水变为陆地。

1 1 0
0 0 1   岛屿的数量为 2
0 0 0
操作 #4：addLand(2, 1) 将 grid[2][1] 的水变为陆地。

1 1 0
0 0 1   岛屿的数量为 3
0 1 0
```

**拓展：**

-   `你是否能在 O(k log mn) 的时间复杂度程度内完成每次的计算？（k 表示 positions 的长度）`



## 2、解题思路

-   使用并查集
-   首先将所有的元素都设置为一个额外的值，用做判断是否是陆地
-   然后不断的更新陆地的值，并将陆地周围连接
-   判断每次连接到的岛屿的数量
    -   没有岛屿，岛屿数量加一
    -   有一个岛屿，数量不变
    -   两个岛屿，减少一个岛屿
    -   三个岛屿，减少两个岛屿
    -   四个岛屿，减少三个岛屿



```python
from typing import List


class DFU:
    def __init__(self, length):
        self.data = [length] * length

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def numIslands2(self, m: int, n: int, positions: List[List[int]]) -> List[int]:
        ans = [0]
        last_flag = m * n + 1
        d = DFU(m * n + 1)
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def available(a, b):
            return 0 <= a < m and 0 <= b < n

        for x, y in positions:
            cur = x * n + y
            if d.data[cur] != last_flag:
                ans.append(ans[-1])
                continue
            d.data[cur] = cur
            appear = set()
            for dx, dy in surround:
                nx, ny = x + dx, y + dy
                surround_position = nx * n + ny
                if available(nx, ny) and d.data[surround_position] != last_flag:
                    appear.add(d.find(surround_position))
                    d.union(cur, surround_position)
            if not appear:
                ans.append(ans[-1] + 1)
            else:
                ans.append(ans[-1] + 1 - len(appear))
        return ans[1:]
    
```

