# LeetCode: 797. 所有可能的路径

[TOC]

## 1、题目描述

给一个有 `n` 个结点的有向无环图，找到所有从 `0` 到 `n-1` 的路径并输出（不要求按顺序）

二维数组的第 `i` 个数组中的单元都表示有向图中 i 号结点所能到达的下一些结点（译者注：有向图是有方向的，即规定了`a→b`你就不能从`b→a`）空就是没有下一个结点了。

**示例:**

```
输入: [[1,2], [3], [3], []] 
输出: [[0,1,3],[0,2,3]] 
解释: 图是这样的:
0--->1
|    |
v    v
2--->3
这有两条路: 0 -> 1 -> 3 和 0 -> 2 -> 3.
```

**提示:**

- 结点的数量会在范围 [2, 15] 内。

- 你可以把路径以任意顺序输出，但在路径内的结点的顺序必须保证。

## 2、解题思路

- DFS+回溯
- 设置临时数组，因为是无环图，将每条路径进行遍历，得到终点的路径加入结果集中

```python
class Solution:
    def allPathsSourceTarget(self, graph: List[List[int]]) -> List[List[int]]:
        n = len(graph) - 1

        res = []

        temp = [0]

        def dfs():
            if temp[-1] == n:
                res.append(temp[:])
                return

            for i in graph[temp[-1]]:
                temp.append(i)
                dfs()
                temp.pop()

        dfs()
        return res
```

