# LeetCode: 1161. 最大层内元素和

[TOC]

## 1、题目描述

给你一个二叉树的根节点 root。设根节点位于二叉树的第 1 层，而根节点的子节点位于第 2 层，依此类推。

请你找出层内元素之和 最大 的那几层（可能只有一层）的层号，并返回其中 最小 的那个。

 

**示例：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-084230.jpg)

```
输入：[1,7,0,7,-8,null,null]
输出：2
解释：
第 1 层各元素之和为 1，
第 2 层各元素之和为 7 + 0 = 7，
第 3 层各元素之和为 7 + -8 = -1，
所以我们返回第 2 层的层号，它的层内元素之和最大。
```

**提示：**

- 树中的节点数介于 `1` 和 `10^4` 之间

-  $-10^5 <= node.val <= 10^5$ 

## 2、解题思路

- 层次遍历



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def maxLevelSum(self, root: TreeNode) -> int:
        from collections import deque

        total_sum = root.val
        res_level = 1
        d = deque([root])
        level = 1
        while d:
            total = sum([x.val for x in d])

            if total > total_sum:
                total_sum = total
                res_level = level
            for i in range(len(d)):
                t = d.popleft()
                if t.left:
                    d.append(t.left)
                if t.right:
                    d.append(t.right)
            level += 1

        return res_level
```

