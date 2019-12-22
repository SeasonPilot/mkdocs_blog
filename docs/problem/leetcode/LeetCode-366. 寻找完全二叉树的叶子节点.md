# LeetCode: 366. 寻找完全二叉树的叶子节点

[TOC]

## 1、题目描述

给你一棵完全二叉树，请按以下要求的顺序收集它的全部节点：

依次从左到右，每次收集并删除所有的叶子节点
重复如上过程直到整棵树为空
**示例:**

```
输入: [1,2,3,4,5]

          1
         / \
        2   3
       / \     
      4   5    

输出: [[4,5,3],[2],[1]]

```
**解释:**

1. 删除叶子节点 [4,5,3] ，得到如下树结构：
```
          1
         / 
        2          
```

2. 现在删去叶子节点 [2] ，得到如下树结构：
```
          1          
```

3. 现在删去叶子节点 [1] ，得到空树：
```
          []         
```


## 2、解题思路

子树的高度作为分组的标准
每次都是先左后右

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def findLeaves(self, root: TreeNode) -> List[List[int]]:
        ans = []

        def dfs(node):
            if not node:
                return 0
            current_level = max(dfs(node.left), dfs(node.right))
            if current_level >= len(ans):
                ans.append([])

            ans[current_level].append(node.val)
            return current_level + 1

        dfs(root)
        return ans
```

