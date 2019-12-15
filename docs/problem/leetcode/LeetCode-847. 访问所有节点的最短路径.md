# LeetCode: 847. 访问所有节点的最短路径

[TOC]

## 1、题目描述

给出 `graph` 为有 `N` 个节点（编号为 `0, 1, 2, ..., N-1`）的无向连通图。 

`graph.length = N`，且只有节点 `i` 和 `j` 连通时，`j != i` 在列表 `graph[i]` 中恰好出现一次。

返回能够访问所有节点的最短路径的长度。你可以在任一节点开始和停止，也可以多次重访节点，并且可以重用边。

 

**示例 1：**

```
输入：[[1,2,3],[0],[0],[0]]
输出：4
解释：一个可能的路径为 [1,0,2,0,3]
```


**示例 2：**

```
输入：[[1],[0,2,4],[1,3,4],[2],[1,2]]
输出：4
解释：一个可能的路径为 [0,1,4,2,3]
```

**提示：**

-   $1 <= graph.length <= 12$
-   $0 <= graph[i].length < graph.length$



## 2、解题思路

-   状态迁移

由于题目中最大只有12个节点，因此使用位表示每个节点的访问情况

初始状态为从任意一个节点开始，不断的采用当前节点来你接的边，更新到下一个状态

我们使用字典保存状态的值，如果更新从当前状态更新到下一个状态令距离变小了，表示走这条路经是可行的

不断的将下一个状态加入到队列中，由于每一次都会更新，距离会增加，因此第一个出现的终止状态就是我们想要的最短的路径



```python
from collections import deque
from collections import defaultdict


class Solution:
    def shortestPathLength(self, graph: List[List[int]]) -> int:
        length = len(graph)
        dist = defaultdict(lambda: length * length)

        d = deque()
        for i in range(length):
            cur = (1 << i, i)
            dist[cur] = 0
            d.append(cur)

        finish_state = (1 << length) - 1

        while d:
            state, node = d.popleft()
            current_dist = dist[(state, node)]
            if state == finish_state:
                return current_dist

            for next_node in graph[node]:
                next_status = state | (1 << next_node)
                if current_dist + 1 < dist[(next_status, next_node)]:
                    dist[(next_status, next_node)] = current_dist + 1
                    d.append((next_status, next_node))

        return -1
```

