# LeetCode: 333. 最大 BST 子树

[TOC]

## 1、题目描述

给定一个二叉树，找到其中最大的二叉搜索树`（BST）`子树，其中最大指的是子树节点数最多的。

注意:
子树必须包含其所有后代。

**示例:**

```
输入: [10,5,15,1,8,null,7]

   10 
   / \ 
  5  15 
 / \   \ 
1   8   7

输出: 3
解释: 高亮部分为最大的 BST 子树。
     返回值 3 在这个样例中为子树大小。
```

**进阶:**

-   你能想出用 `O(n)` 的时间复杂度解决这个问题吗？



## 2、解题思路

-   DFS
-   从子节点向上传递三个值
    -   最小值
    -   最大值
    -   搜索节点的数量

如果搜索节点的数量是-1，表示子树已经不是搜索树了



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def largestBSTSubtree(self, root: TreeNode) -> int:
        if not root:
            return 0
        ans = 0

        def dfs(node):
            nonlocal ans
            if not node.left and not node.right:
                ans = max(ans, 1)
                return node.val, node.val, 1

            if node.left and node.right:
                left_min, left_max, left_num = dfs(node.left)
                right_min, right_max, right_num = dfs(node.right)
                if left_num != -1 and right_num != -1:
                    if left_max < node.val < right_min:
                        ans = max(ans, left_num + right_num + 1)
                        return left_min, right_max, left_num + right_num + 1

            elif node.left and not node.right:
                left_min, left_max, left_num = dfs(node.left)
                if left_num != -1:
                    if left_max < node.val:
                        ans = max(ans, left_num + 1)
                        return left_min, node.val, left_num + 1
            elif not node.left and node.right:
                right_min, right_max, right_num = dfs(node.right)
                if right_num != -1:
                    if node.val < right_min:
                        ans = max(ans, right_num + 1)
                        return node.val, right_max, right_num + 1

            return -1, -1, -1

        dfs(root)
        return ans
```

