# LeetCode: 1214. 查找两棵二叉搜索树之和

[TOC]

## 1、题目描述

给出两棵二叉搜索树，请你从两棵树中各找出一个节点，使得这两个节点的值之和等于目标值 `Target`。

如果可以找到返回 `True`，否则返回 `False`。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-07-051336.png)

```
输入：root1 = [2,1,4], root2 = [1,0,3], target = 5
输出：true
解释：2 加 3 和为 5 。
```

**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-07-051344.png)

```
输入：root1 = [0,-10,10], root2 = [5,1,7,0,2], target = 18
输出：false
```

**提示：**

-   `每棵树上最多有 5000 个节点。`
-   `-10^9 <= target, node.val <= 10^9`



## 2、解题思路

-   递归查找即可



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def twoSumBSTs(self, root1: TreeNode, root2: TreeNode, target: int) -> bool:
        def find_value(node, num):
            if not node:
                return False

            ans = node.val == num
            if not ans:
                if num > node.val:
                    ans = find_value(node.right, num)
                else:
                    ans = find_value(node.left, num)

            return ans

        def dfs(node):
            if not node:
                return

            return find_value(root2, target - node.val) or dfs(node.left) or dfs(node.right)

        return dfs(root1)

```

