# LeetCode: 429. N叉树的层序遍历

[TOC]

## 1、题目描述

给定一个 N 叉树，返回其节点值的层序遍历。 (即从左到右，逐层遍历)。

例如，给定一个 3叉树 :

 ![](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-09-19-050721.png)

返回其层序遍历:

```
[
     [1],
     [3,2,4],
     [5,6]
]
```




说明:

树的深度不会超过 1000。
树的节点总数不会超过 5000。



## 2、解题思路

- 设置两个list，一个保存当前层级，一个保存下一层级



```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, children):
        self.val = val
        self.children = children
"""

class Solution:
    def levelOrder(self, root: 'Node') -> List[List[int]]:
        if not root:
            return []
        current = [root]
        child = []
        res = []
        while current:
            temp = []
            for i in current:
                temp.append(i.val)
                child.extend(i.children)
            res.append(temp)
            current = child
            child = []
        return res
        
```







