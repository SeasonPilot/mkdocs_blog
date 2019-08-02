# LeetCode: 743. 网络延迟时间

[TOC]

## 1、题目描述

有 N 个网络节点，标记为 1 到 N。

给定一个列表 times，表示信号经过有向边的传递时间。 times[i] = (u, v, w)，其中 u 是源节点，v 是目标节点， w 是一个信号从源节点传递到目标节点的时间。

现在，我们向当前的节点 K 发送了一个信号。需要多久才能使所有节点都收到信号？如果不能使所有节点收到信号，返回 -1。

**注意:**

- N 的范围在 [1, 100] 之间。

- K 的范围在 [1, N] 之间。

- times 的长度在 [1, 6000] 之间。

- 所有的边 times[i] = (u, v, w) 都有 1 <= u, v <= N 且 0 <= w <= 100。

## 2、解题思路

- 使用DisjKstra算法，求解各个节点的最小时间
- 然后从最小时间中找出最大时间



```python
from collections import defaultdict


class Solution:
    def networkDelayTime(self, times: [[int]], N: int, K: int) -> int:
        directions = defaultdict(set)

        visited = [False] * N
        visited_time = [float('inf')] * N

        for cur, nex, time in times:
            directions[cur].add((nex, time))

        visited[K - 1] = True
        visited_time[K - 1] = 0
        for nex, time in directions[K]:
            visited_time[nex - 1] = time

        for i in range(1, N):

            min_value = float('inf')
            nex = -1
            for index, time in enumerate(visited_time):
                if not visited[index]:
                    if time < min_value:
                        min_value = time
                        nex = index
            if nex == -1:
                break
            visited[nex] = True
            for next_node, time in directions[nex + 1]:
                visited_time[next_node - 1] = min(min_value + time, visited_time[next_node - 1])

        if not all(visited):
            return -1
        return max(visited_time)
```

