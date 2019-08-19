# LeetCode: 515. 在每个树行中找最大值

[TOC]

## 1、题目描述

您需要在二叉树的每一行中找到最大的值。

**示例：**

    输入: 
          1
         / \
        3   2
       / \   \  
      5   3   9 
    输出: [1, 3, 9]



## 2、解题思路

- 层次遍历，每一次找出最大值

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def largestValues(self, root: TreeNode) -> List[int]:
        if not root:
            return []
        current = [root]
        res = []
        while current:
            res.append(max([x.val for x in current]))
            next_nodes = []
            next_nodes.extend([x.left for x in current if x.left])
            next_nodes.extend([x.right for x in current if x.right])
            current = next_nodes

        return res
```

