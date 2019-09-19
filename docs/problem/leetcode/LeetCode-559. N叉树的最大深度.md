# LeetCode: 559. N叉树的最大深度

[TOC]

## 1、题目描述

给定一个 N 叉树，找到其最大深度。

最大深度是指从根节点到最远叶子节点的最长路径上的节点总数。

例如，给定一个 3叉树 :

 

 ![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050930.png)

我们应返回其最大深度，3。

说明:

- 树的深度不会超过 1000。

- 树的节点总不会超过 5000。

## 2、解题思路

- 层次遍历法

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, children):
        self.val = val
        self.children = children
"""
class Solution:
    def maxDepth(self, root: 'Node') -> int:
        if not root:
            return 0
        current = [root]
        child = []
        count = 0
        while current:
            count += 1
            for i in current:
                child.extend(i.children)

            current = child
            child = []
        return count
```



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
    def maxDepth(self, root: 'Node') -> int:
        if not root:
            return 0

        depth = max([self.maxDepth(x) for x in root.children]) if root.children else 0
        return depth + 1
    
```



