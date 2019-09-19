# LeetCode: 1008. 先序遍历构造二叉树

[TOC]

## 1、题目描述

返回与给定先序遍历 `preorder` 相匹配的二叉搜索树（`binary search tree`）的根结点。

(回想一下，二叉搜索树是二叉树的一种，其每个节点都满足以下规则，对于 `node.left` 的任何后代，值总 `< node.val`，而 `node.right` 的任何后代，值总 `> node.val`。此外，先序遍历首先显示节点的值，然后遍历 `node.left`，接着遍历 `node.right`。）

 

**示例：**

```
输入：[8,5,1,7,10,12]
输出：[8,5,10,1,7,null,12] 
```

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050542.png)

**提示：**

-  `1 <= preorder.length <= 100` 
- 先序 preorder 中的值是不同的。

## 2、解题思路

- DFS
- 使用dfs，将小于当前顶点的值作为左子树，大于的作为右子树



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def bstFromPreorder(self, preorder: List[int]) -> TreeNode:
        import bisect
        if not preorder:
            return None

        def dfs(l):
            if not l:
                return None

            node = TreeNode(l[0])
            node.left = dfs(l[1:bisect.bisect_right(l, l[0], 1)])
            node.right = dfs(l[bisect.bisect_right(l, l[0], 1):])

            return node
          
        return dfs(preorder)
```

