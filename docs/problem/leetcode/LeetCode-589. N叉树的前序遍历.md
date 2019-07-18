# LeetCode: 589. N叉树的前序遍历

[TOC]

## 1、题目描述

给定一个 N 叉树，返回其节点值的前序遍历。

例如，给定一个 3叉树 :

 

![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/10/12/narytreeexample.png)



返回其前序遍历: [1,3,5,6,2,4]。

 

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
    def preorder(self, root: 'Node') -> List[int]:
        if not root:
            return []
        res = [root.val]

        if root.children:
            for i in root.children:
                res.extend(self.preorder(i))

        return res
```

- 迭代法

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, children):
        self.val = val
        self.children = children
"""
class Solution:
    def preorder(self, root: 'Node') -> List[int]:
        if not root:
            return []
        res = [root]
        pos = 0

        while pos < len(res):
            if res[pos].children:
                res = res[:pos+1] + res[pos].children + res[pos+1:]
            pos += 1

        return [x.val for x in res]
```





