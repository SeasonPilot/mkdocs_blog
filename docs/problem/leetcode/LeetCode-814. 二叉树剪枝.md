# LeetCode: 814. 二叉树剪枝

[TOC]

## 1、题目描述

给定二叉树根结点 root ，此外树的每个结点的值要么是 0，要么是 1。

返回移除了所有不包含 1 的子树的原二叉树。

( 节点 X 的子树为 X 本身，以及所有 X 的后代。)

**示例1:**

```
输入: [1,null,0,0,1]
输出: [1,null,0,null,1]

解释: 
只有红色节点满足条件“所有不包含 1 的子树”。
右图为返回的答案。
```

![](https://s3-lc-upload.s3.amazonaws.com/uploads/2018/04/06/1028_2.png)

**示例2:**

```
输入: [1,0,1,0,0,0,1]
输出: [1,null,1,null,1]
```

![](https://s3-lc-upload.s3.amazonaws.com/uploads/2018/04/06/1028_1.png)

**示例3:**

```
输入: [1,1,0,1,1,0,1,0]
输出: [1,1,0,1,1,null,1]
```

![](https://s3-lc-upload.s3.amazonaws.com/uploads/2018/04/05/1028.png)

**说明:**

- 给定的二叉树最多有 100 个节点。
- 每个节点的值只会为 0 或 1 。

## 2、解题思路

- DFS
- 递归判断左右节点都不存在，并且当前节点值为0，返回空，否则返回当前节点

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def pruneTree(self, root: TreeNode) -> TreeNode:
        if not root:
            return root

        def dfs(node: TreeNode):
            if not node:
                return True

            if not dfs(node.left):
                node.left = None

            if not dfs(node.right):
                node.right = None

            if node.val == 0 and not node.left and not node.right:
                return None

            return node

        return dfs(root)
```

