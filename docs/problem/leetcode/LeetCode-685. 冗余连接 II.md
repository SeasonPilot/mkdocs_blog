# LeetCode: 685. 冗余连接 II

[TOC]

## 1、题目描述

在本问题中，有根树指满足以下条件的有向图。该树只有一个根节点，所有其他节点都是该根节点的后继。每一个节点只有一个父节点，除了根节点没有父节点。

输入一个有向图，该图由一个有着`N`个节点 (节点值不重复`1, 2, ..., N`) 的树及一条附加的边构成。附加的边的两个顶点包含在`1`到`N`中间，这条附加的边不属于树中已存在的边。

结果图是一个以边组成的二维数组。 每一个边 的元素是一对 `[u, v]`，用以表示有向图中连接顶点 `u and v`和顶点的边，其中父节点`u`是子节点`v`的一个父节点。

返回一条能删除的边，使得剩下的图是有`N`个节点的有根树。若有多个答案，返回最后出现在给定二维数组的答案。



**示例 1:**

```
输入: [[1,2], [1,3], [2,3]]
输出: [2,3]
解释: 给定的有向图如下:
  1
 / \
v   v
2-->3
```



**示例 2:**

```
输入: [[1,2], [2,3], [3,4], [4,1], [1,5]]
输出: [4,1]
解释: 给定的有向图如下:
5 <- 1 -> 2
     ^    |
     |    v
     4 <- 3
```


**注意:**

- 二维数组大小的在3到1000范围内。
- 二维数组中的每个整数在1到N之间，其中 N 是二维数组的大小。



## 2、解题思路

- 分两种情况讨论
  - 没有入度为2的节点
  - 有入度为2的节点

- 如果没有入度为2的节点，直接判断有没有环，如果存在，则更新结果值
- 如果存在入度为2的节点，首先将除了这两条边的其他节点合并，然后判断这两条边的情况
  - 如果有一条边存在环，更新结果值
  - 如果都不存在环，去掉后面出现的那条边



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def findRedundantDirectedConnection(self, edges: [[int]]) -> [int]:
        # 入度判断
        from collections import defaultdict
        degree = defaultdict(list)
        find = -1
        for f, t in edges:
            degree[t].append(f)
            if len(degree[t]) > 1:
                find = t

        ans = [-1, -1]
        d = DFU(len(edges) + 1)
        if find == -1:
            for x, y in edges:
                if d.find(x) == d.find(y):
                    ans = [x, y]
                d.union(x, y)
        else:
            for x, y in edges:
                if x in degree[find] and y == find:
                    continue
                d.union(x, y)
            if d.find(degree[find][0]) == d.find(find):
                ans = [degree[find][0], find]
            elif d.find(degree[find][1]) == d.find(find):
                ans = [degree[find][1], find]
            else:
                ans = [degree[find][1], find]
        return ans

```

