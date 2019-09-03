# LeetCode: 1123. 最深叶节点的最近公共祖先

[TOC]

## 1、题目描述

给你一个有根节点的二叉树，找到它最深的叶节点的最近公共祖先。

回想一下：

叶节点 是二叉树中没有子节点的节点
树的根节点的 深度 为 `0`，如果某一节点的深度为 `d`，那它的子节点的深度就是 `d+1`
如果我们假定 A 是一组节点 `S` 的 最近公共祖先，`S` 中的每个节点都在以 `A` 为根节点的子树中，且 `A` 的深度达到此条件下可能的最大值。

**示例 1：**

```
输入：root = [1,2,3]
输出：[1,2,3]
```

**示例 2：**

```
输入：root = [1,2,3,4]
输出：[4]
```

**示例 3：**

```
输入：root = [1,2,3,4,5]
输出：[2,4,5]
```

**提示：**

- 给你的树中将有 `1` 到 `1000` 个节点。
- 树中每个节点的值都在 `1` 到 `1000` 之间。



## 2、解题思路

- 深度优先
- 加上当前节点的深度进行判断
  - 如果左节点的最深的深度等于右节点最深深度，返回当前节点以及最深深度
  - 如果左节点深度大，返回左节点返回值
  - 如果右节点深度大，返回右节点返回值

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def lcaDeepestLeaves(self, root: TreeNode) -> TreeNode:
        if not root:
            return root

        def dfs(node: TreeNode, level):
            if not node:
                return node, level

            left = dfs(node.left, level + 1)
            right = dfs(node.right, level + 1)

            if left[1] == right[1]:
                return node, left[1]
            elif left[1] > right[1]:
                return left
            else:
                return right

        n, _ = dfs(root, 1)
        return n
```

