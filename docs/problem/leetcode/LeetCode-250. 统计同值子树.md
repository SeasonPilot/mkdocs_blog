# LeetCode: 250. 统计同值子树

[TOC]

## 1、题目描述

给定一个二叉树，统计该二叉树数值相同的子树个数。

同值子树是指该子树的所有节点都拥有相同的数值。

**示例：**

    输入: root = [5,1,5,5,5,null,5]
    
              5
             / \
            1   5
           / \   \
          5   5   5
    
    输出: 4



## 2、解题思路

- 判断根节点是否存在，如果不存在，返回0
- 如果存在，判断根节点是否是同值子树
- 计算左右节点中的同值子树



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def countUnivalSubtrees(self, root: TreeNode) -> int:
        if not root:
            return 0

        temp = 0
        if self.isSameValue(root, root.val):
            temp += 1
        return temp + self.countUnivalSubtrees(root.left) + self.countUnivalSubtrees(root.right)

    def isSameValue(self, root, value):
        if not root:
            return True

        return root.val == value and self.isSameValue(root.left, value) and self.isSameValue(root.right, value)

```

