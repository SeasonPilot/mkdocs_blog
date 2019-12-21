# LeetCode: 490. 迷宫

[TOC]

## 1、题目描述

由空地和墙组成的迷宫中有一个**球**。球可以向**上下左右**四个方向滚动，但在遇到墙壁前不会停止滚动。当球停下时，可以选择下一个方向。

给定球的**起始位置**，**目的地**和**迷宫**，判断球能否在目的地停下。

迷宫由一个**0**和**1**的二维数组表示。 **1**表示墙壁，**0**表示空地。你可以假定迷宫的边缘都是墙壁。起始位置和目的地的坐标通过行号和列号给出。

 

示例 1:

```
输入 1: 迷宫由以下二维数组表示

0 0 1 0 0
0 0 0 0 0
0 0 0 1 0
1 1 0 1 1
0 0 0 0 0

输入 2: 起始位置坐标 (rowStart, colStart) = (0, 4)
输入 3: 目的地坐标 (rowDest, colDest) = (4, 4)

输出: true

解析: 一个可能的路径是 : 左 -> 下 -> 左 -> 下 -> 右 -> 下 -> 右。
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-21-054016.png)



**示例 2:**

```
输入 1: 迷宫由以下二维数组表示

0 0 1 0 0
0 0 0 0 0
0 0 0 1 0
1 1 0 1 1
0 0 0 0 0

输入 2: 起始位置坐标 (rowStart, colStart) = (0, 4)
输入 3: 目的地坐标 (rowDest, colDest) = (3, 2)

输出: false

解析: 没有能够使球停在目的地的路径。


```

 ![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-21-054028.png)

**注意:**

-   迷宫中只有一个球和一个目的地。
-   球和目的地都在空地上，且初始时它们不在同一位置。
-   给定的迷宫不包括边界 (如图中的红色矩形), 但你可以假设迷宫的边缘都是墙壁。
-   迷宫至少包括`2`块空地，行数和列数均不超过`100`。



## 2、解题思路

-   每次检查上下左右能否前进并且停住，并判断是否是已经走过的路径，如果不是，加入队列搜索



```python
from functools import lru_cache
from collections import deque


class Solution:
    def hasPath(self, maze: List[List[int]], start: List[int], destination: List[int]) -> bool:
        row, col = len(maze), len(maze[0])

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        @lru_cache(None)
        def get_next(pos, direction):
            next_pos = [-1, -1]
            if direction == 1:
                if not available(pos[0], pos[1] + 1) or maze[pos[0]][pos[1] + 1] == 1:
                    return next_pos
                next_pos = [pos[0], pos[1] + 1]
                while next_pos[1] + 1 < col and maze[next_pos[0]][next_pos[1] + 1] == 0:
                    next_pos[1] += 1
            elif direction == 2:
                if not available(pos[0] + 1, pos[1]) or maze[pos[0] + 1][pos[1]] == 1:
                    return next_pos
                next_pos = [pos[0] + 1, pos[1]]
                while next_pos[0] + 1 < row and maze[next_pos[0] + 1][next_pos[1]] == 0:
                    next_pos[0] += 1
            elif direction == 3:
                if not available(pos[0], pos[1] - 1) or maze[pos[0]][pos[1] - 1] == 1:
                    return next_pos
                next_pos = [pos[0], pos[1] - 1]
                while next_pos[1] - 1 >= 0 and maze[next_pos[0]][next_pos[1] - 1] == 0:
                    next_pos[1] -= 1

            elif direction == 4:
                if not available(pos[0] - 1, pos[1]) or maze[pos[0] - 1][pos[1]] == 1:
                    return next_pos
                next_pos = [pos[0] - 1, pos[1]]
                while next_pos[0] - 1 >= 0 and maze[next_pos[0] - 1][next_pos[1]] == 0:
                    next_pos[0] -= 1
            return next_pos

        mem = set(tuple(start))

        d = deque()
        d.append(tuple(start))
        while d:
            cur = d.popleft()
            if cur == tuple(destination):
                return True

            for i in range(1, 5):
                temp = get_next(cur, i)
                if temp[0] != -1 and tuple(temp) not in mem:
                    d.append(tuple(temp))
                    mem.add(tuple(temp))

        return False
```

