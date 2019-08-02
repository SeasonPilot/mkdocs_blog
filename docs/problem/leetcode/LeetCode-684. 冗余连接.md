# LeetCode: 684. 冗余连接

[TOC]

## 1、题目描述

在本问题中, 树指的是一个连通且无环的无向图。

输入一个图，该图由一个有着N个节点 (节点值不重复1, 2, ..., N) 的树及一条附加的边构成。附加的边的两个顶点包含在1到N中间，这条附加的边不属于树中已存在的边。

结果图是一个以边组成的二维数组。每一个边的元素是一对[u, v] ，满足 u < v，表示连接顶点u 和v的无向图的边。

返回一条可以删去的边，使得结果图是一个有着N个节点的树。如果有多个答案，则返回二维数组中最后出现的边。答案边 [u, v] 应满足相同的格式 u < v。

```
示例 1：

输入: [[1,2], [1,3], [2,3]]
输出: [2,3]
解释: 给定的无向图为:
  1
 / \
2 - 3


示例 2：

输入: [[1,2], [2,3], [3,4], [1,4], [1,5]]
输出: [1,4]
解释: 给定的无向图为:
5 - 1 - 2
    |   |
    4 - 3
```



**注意:**

- 输入的二维数组大小在 3 到 1000。
- 二维数组中的整数在1到N之间，其中N是输入数组的大小。



**更新(2017-09-26):**
  我们已经重新检查了问题描述及测试用例，明确图是无向 图。对于有向图详见冗余连接II。对于造成任何不便，我们深感歉意。

## 2、解题思路

- 首先找到度为0，1的节点，将这些节点从结果集中移除
- 并将与度为1的节点相连接的节点的度减一
- 不断的更新，直到结果集中没有度为0，1的节点，此时剩余节点直接形成环路

```python
from collections import defaultdict, deque

class Solution:
    def findRedundantConnection(self, edges: [[int]]) -> [int]:
        directions = defaultdict(set)
        degree = defaultdict(int)

        for x, y in edges:
            directions[x].add(y)
            directions[y].add(x)
            degree[x] += 1
            degree[y] += 1

        flag = 1 in set(degree.values())

        if not flag and not degree:
            return []

        while flag:
            flag = False
            no_degree = []
            for key, value in degree.items():
                if value == 1:
                    no_degree.append(key)
                    for d in directions[key]:
                        directions[d].remove(key)
                        degree[d] -= 1
                        if degree[d] == 1:
                            flag = True
            for i in no_degree:
                degree.pop(i)
            no_degree = []

        temp = set()

        for node in degree:
            for nex in directions[node]:
                temp.add(tuple(sorted([node, nex])))

        for i in range(len(edges) - 1, -1, -1):
            t = tuple(sorted(edges[i]))
            if t in temp:
                return sorted(edges[i])

        return []
```

