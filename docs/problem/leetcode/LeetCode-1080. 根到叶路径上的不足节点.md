# LeetCode: 1080. 根到叶路径上的不足节点

[TOC]

## 1、题目描述

给定一棵二叉树的根 `root`，请你考虑它所有 从根到叶的路径：从根到任何叶的路径。（所谓一个叶子节点，就是一个没有子节点的节点）

假如通过节点 `node` 的每种可能的 “根-叶” 路径上值的总和全都小于给定的 `limit`，则该节点被称之为「不足节点」，需要被删除。

请你删除所有不足节点，并返回生成的二叉树的根。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-16-081332.png)

```
输入：root = [1,2,3,4,-99,-99,7,8,9,-99,-99,12,13,-99,14], limit = 1
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-16-081359.png)


```
输出：[1,2,3,4,null,null,7,8,9,null,14]
```

**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-16-081430.png)

```
输入：root = [5,4,8,11,null,17,4,7,1,null,null,5,3], limit = 22
```

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-16-081420.png)

```
输出：[5,4,8,11,null,17,4,7,null,null,null,5]
```

**示例 3：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-16-081447.png)

```
输入：root = [5,-6,-6], limit = 0
输出：[]
```

**提示：**

-   `给定的树有 1 到 5000 个节点`
-   `-10^5 <= node.val <= 10^5`
-   `-10^9 <= limit <= 10^9`




## 2、解题思路

-   一遍深度优先搜索

-   由于是路径上面的和值，需要同时向下传递当前路径的值才能判断子路径是否需要删除



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def sufficientSubset(self, root: TreeNode, limit: int) -> TreeNode:
        head = TreeNode(0)
        head.left = root

        def dfs(node: TreeNode, father_sums):
            if not node:
                return 0

            left = dfs(node.left, father_sums + node.val)
            right = dfs(node.right, father_sums + node.val)

            sub_sum = 0
            if node.left and node.right:
                sub_sum = max(left, right)
            elif node.left:
                sub_sum = left
            elif node.right:
                sub_sum = right

            if father_sums + node.val + left < limit:
                node.left = None
            if father_sums + node.val + right < limit:
                node.right = None

            return node.val + sub_sum

        dfs(head, 0)

        return head.left
```

