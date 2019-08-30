# LeetCode: 928. 尽量减少恶意软件的传播 II

[TOC]

## 1、题目描述

(这个问题与 尽量减少恶意软件的传播 是一样的，不同之处用粗体表示。)

在节点网络中，只有当 `graph[i][j] = 1` 时，每个节点 `i` 能够直接连接到另一个节点 `j`。

一些节点 `initial` 最初被恶意软件感染。只要两个节点直接连接，且其中至少一个节点受到恶意软件的感染，那么两个节点都将被恶意软件感染。这种恶意软件的传播将继续，直到没有更多的节点可以被这种方式感染。

假设 `M(initial)` 是在恶意软件停止传播之后，整个网络中感染恶意软件的最终节点数。

我们可以从初始列表中删除一个节点，**并完全移除该节点以及从该节点到任何其他节点的任何连接**。如果移除这一节点将最小化 `M(initial)`， 则返回该节点。如果有多个节点满足条件，就返回索引最小的节点。

 

**示例 1：**

```
输出：graph = [[1,1,0],[1,1,0],[0,0,1]], initial = [0,1]
输入：0
```

**示例 2：**

```
输入：graph = [[1,1,0],[1,1,1],[0,1,1]], initial = [0,1]
输出：1
```

**示例 3：**

```
输入：graph = [[1,1,0,0],[1,1,1,0],[0,1,1,1],[0,0,1,1]], initial = [0,1]
输出：1
```

**提示：**

- `1 < graph.length = graph[0].length <= 300`
- `0 <= graph[i][j] == graph[j][i] <= 1`
- `graph[i][i] = 1`
- `1 <= initial.length < graph.length`
- `0 <= initial[i] < graph.length`




## 2、解题思路

- 并查集

这道题和924的不同点在于，924题的几点移除，如果网络中还有其他病毒节点，依旧会感染

但是本题中，移除以后，相应的连接同时移除

- 首先将所有的不包含病毒节点的其他连接计算出来
- 然后一次判断每个病毒节点连接的集合，找出唯一与当前病毒节点相连接的集合，并将集合中的元素数量计算出来，元素数量就是移除该节点的收益值
- 需要判断某些集合是不是同时与其他集合相连接，这时候需要统计集合出现的次数，超过一次的表示同时与多个病毒节点相连接，该集合不做计算



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))
        self.size = [1] * length

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.size[xp] += self.size[yp]
            self.data[yp] = xp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def minMalwareSpread(self, graph: [[int]], initial: [int]) -> int:
        from collections import defaultdict, Counter
        length = len(graph)
        safe = [x for x in range(length) if x not in initial]

        d = DFU(length)

        for i in safe:
            for j in safe:
                if graph[i][j]:
                    d.union(i, j)

        virus_collection = defaultdict(set)
        count = Counter()
        for node in initial:
            temp_collection = set()
            for j in safe:
                if graph[node][j]:
                    temp_collection.add(d.find(j))

            for i in temp_collection:
                count[i] += 1
            virus_collection[node] = temp_collection

        ans = (-1, min(initial))

        for node in initial:
            score = 0
            for collection in virus_collection[node]:
                if count[collection] == 1:
                    score += d.size[collection]

            if score > ans[0] or score == ans[0] and node < ans[1]:
                ans = score, node
        return ans[1]

```

