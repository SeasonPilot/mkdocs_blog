# LeetCode: 938. 二叉搜索树的范围和

[TOC]

## 1、题目描述

给定二叉搜索树的根结点 root，返回 L 和 R（含）之间的所有结点的值的和。

二叉搜索树保证具有唯一的值。

 

示例 1：

输入：root = [10,5,15,3,7,null,18], L = 7, R = 15
输出：32
示例 2：

输入：root = [10,5,15,3,7,13,18,1,null,6], L = 6, R = 10
输出：23


提示：

树中的结点数量最多为 10000 个。
最终的答案保证小于 2^31。

## 2、解题思路

根据上面的描述，因为是二叉搜索树，将整棵树看成一个有序数组，将其中一段进行求和，因此，简单的解题思路就是：

- 判断根节点是否是None,如果是，返回0
- 判断当前节点是不是大于R，若是，则从当前节点的左节点开始查找
- 判断当前节点是不是小于L，若是，则从当前节点的右节点开始查找
- 如果当前节点值在L和R之间，返回当前值，并分别从左右节点进行查找



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def rangeSumBST(self, root: TreeNode, L: int, R: int) -> int:
        if root == None:
            return 0
        elif root.val > R:
            return self.rangeSumBST(root.left, L, R)
        elif root.val < L:
            return self.rangeSumBST(root.right, L, R)
        else:
            return root.val + self.rangeSumBST(root.left, L, R) + self.rangeSumBST(root.right, L, R)
   
```

