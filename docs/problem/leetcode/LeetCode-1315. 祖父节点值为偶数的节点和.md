# LeetCode: 1315. 祖父节点值为偶数的节点和

[TOC]

## 1、题目描述

给你一棵二叉树，请你返回满足以下条件的所有节点的值之和：

该节点的祖父节点的值为偶数。（一个节点的祖父节点是指该节点的父节点的父节点。）
如果不存在祖父节点值为偶数的节点，那么返回 `0` 。

 

**示例：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2020-01-12-045156.png)

```
输入：root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
输出：18
解释：图中红色节点的祖父节点的值为偶数，蓝色节点为这些红色节点的祖父节点。
```

**提示：**

-   树中节点的数目在 `1` 到 `10^4` 之间。
-   每个节点的值在 `1` 到 `100` 之间。



## 2、解题思路

-   DFS深度优先搜索



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def sumEvenGrandparent(self, root: TreeNode) -> int:
        ans = 0

        def dfs(node):
            nonlocal ans
            if not node or not node.left and not node.right:
                return
            if node.val % 2 == 0:
                if node.left:
                    if node.left.left:
                        ans += node.left.left.val
                    if node.left.right:
                        ans += node.left.right.val
                if node.right:
                    if node.right.left:
                        ans += node.right.left.val
                    if node.right.right:
                        ans += node.right.right.val
            dfs(node.left)
            dfs(node.right)

        dfs(root)
        return ans
```

