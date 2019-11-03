# LeetCode: 1245. 树的直径

[TOC]

## 1、题目描述

给你这棵「无向树」，请你测算并返回它的「直径」：这棵树上最长简单路径的 边数。

我们用一个由所有「边」组成的数组 edges 来表示一棵无向树，其中 `edges[i] = [u, v]` 表示节点 `u` 和 `v` 之间的双向边。

树上的节点都已经用 `{0, 1, ..., edges.length}` 中的数做了标记，每个节点上的标记都是独一无二的。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-03-074022.png)

```
输入：edges = [[0,1],[0,2]]
输出：2
解释：
这棵树上最长的路径是 1 - 0 - 2，边数为 2。
```

**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-03-074031.png)

```
输入：edges = [[0,1],[1,2],[2,3],[1,4],[4,5]]
输出：4
解释： 
这棵树上最长的路径是 3 - 2 - 1 - 4 - 5，边数为 4。
```

**提示：**

-   $0 <= edges.length < 10^4$
-   $edges[i][0] != edges[i][1]$
-   $0 <= edges[i][j] <= edges.length$
-   `edges 会形成一棵无向树`



## 2、解题思路

-   首先从任意一个点出发，广度优先，找到一个最长的点A

-   然后从点A出发，广度优先，找出最长距离

    

```python
from collections import defaultdict


class Solution:
    def treeDiameter(self, edges: List[List[int]]) -> int:
        if not edges:
            return 0

        mapping = defaultdict(set)
        for x, y in edges:
            mapping[x].add(y)
            mapping[y].add(x)
        visited = {key: False for key in mapping.keys()}

        start = 0
        d = [edges[0][0]]
        visited[edges[0][0]] = True

        while d:
            start = d[0]
            next_d = []
            for i in d:
                for n in mapping[i]:
                    if not visited[n]:
                        visited[n] = True
                        next_d.append(n)
            d = next_d

        step = 0
        visited = {key: False for key in mapping.keys()}
        visited[start] = True
        d = [start]
        while d:
            next_d = []
            for i in d:
                for n in mapping[i]:
                    if not visited[n]:
                        visited[n] = True
                        next_d.append(n)
            d = next_d
            step += 1
        return step - 1
```

