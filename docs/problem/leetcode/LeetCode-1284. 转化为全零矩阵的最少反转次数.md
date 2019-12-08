# LeetCode: 1284. 转化为全零矩阵的最少反转次数

[TOC]

## 1、题目描述

给你一个 `m x n` 的二进制矩阵 `mat`。

每一步，你可以选择一个单元格并将它反转（反转表示 `0` 变 `1` ，`1` 变 `0` ）。如果存在和它相邻的单元格，那么这些相邻的单元格也会被反转。（注：相邻的两个单元格共享同一条边。）

请你返回将矩阵 `mat` 转化为全零矩阵的最少反转次数，如果无法转化为全零矩阵，请返回 `-1` 。

二进制矩阵的每一个格子要么是 `0` 要么是 `1` 。

全零矩阵是所有格子都为 `0` 的矩阵。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-08-062825.png)

```
输入：mat = [[0,0],[0,1]]
输出：3
解释：一个可能的解是反转 (1, 0)，然后 (0, 1) ，最后是 (1, 1) 。
```


**示例 2：**

```
输入：mat = [[0]]
输出：0
解释：给出的矩阵是全零矩阵，所以你不需要改变它。
```


**示例 3：**

```
输入：mat = [[1,1,1],[1,0,1],[0,0,0]]
输出：6
```


**示例 4：**

```
输入：mat = [[1,0,0],[1,0,0]]
输出：-1
解释：该矩阵无法转变成全零矩阵
```

**提示：**

-   `m == mat.length`
-   `n == mat[0].length`
-   `1 <= m <= 3`
-   `1 <= n <= 3`
-   `mat[i][j] 是 0 或 1 。`



## 2、解题思路

-   使用`Dijkstra`搜索
-   将数组编程一维的字符串用来表示 当前的数组
-   首先从初始状态开始，不断的找下一个状态，作为当前状态的下一个节点
-   然后使用`Dijkstra`算法搜索，找出到全`0`的最短路径

```python
from typing import List
from collections import defaultdict
from collections import namedtuple
from functools import reduce
import heapq
from copy import deepcopy

EdgeNode = namedtuple("EdgeNode", ["weight", "node"])
PreEdgeNode = namedtuple("PreEdgeNode", ["weight", "node", "pre_node"])


class Dijkstra:
    def __init__(self, edges, source):
        inf = float('inf')
        self.graph = edges
        self.dis = {source: 0}
        self.q = []

        for weight, t in edges[source]:
            heapq.heappush(self.q, PreEdgeNode(weight, t, source))

        self._find_shortest()

    def _find_shortest(self):
        """
        使用dijkstra算法计算最短距离，并更新最短路径的前驱节点
        :return:
        """
        while self.q:
            weight, node, pre_node = heapq.heappop(self.q)
            if node in self.dis:
                continue
            self.dis[node] = weight
            for next_node_weight, next_node in self.graph[node]:
                if next_node not in self.dis:
                    heapq.heappush(self.q, PreEdgeNode(weight + next_node_weight, next_node, node))

    def get_shortest_dis(self, target: int) -> int:
        """
        返回距离source点的最短距离
        :param target: 目标点
        :return: 如果目标点不在图中，返回-1
        """
        if target in self.dis:
            return self.dis[target]
        return -1


class Solution:
    def minFlips(self, mat: List[List[int]]) -> int:

        row, col = len(mat), len(mat[0])

        target = "0" * (row * col)
        func = lambda x: [y for l in x for y in func(l)] if type(x) is list else [x]
        source = str(reduce(lambda x, y: str(x) + str(y), func(mat)))

        edges = defaultdict(set)
        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        def get_next_stat(current):
            current_stat = str(reduce(lambda x, y: str(x) + str(y), func(current)))
            if edges[current_stat]:
                return
            for i in range(row):
                for j in range(col):
                    temp = deepcopy(current)
                    temp[i][j] = 0 if temp[i][j] == 1 else 1
                    for dx, dy in surround:
                        nx, ny = i + dx, j + dy
                        if available(nx, ny):
                            temp[nx][ny] = 0 if temp[nx][ny] == 1 else 1
                    temp_stat = str(reduce(lambda x, y: str(x) + str(y), func(temp)))
                    edges[current_stat].add(EdgeNode(1, temp_stat))
                    get_next_stat(temp)

        get_next_stat(mat)

        if target not in edges:
            return -1

        dijkstra = Dijkstra(edges, source)

        return dijkstra.get_shortest_dis(target)
```

