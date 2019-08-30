# LeetCode: 924. 尽量减少恶意软件的传播

[TOC]

## 1、题目描述

在节点网络中，只有当 `graph[i][j] = 1` 时，每个节点 `i` 能够直接连接到另一个节点 `j`。

一些节点 `initial` 最初被恶意软件感染。只要两个节点直接连接，且其中至少一个节点受到恶意软件的感染，那么两个节点都将被恶意软件感染。这种恶意软件的传播将继续，直到没有更多的节点可以被这种方式感染。

假设 `M(initial)` 是在恶意软件停止传播之后，整个网络中感染恶意软件的最终节点数。

我们可以从初始列表中删除一个节点。如果移除这一节点将最小化 `M(initial)`， 则返回该节点。如果有多个节点满足条件，就返回索引最小的节点。

请注意，如果某个节点已从受感染节点的列表 `initial` 中删除，它以后可能仍然因恶意软件传播而受到感染。

 

**示例 1：**

```
输入：graph = [[1,1,0],[1,1,0],[0,0,1]], initial = [0,1]
输出：0
```

**示例 2：**

```
输入：graph = [[1,0,0],[0,1,0],[0,0,1]], initial = [0,2]
输出：0
```

**示例 3：**

```
输入：graph = [[1,1,1],[1,1,1],[1,1,1]], initial = [1,2]
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

- 首先将所有可能联通的连起来
- 然后判断有病毒的初始化节点中，有哪些出席那在同一个集合中，可以通过判断节点的父节点出现的数量来判断，如果因为多个节点出现在同一个集合中，去掉哪一个节点都不会大幅改变病毒的情况
- 如果某些节点在集合中只出现了一次，如果集合中和元素越多，表示影响结果越大，这时候就更新结果
- 如果集合元素数量相等，就判断谁的索引更小



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
        from collections import defaultdict
        row = len(graph)
        d = DFU(row)
        for i in range(row):
            for j in range(row):
                if graph[i][j] == 1:
                    d.union(i, j)

        count = defaultdict(int)
        for i in initial:
            count[d.find(i)] += 1

        ans = (-1, min(initial))
        for i in initial:

            father = d.find(i)

            if count[father] == 1:
                if d.size[father] > ans[0] or d.size[father] == ans[0] and i < ans[1]:
                    ans = d.size[father], i

        return ans[1]

```

