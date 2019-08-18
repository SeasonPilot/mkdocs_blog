# LeetCode: 513. 找树左下角的值

[TOC]

## 1、题目描述

给定一个二叉树，在树的最后一行找到最左边的值。

**示例 1:**

```
输入:

    2
   / \
  1   3

输出:
1

```

**示例 2:**

```
输入:

        1
       / \
      2   3
     /   / \
    4   5   6
       /
      7
输出:
7
```

**注意:** 您可以假设树（即给定的根节点）不为 NULL。

## 2、解题思路

- 深度优先搜索
- 采用根-右-左的方式进行遍历
- 判断level高，进行节点更新

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def findBottomLeftValue(self, root: TreeNode) -> int:
        
        res = 0
        max_level = 0

        def dfs(node: TreeNode, level):
            nonlocal res, max_level
            if not node:
                return
            if level >= max_level:
                res = node.val
                max_level = level
            dfs(node.right, level + 1)
            dfs(node.left, level + 1)

        dfs(root, 0)
        return res
        
        
```

