# LeetCode: 593. 有效的正方形

[TOC]

## 1、题目描述

给定二维空间中四点的坐标，返回四点是否可以构造一个正方形。

一个点的坐标`（x，y）`由一个有两个整数的整数数组表示。

**示例:**

```
输入: p1 = [0,0], p2 = [1,1], p3 = [1,0], p4 = [0,1]
输出: True
```


注意:

- 所有输入整数都在 `[-10000，10000]` 范围内。
- 一个有效的正方形有四个等长的正长和四个等角（`90`度角）。
- 输入点没有顺序。

## 2、解题思路

- 所有的点一共可以组成4个边长加上两个对角线
- 只要判断边长和对角线的关系即可



```python
from collections import defaultdict
from itertools import combinations


class Solution:
    def validSquare(self, p1: List[int], p2: List[int], p3: List[int], p4: List[int]) -> bool:
        edges = set()
        mem = defaultdict(int)
        for [x1, y1], [x2, y2] in combinations([p1, p2, p3, p4], 2):
            edge = abs(x1 - x2) ** 2 + abs(y1 - y2) ** 2
            edges.add(edge)
            mem[edge] += 1

        diagonal = max(edges)
        com_edge = min(edges)

        if len(edges) != 2 or (mem[diagonal] != 2 or mem[com_edge] != 4):
            return False

        if com_edge * 2 == diagonal:
            return True

        return False
```

