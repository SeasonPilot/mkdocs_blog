# LeetCode: 124. 二叉树中的最大路径和

[TOC]

## 1、题目描述



给定一个非空二叉树，返回其最大路径和。

本题中，路径被定义为一条从树中任意节点出发，达到任意节点的序列。该路径至少包含一个节点，且不一定经过根节点。

示例 1:

```
输入: [1,2,3]

       1
      / \
     2   3

输出: 6
```


示例 2:

```
输入: [-10,9,20,null,null,15,7]

   -10
   / \
  9  20
    /  \
   15   7

输出: 42
```



## 2、解题思路

最大路径和，假如根节点是当前节点，那么后面的只能选择左子树或者右子树中的一个

使用递归进行求解

- 得到左子树最大值
- 得到右子树的最大值

一共有下面情况可以考虑：

- 根
- 根+左
- 根+右
- 根+左+右

从上面3个中需选出最大值返回进行传播



然后不断地更新结果值，从而得到最大值



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def maxPathSum(self, root: TreeNode) -> int:
        res = -2**31
        
        def dfs(r):
            nonlocal res
            if not r:
                return 0
            max_left = dfs(r.left)
            max_right = dfs(r.right)
            tmp = max(max_left,max_right,0)+ r.val
            res = max(res,max_left+max_right+r.val,tmp)
            return tmp
        dfs(root)
        return res
```



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def maxPathSum(self, root: TreeNode) -> int:
        self.res = -2 ** 31
        self.dfs(root)
        return self.res

    def dfs(self, root: TreeNode):
        if not root:
            return 0

        left = self.dfs(root.left)
        right = self.dfs(root.right)

        temp = max(left, right, 0) + root.val
        self.res = max(self.res, root.val + left + right, temp)
        return temp
        
```

