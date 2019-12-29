# LeetCode: 1302. 层数最深叶子节点的和

[TOC]

## 1、题目描述

给你一棵二叉树，请你返回层数最深的叶子节点的和。

 

**示例：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-29-072808.png)

```
输入：root = [1,2,3,4,5,null,6,7,null,null,null,null,8]
输出：15
```

**提示：**

-   树中节点数目在 `1` 到 `10^4` 之间。
-   每个节点的值在 `1` 到 `100` 之间。



## 2、解题思路

-   层次遍历，找出最底层即可



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def deepestLeavesSum(self, root: TreeNode) -> int:
        current = [root]
        while current:
            next_level = []
            for node in current:
                if node.left:
                    next_level.append(node.left)
                if node.right:
                    next_level.append(node.right)
            if not next_level:
                return sum([x.val for x in current])
            current = next_level
```

