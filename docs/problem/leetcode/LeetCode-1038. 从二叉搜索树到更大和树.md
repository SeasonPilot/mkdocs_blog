# LeetCode: 1038. 从二叉搜索树到更大和树

[TOC]

## 1、题目描述

给出二叉搜索树的根节点，该二叉树的节点值各不相同，修改二叉树，使每个节点 node 的新值等于原树中大于或等于 `node.val` 的值之和。

提醒一下，二叉搜索树满足下列约束条件：

- 节点的左子树仅包含键小于节点键的节点。
- 节点的右子树仅包含键大于节点键的节点。
- 左右子树也必须是二叉搜索树。

**示例：**

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050557.png)

```
输入：[4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
输出：[30,36,21,36,35,26,15,null,null,null,33,null,null,null,8]
```

**提示：**

- 树中的节点数介于 1 和 100 之间。
- 每个节点的值介于 0 和 100 之间。
- 给定的树为二叉搜索树。

## 2、解题思路

- 先使用DFS得到总的和
- 然后使用中序遍历，每一次先将和赋值，然后和减去之前的val



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def bstToGst(self, root: TreeNode) -> TreeNode:
        total = 0

        def dfs_sum(node):
            nonlocal total
            if not node:
                return
            dfs_sum(node.left)
            total += node.val
            dfs_sum(node.right)
            

        def dfs(node: TreeNode):
            nonlocal total
            if not node:
                return
            dfs(node.left)
            temp = node.val
            node.val = total
            total -= temp
            dfs(node.right)

        dfs_sum(root)
        dfs(root)
        return root
```

