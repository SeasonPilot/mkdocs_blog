# LeetCode: 993. 二叉树的堂兄弟节点

[TOC]

## 1、题目描述

在二叉树中，根节点位于深度 0 处，每个深度为 k 的节点的子节点位于深度 k+1 处。

如果二叉树的两个节点深度相同，但父节点不同，则它们是一对堂兄弟节点。

我们给出了具有唯一值的二叉树的根节点 root，以及树中两个不同节点的值 x 和 y。

只有与值 x 和 y 对应的节点是堂兄弟节点时，才返回 true。否则，返回 false。

```
示例 1：
输入：root = [1,2,3,4], x = 4, y = 3
输出：false

示例 2：
输入：root = [1,2,3,null,4,null,5], x = 5, y = 4
输出：true

示例 3：
输入：root = [1,2,3,null,4], x = 2, y = 3
输出：false
```



**提示：**

- 二叉树的节点数介于 2 到 100 之间。

- 每个节点的值都是唯一的、范围为 1 到 100 的整数。

## 2、解题思路

- 深度优先，记录两个之所在的深度与父节点的值分别比较

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def isCousins(self, root: TreeNode, x: int, y: int) -> bool:
        if x == root.val or y == root.val:
            return False

        x_level = 0
        x_parent = 0
        y_level = 0
        y_parent = 0

        def dfs(node, level, parent):
            nonlocal x_level, x_parent, y_level, y_parent,x,y
            if not node:
                return
            if node.val == x:
                x_parent = parent
                x_level = level + 1
            if node.val == y:
                y_level = level + 1
                y_parent = parent

            dfs(node.left, level + 1, node.val)
            dfs(node.right, level + 1, node.val)
    
        dfs(root.left, 1, root.val)
        dfs(root.right, 1, root.val)
        if x_level == y_level and x_parent != y_parent:
            return True
        return False

```

