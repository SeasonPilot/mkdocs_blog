# LeetCode: 1197. 进击的骑士

[TOC]

## 1、题目描述

一个坐标可以从 `-infinity` 延伸到 `+infinity` 的 **无限大的** 棋盘上，你的 **骑士** 驻扎在坐标为 `[0, 0]` 的方格里。

骑士的走法和中国象棋中的马相似，走 “日” 字：即先向左（或右）走 `1` 格，再向上（或下）走 `2` 格；或先向左（或右）走 `2` 格，再向上（或下）走 `1` 格。

每次移动，他都可以按图示八个方向之一前进。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-21-071237.png)

现在，骑士需要前去征服坐标为 `[x, y]` 的部落，请你为他规划路线。

最后返回所需的最小移动次数即可。本题确保答案是一定存在的。

 

**示例 1：**

```
输入：x = 2, y = 1
输出：1
解释：[0, 0] → [2, 1]
```


**示例 2：**

```
输入：x = 5, y = 5
输出：4
解释：[0, 0] → [2, 1] → [4, 2] → [3, 4] → [5, 5]
```

**提示：**

-    `|x| + |y| <= 300`



## 2、解题思路


-   使用队列，不断地找出距离更小的点
-   需要注意的就是，如果距离很近，也就是周边节点需要处理

```python
from collections import deque, defaultdict


class Solution:
    def minKnightMoves(self, x: int, y: int) -> int:
        mem = defaultdict(lambda: float('inf'))
        surround = [(-2, -1), (-2, 1), (-1, 2), (1, 2), (2, 1), (2, -1), (1, -2), (-1, -2)]

        mem[(0, 0)] = 0
        d = deque()
        d.append((0, 0))

        while d:
            i, j = d.popleft()
            current_length = abs(y - j) + abs(x - i)
            if i == x and j == y:
                break
            for di, dj in surround:
                ni, nj = i + di, j + dj
                length = abs(y - nj) + abs(x - ni)
                if mem[(i, j)] + 1 < mem[(ni, nj)]:
                    if length <= current_length or current_length <= 3:
                        d.append((ni, nj))
                        mem[(ni, nj)] = mem[(i, j)] + 1
        return mem[(x, y)]

```
上面的时间复杂度较高，主要体现在两个点距离较远的情况下，有很多无效路径的搜索，因此，下面首先对这些路径进行压缩，找到距离较近的点，然后开始广度优先搜索


-   **改进版**

-   另一种方法，首先尽可能的靠近目标点，然后使用广度优先搜索


```python
from collections import deque, defaultdict

class Solution:
    def minKnightMoves(self, x: int, y: int) -> int:

        steps = 0
        start = [0, 0]
        x_length = abs(x - start[0])
        y_length = abs(y - start[1])
        while x_length + y_length > 7:
            if x_length >= y_length:
                if x > start[0]:
                    start[0] += 2
                else:
                    start[0] -= 2

                if y > start[1]:
                    start[1] += 1
                else:
                    start[1] -= 1
            else:
                if x > start[0]:
                    start[0] += 1
                else:
                    start[0] -= 1

                if y > start[1]:
                    start[1] += 2
                else:
                    start[1] -= 2
            x_length = abs(x - start[0])
            y_length = abs(y - start[1])
            steps += 1

        mem = defaultdict(lambda: float('inf'))
        surround = [(-2, -1), (-2, 1), (-1, 2), (1, 2), (2, 1), (2, -1), (1, -2), (-1, -2)]

        mem[tuple(start)] = steps
        d = deque()
        d.append(tuple(start))

        while d:
            i, j = d.popleft()
            current_length = abs(y - j) + abs(x - i)
            if i == x and j == y:
                break
            for di, dj in surround:
                ni, nj = i + di, j + dj
                length = abs(y - nj) + abs(x - ni)
                if mem[(i, j)] + 1 < mem[(ni, nj)]:
                    if length <= current_length or current_length <= 3:
                        d.append((ni, nj))
                        mem[(ni, nj)] = mem[(i, j)] + 1

        return mem[(x, y)]
```


