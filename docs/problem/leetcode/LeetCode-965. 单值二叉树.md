# LeetCode: 965. 单值二叉树

[TOC]

## 1、题目描述

如果二叉树每个节点都具有相同的值，那么该二叉树就是单值二叉树。

只有给定的树是单值二叉树时，才返回 true；否则返回 false。

 

**示例 1：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-051322.png)



```
输入：[1,1,1,1,1,null,1]
输出：true
```

**示例 2：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-051329.png)

```
输入：[2,2,2,5,2]
输出：false
```



**提示：**

- 给定树的节点数范围是 [1, 100]。

- 每个节点的值都是整数，范围为 [0, 99] 。

## 2、解题思路

- 递归法

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def isUnivalTree(self, root: TreeNode) -> bool:
        if not root:
            return True
        left = True
        right = True
        if root.left:
            if root.val == root.left.val:
                left = self.isUnivalTree(root.left)
            else:
                left = False
        if root.right:
            if root.val == root.right.val:
                right = self.isUnivalTree(root.right)
            else:
                right = False

        return left and right
```

