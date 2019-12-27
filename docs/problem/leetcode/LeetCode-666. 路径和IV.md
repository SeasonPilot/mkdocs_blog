# LeetCode: 666. 路径和IV

[TOC]

## 1、题目描述

对于一棵深度小于 `5` 的树，可以用一组三位十进制整数来表示。

对于每个整数：

1.  百位上的数字表示这个节点的深度 `D`，`1 <= D <= 4`。
2.  十位上的数字表示这个节点在当前层所在的位置 `P`， `1 <= P <= 8`。位置编号与一棵满二叉树的位置编号相同。
3.  个位上的数字表示这个节点的权值 `V`，`0 <= V <= 9`。

给定一个包含三位整数的升序数组，表示一棵深度小于 `5` 的二叉树，请你返回从根到所有叶子结点的路径之和。

**样例 1:**

```
输入: [113, 215, 221]
输出: 12
解释: 
这棵树形状如下:
    3
   / \
  5   1

路径和 = (3 + 5) + (3 + 1) = 12.
```

**样例 2:**

```
输入: [113, 221]
输出: 4
解释: 
这棵树形状如下: 
    3
     \
      1

路径和 = (3 + 1) = 4.


```



## 2、解题思路

-   首先变换成树
-   然后递归，直到叶子节点，将路径和加到结果中



```python
from collections import defaultdict


class Solution:
    def pathSum(self, nums: List[int]) -> int:
        graph = defaultdict(int)
        ans = 0
        for num in nums:
            level, order, val = map(int, str(num))
            graph[(level, order)] = val

        def dfs(current):
            nonlocal ans
            cur_level, cur_order = current
            left = (cur_level + 1, cur_order * 2 - 1)
            right = (cur_level + 1, cur_order * 2)
            if left not in graph and right not in graph:
                ans += graph[current]
                return
            if left in graph:
                graph[left] += graph[current]
                dfs(left)
            if right in graph:
                graph[right] += graph[current]
                dfs(right)

        dfs((1, 1))
        return ans
```

