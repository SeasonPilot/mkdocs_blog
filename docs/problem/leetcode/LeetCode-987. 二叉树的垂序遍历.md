# LeetCode: 987. 二叉树的垂序遍历

[TOC]

## 1、题目描述

给定二叉树，按垂序遍历返回其结点值。

对位于 `(X, Y)` 的每个结点而言，其左右子结点分别位于 `(X-1, Y-1)` 和 `(X+1, Y-1)`。

把一条垂线从 `X = -infinity` 移动到 `X = +infinity` ，每当该垂线与结点接触时，我们按从上到下的顺序报告结点的值（ `Y` 坐标递减）。

如果两个结点位置相同，则首先报告的结点值较小。

按 `X` 坐标顺序返回非空报告的列表。每个报告都有一个结点值列表。

 

**示例 1：**

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-06-073227.png)

```
输入：[3,9,20,null,null,15,7]
输出：[[9],[3,15],[20],[7]]
解释： 
在不丧失其普遍性的情况下，我们可以假设根结点位于 (0, 0)：
然后，值为 9 的结点出现在 (-1, -1)；
值为 3 和 15 的两个结点分别出现在 (0, 0) 和 (0, -2)；
值为 20 的结点出现在 (1, -1)；
值为 7 的结点出现在 (2, -2)。
```

**示例 2：**

![img](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-06-073235.png)

```
输入：[1,2,3,4,5,6,7]
输出：[[4],[2],[1,5,6],[3],[7]]
解释：
根据给定的方案，值为 5 和 6 的两个结点出现在同一位置。
然而，在报告 "[1,5,6]" 中，结点值 5 排在前面，因为 5 小于 6。
```

**提示：**

- `树的结点数介于 1 和 1000 之间。`
- `每个结点值介于 0 和 1000 之间。`

## 2、解题思路

- 将节点进行坐标编号并放入字典中
- 按照列大小一次从字典中取列表，列表中的顺序按照行排序，同一行按照大小排序



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def verticalTraversal(self, root: TreeNode) -> List[List[int]]:
        from collections import defaultdict
        mapping = defaultdict(list)

        def dfs(node: TreeNode, x, y):
            nonlocal mapping
            if not node:
                return
            mapping[y].append((node.val, x))

            dfs(node.left, x + 1, y - 1)
            dfs(node.right, x + 1, y + 1)

        dfs(root, 0, 0)
        res = []
        for p in sorted(mapping.keys()):
            res.append([v[0] for v in sorted(mapping[p], key=lambda x: (x[1], x[0]))])

        return res
```

