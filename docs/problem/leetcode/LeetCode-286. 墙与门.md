# LeetCode: 286. 墙与门

[TOC]

## 1、题目描述

你被给定一个 `m × n` 的二维网格，网格中有以下三种可能的初始化值：

1.  `-1` 表示墙或是障碍物
2.  `0` 表示一扇门
3.  `INF` 无限表示一个空的房间。然后，我们用 `231 - 1 = 2147483647` 代表 `INF`。你可以认为通往门的距离总是小于 `2147483647` 的。

你要给每个空房间位上填上该房间到 最近 门的距离，如果无法到达门，则填 `INF` 即可。

**示例：**

给定二维网格：

```
INF  -1  0  INF
INF INF INF  -1
INF  -1 INF  -1
  0  -1 INF INF
```


运行完你的函数后，该网格应该变成：

```
  3  -1   0   1
  2   2   1  -1
  1  -1   2  -1
  0  -1   3   4
```



## 2、解题思路

-   基于队列的广度优先更新
-   从`0`开始不断地更新周围的值，直到队列为空即可



```python
from collections import deque


class Solution:
    def wallsAndGates(self, rooms: List[List[int]]) -> None:
        """
        Do not return anything, modify rooms in-place instead.
        """
        if not rooms:
            return
        d = deque()
        row, col = len(rooms), len(rooms[0])
        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        for i in range(row):
            for j in range(col):
                if rooms[i][j] == 0:
                    d.append([i, j, 0])
        while d:
            x, y, step = d.popleft()
            for dx, dy in surround:
                nx, ny = x + dx, y + dy
                if available(nx, ny) and rooms[nx][ny] != -1 and step + 1 < rooms[nx][ny]:
                    rooms[nx][ny] = step + 1
                    d.append([nx, ny, step + 1])
        
        
```

