# LeetCode: 663. 均匀树划分

[TOC]

## 1、题目描述

给定一棵有 `n` 个结点的二叉树，你的任务是检查是否可以通过去掉树上的一条边将树分成两棵，且这两棵树结点之和相等。

**样例 1:**

```
输入:     
    5
   / \
  10 10
    /  \
   2   3

输出: True
解释: 
    5
   / 
  10
      
和: 15

   10
  /  \
 2    3

和: 15
```

**样例 2:**

```
输入:     
    1
   / \
  2  10
    /  \
   2   20

输出: False
解释: 无法通过移除一条树边将这棵树划分成结点之和相等的两棵子树。
```

**注释 :**

-   树上结点的权值范围 `[-100000, 100000]`。
-   $1 <= n <= 10000$



## 2、解题思路

-   尝试断开每个节点的左右节点进行判断
-   向下传递当前节点父节点之上的和值以及兄弟树的值



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

from functools import lru_cache


class Solution:
    def checkEqualTree(self, root: TreeNode) -> bool:
        @lru_cache(None)
        def get_sum(node):
            if not node:
                return 0
            return node.val + get_sum(node.left) + get_sum(node.right)

        ans = False

        def dfs(node, cur_sum):
            nonlocal ans
            if ans or not node or (not node.left and not node.right):
                return
            if node.left and node.val + cur_sum + get_sum(node.right) == get_sum(node.left):
                ans = True
            if node.left and (node.left.left or node.left.right):
                dfs(node.left, node.val + cur_sum + get_sum(node.right))

            if node.right and node.val + cur_sum + get_sum(node.left) == get_sum(node.right):
                ans = True
            if node.right and (node.right.left or node.right.right):
                dfs(node.right, node.val + cur_sum + get_sum(node.left))

        dfs(root, 0)
        return ans
```

