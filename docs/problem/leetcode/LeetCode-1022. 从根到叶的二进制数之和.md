# LeetCode: 1022. 从根到叶的二进制数之和

[TOC]

## 1、题目描述

给出一棵二叉树，其上每个结点的值都是 0 或 1 。每一条从根到叶的路径都代表一个从最高有效位开始的二进制数。例如，如果路径为` 0 -> 1 -> 1 -> 0 -> 1`，那么它表示二进制数 `01101`，也就是 `13`  。

对树上的每一片叶子，我们都要找出从根到该叶子的路径所表示的数字。

以 $10^9 + 7$  为模，返回这些数字之和。

 

**示例：**

```
输入：[1,0,1,0,1,0,1]
输出：22
解释：(100) + (101) + (110) + (111) = 4 + 5 + 6 + 7 = 22
```

**提示：**

- 树中的结点数介于 1 和 1000 之间。

-  $node.val$  为 0 或 1 。

## 2、解题思路

- 深度优先搜索
- 上层传递下来前面累加的值，直到最下层返回结果

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def sumRootToLeaf(self, root: TreeNode) -> int:
        if not root:
            return 0

        def dfs(node, value):
            if not node:
                return 0
            left = 0
            right = 0
            cur = value * 2 + node.val

            if node.left or node.right:
                left = dfs(node.left, cur)
                right = dfs(node.right, cur)
            else:
                return cur
            return left + right

        return dfs(root, 0)
    
```

