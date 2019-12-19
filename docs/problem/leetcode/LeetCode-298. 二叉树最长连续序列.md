# LeetCode: 298. 二叉树最长连续序列

[TOC]

## 1、题目描述

给你一棵指定的二叉树，请你计算它最长连续序列路径的长度。

该路径，可以是从某个初始结点到树中任意结点，通过「父 - 子」关系连接而产生的任意路径。

这个最长连续的路径，必须从父结点到子结点，反过来是不可以的。

**示例 1：**

```
输入:

   1
    \
     3
    / \
   2   4
        \
         5

输出: 3

解析: 当中，最长连续序列是 3-4-5，所以返回结果为 3
```

**示例 2：**

```
输入:

   2
    \
     3
    / 
   2    
  / 
 1

输出: 2 

解析: 当中，最长连续序列是 2-3。注意，不是 3-2-1，所以返回 2。
```



## 2、解题思路

-   DFS深度优先搜索

-   每次向下传递当前的值，路径长度，并更新最大路径值



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def longestConsecutive(self, root: TreeNode) -> int:
        if not root:
            return 0
        ans = 0

        def dfs(node, parent, parent_path):
            nonlocal ans
            if not node:
                return
            cur = 1
            if node.val == parent + 1:
                cur += parent_path

            ans = max(ans, cur)
            dfs(node.left, node.val, cur)
            dfs(node.right, node.val, cur)

        dfs(root, root.val + 1, 0)
        return ans
```

