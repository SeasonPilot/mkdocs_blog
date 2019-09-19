# LeetCode: 994. 腐烂的橘子

[TOC]

## 1、题目描述

在给定的网格中，每个单元格可以有以下三个值之一：

值 0 代表空单元格；
值 1 代表新鲜橘子；
值 2 代表腐烂的橘子。
每分钟，任何与腐烂的橘子（在 4 个正方向上）相邻的新鲜橘子都会腐烂。

返回直到单元格中没有新鲜橘子为止所必须经过的最小分钟数。如果不可能，返回 -1。

**示例 1：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-051342.png)

```

输入：[[2,1,1],[1,1,0],[0,1,1]]
输出：4
```

**示例 2：**

```
输入：[[2,1,1],[0,1,1],[1,0,1]]
输出：-1
解释：左下角的橘子（第 2 行， 第 0 列）永远不会腐烂，因为腐烂只会发生在 4 个正向上。
```

**示例 3：**

```
输入：[[0,2]]
输出：0
解释：因为 0 分钟时已经没有新鲜橘子了，所以答案就是 0 。
```



## 2、解题思路

- 可以使用广度优先搜索
- 从腐烂的橘子为起点，每次感染周围4个橘子，直到所有能被感染的橘子都被感染为止

或者使用双端队列

- 首先将橘子的坐标与感染时间放进去
- 每次取出一个感染橘子，去感染周围的橘子，将新感染的放入队列，时间+1
- 依次判断，直到队列为空
- 此时判断是否存在未感染的橘子，存在则返回-1，不存在返回最后一个被感染的橘子的时间

```python
from collections import deque
class Solution:
    def orangesRotting(self, grid: List[List[int]]) -> int:
        R, C = len(grid), len(grid[0])
        q = deque()

        for r, row in enumerate(grid):
            for c, num in enumerate(row):
                if num == 2:
                    # 记录腐烂的橘子位置以及腐烂需要的时间
                    q.append((r, c, 0))
        total = 0
        while q:
            r, c, total = q.popleft()
            for row, col in ((r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)):
                if 0 <= row < R and 0 <= col < C:
                    if grid[row][col] == 1:
                        q.append((row, col, total + 1))
                        grid[row][col] = 2
        if any((1 in row) for row in grid):
            return -1
        return total
```

