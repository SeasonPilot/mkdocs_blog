# LeetCode: 834. 树中距离之和

[TOC]

## 1、题目描述

给定一个无向、连通的树。树中有 `N` 个标记为 `0...N-1` 的节点以及 `N-1` 条边 。

第 `i` 条边连接节点 `edges[i][0]` 和 `edges[i][1]` 。

返回一个表示节点 i 与其他所有节点距离之和的列表 `ans`。

**示例 1:**

```
输入: N = 6, edges = [[0,1],[0,2],[2,3],[2,4],[2,5]]
输出: [8,12,6,10,10,10]
解释: 
如下为给定的树的示意图：
  0
 / \
1   2
   /|\
  3 4 5

我们可以计算出 dist(0,1) + dist(0,2) + dist(0,3) + dist(0,4) + dist(0,5) 
也就是 1 + 1 + 2 + 2 + 2 = 8。 因此，answer[0] = 8，以此类推。
```


**说明: 1 <= N <= 10000**



## 2、解题思路

- 使用深度优先搜索

如果直接求出所有节点到其他节点的距离，时间复杂度太高，会超时。

因为这里是一棵树，所以不会有回环存在

- 假设有x和y相连，如果将x和y断开，就变成了两棵树

> 说明：
>
> ​    {x} : 表示x点为根节点的树，x点到其他节点距离之和
>
> ​    $x:  表示x点为根节点的树，节点数量

- 如果想要求x点到所有节点的距离之和，就变成：

```
ans[x] = {x} + {y} + $y

这里为什么加上$y呢？
因为x和y之间有一条边，那么y中所有节点都需要加上一条边的距离

同理
ans[y] = {x} + {y} + $x

因此，可以得到：
ans[x] - ans[y] = $y -$x
所以，如果已经求出了ans[x],以及得到相应的节点数量，就能直接得到ans[y]

ans[y] = ans[x] + $x - $y
```

- 因此，设0为根节点，求出所有的子树的ans值与count值
- 由于我们只得到了0节点的正确值，其他节点从根节点开始更新，因为总节点数量已知，所以就能够根据父节点求当前节点的距离和



```python
class Solution:
    def sumOfDistancesInTree(self, N: int, edges: List[List[int]]) -> List[int]:
        
        from collections import defaultdict

        path = defaultdict(set)

        for x, y in edges:
            path[x].add(y)
            path[y].add(x)

        ans = [0] * N
        count = [1] * N

        def dfs1(node, parent=None):
          # 从叶子节点向上更新当前节点为根节点的子树的距离之和
            for nex in path[node]:
                if nex != parent:
                    dfs1(nex, node)
                    count[node] += count[nex]
                    ans[node] += ans[nex] + count[nex]

        def dfs2(node, parent=None):
          # 从根节点开始更新距离之和
            for nex in path[node]:
                if nex != parent:
                    ans[nex] = ans[node] + N - count[nex] - count[nex]
                    dfs2(nex, node)

        dfs1(0, 0)
        dfs2(0, 0)
        return ans

```

