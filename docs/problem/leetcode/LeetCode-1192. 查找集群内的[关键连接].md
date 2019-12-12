# LeetCode: 1192. 查找集群内的「关键连接」

[TOC]

## 1、题目描述

力扣数据中心有 `n` 台服务器，分别按从 `0` 到 `n-1` 的方式进行了编号。

它们之间以「服务器到服务器」点对点的形式相互连接组成了一个内部集群，其中连接 `connections` 是无向的。

从形式上讲，`connections[i] = [a, b]` 表示服务器 `a` 和 `b` 之间形成连接。任何服务器都可以直接或者间接地通过网络到达任何其他服务器。

「关键连接」是在该集群中的重要连接，也就是说，假如我们将它移除，便会导致某些服务器无法访问其他服务器。

请你以任意顺序返回该集群内的所有 「关键连接」。

 

**示例 1：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-12-070743.png" alt="img" style="zoom:50%;" />

```
输入：n = 4, connections = [[0,1],[1,2],[2,0],[1,3]]
输出：[[1,3]]
解释：[[3,1]] 也是正确的。
```

**提示：**

-   $1 <= n <= 10^5$
-   $n-1 <= connections.length <= 10^5$
-   $connections[i][0] != connections[i][1]$
-   不存在重复的连接



## 2、解题思路

-   使用`tarjan`算法

将所有的强连通分量进行标记，标记为时间戳最小的

```python
from collections import defaultdict


class Tarjan:
    def __init__(self, n, graph=None, edges=None):
        """
        :param n: 表示有几个节点，节点标号从0开始
        :param graph: 表示节点之间的连接，以字典的方式
        :param edges: 表示节点之间的连接，每个path由 start, tail组成
        """
        # 强连通分量之间的关键连接
        self.critical_path = []
        self.strong_connected_component = 1 if n > 0 else 0
        self.timestamp = 0
        self.graph = graph if graph else defaultdict(set)
        self.dfn = [0] * n
        self.low = [float('inf')] * n
        self.visited = [0] * n

        if not self.graph and edges:
            for x, y in edges:
                self.graph[x].add(y)
                self.graph[y].add(x)

    def tarjan_search(self, node, parent):
        """
        递归搜索版
        以node为起点开始tarjan搜索，找出所有的强连通分量
        :return:
        """
        self.timestamp += 1
        self.dfn[node] = self.timestamp
        self.low[node] = self.timestamp
        self.visited[node] = 1

        for next_node in self.graph[node]:
            if next_node == parent:
                continue
            if self.visited[next_node]:
                self.low[node] = min(self.low[node], self.low[next_node])
            else:
                self.tarjan_search(next_node, node)
                self.low[node] = min(self.low[node], self.low[next_node])
                if self.dfn[node] < self.low[next_node]:
                    self.critical_path.append([node, next_node])
                    self.strong_connected_component += 1


class Solution:
    def criticalConnections(self, n: int, connections: List[List[int]]) -> List[List[int]]:
        t = Tarjan(n, edges=connections)
        t.tarjan_search(0, -1)
        return t.critical_path

```

