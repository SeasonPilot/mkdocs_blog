# LeetCode: 1273. 删除树节点

[TOC]

## 1、题目描述

给你一棵以节点 `0` 为根节点的树，定义如下：

-   节点的总数为 `nodes` 个；
-   第 `i` 个节点的值为 `value[i]` ；
-   第 `i` 个节点的父节点是 `parent[i]` 。

请你删除节点值之和为 `0` 的每一棵子树。

在完成所有删除之后，返回树中剩余节点的数目。

 

**示例：**

```
输入：nodes = 7, parent = [-1,0,0,1,2,2,2], value = [1,-2,4,0,-2,-1,-1]
输出：2
```

**提示：**

-   $1 <= nodes <= 10^4$
-   $-10^5 <= value[i] <= 10^5$
-   $parent.length == nodes$
-   `parent[0] == -1` 表示节点 `0` 是树的根。



## 2、解题思路

-   后子节点更新父节点的值，并且同时更新父节点之下有多少子节点



```python
class Solution:
    def deleteTreeNodes(self, nodes: int, parent: List[int], value: List[int]) -> int:
        dp = [1] * nodes

        ans = 0
        for i in range(nodes - 1, -1, -1):
            if value[i] == 0:
                ans += dp[i]

            else:
                if parent[i] != -1:
                    value[parent[i]] += value[i]
                    dp[parent[i]] += dp[i]
        return nodes - ans
```

