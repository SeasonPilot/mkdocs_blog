# LeetCode: 549. 二叉树中最长的连续序列

[TOC]

## 1、题目描述

给定一个二叉树，你需要找出二叉树中最长的连续序列路径的长度。

请注意，该路径可以是递增的或者是递减。例如，`[1,2,3,4]` 和 `[4,3,2,1]` 都被认为是合法的，而路径 `[1,2,4,3]` 则不合法。另一方面，路径可以是 子-父-子 顺序，并不一定是 父-子 顺序。

**示例 1:**

```
输入:
        1
       / \
      2   3
输出: 2
解释: 最长的连续路径是 [1, 2] 或者 [2, 1]。
```

**示例 2:**

```
输入:
        2
       / \
      1   3
输出: 3
解释: 最长的连续路径是 [1, 2, 3] 或者 [3, 2, 1]。
```

**注意:** 树上所有节点的值都在 $[-1e^7, 1e^7]$ 范围内。



## 2、解题思路

-   深度优先搜索
-   每个节点都想上传递下面三个值

```
val, up, down

- 当前节点的值
- 当前当前节点向下递增的最长序列
- 当前当前节点向下递减的最长序列
```

-   **注意：**考虑左右节点同时存在，并且左右节点以当前节点为中心的连接，更新结果值即可



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

        def dfs(node):
            nonlocal ans
            if not node.left and not node.right:
                ans = max(ans, 1)
                return node.val, 1, 1
            current_up = 1
            current_down = 1
            if node.left and node.right:
                left = dfs(node.left)
                right = dfs(node.right)
                if node.val == left[0] - 1 and node.val == right[0] + 1:
                    ans = max(ans, left[1] + right[2] + 1)
                if node.val == left[0] + 1 and node.val == right[0] - 1:
                    ans = max(ans, left[2] + right[1] + 1)
                if node.val == left[0] - 1:
                    current_up = max(current_up, 1 + left[1])
                if node.val == right[0] - 1:
                    current_up = max(current_up, 1 + right[1])
                if node.val == left[0] + 1:
                    current_down = max(current_down, 1 + left[2])
                if node.val == right[0] + 1:
                    current_down = max(current_down, 1 + right[2])
                ans = max(ans, current_up, current_down)
                return node.val, current_up, current_down

            elif node.left and not node.right:
                left = dfs(node.left)
                if node.val == left[0] - 1:
                    current_up = max(current_up, 1 + left[1])
                if node.val == left[0] + 1:
                    current_down = max(current_down, 1 + left[2])
                ans = max(ans, current_up, current_down)
                return node.val, current_up, current_down

            elif not node.left and node.right:
                right = dfs(node.right)
                if node.val == right[0] - 1:
                    current_up = max(current_up, 1 + right[1])
                if node.val == right[0] + 1:
                    current_down = max(current_down, 1 + right[2])
                ans = max(ans, current_up, current_down)
                return node.val, current_up, current_down
        dfs(root)
        return ans
```

