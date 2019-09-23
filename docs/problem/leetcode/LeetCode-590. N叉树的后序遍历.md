# LeetCode: 590. N叉树的后序遍历

[TOC]

## 1、题目描述

给定一个 N 叉树，返回其节点值的后序遍历。

例如，给定一个 3叉树 :



![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-19-050953.png)



返回其后序遍历: [5,6,3,2,4,1].

 

说明: 递归法很简单，你可以使用迭代法完成此题吗?



## 2、解题思路

- 递归法



```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, children):
        self.val = val
        self.children = children
"""
class Solution:
    def postorder(self, root: 'Node') -> List[int]:
        if not root:
            return []

        res = [root.val]

        if root.children:
            for i in reversed(root.children):
                res = self.postorder(i) + res
        return res
```

