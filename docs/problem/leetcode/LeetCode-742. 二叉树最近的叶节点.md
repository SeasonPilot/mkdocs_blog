# LeetCode: 742. 二叉树最近的叶节点

[TOC]

## 1、题目描述

给定一个 **每个结点的值互不相同** 的二叉树，和一个目标值 `k`，找出树中与目标值 `k` 最近的叶结点。 

这里，与叶结点 最近 表示在二叉树中到达该叶节点需要行进的边数与到达其它叶结点相比最少。而且，当一个结点没有孩子结点时称其为叶结点。

在下面的例子中，输入的树以逐行的平铺形式表示。实际上的有根树 `root` 将以`TreeNode`对象的形式给出。

**示例 1：**

```
输入：
root = [1, 3, 2], k = 1
二叉树图示：
          1
         / \
        3   2

输出： 2 (或 3)

解释： 2 和 3 都是距离目标 1 最近的叶节点。
```

**示例 2：**

```
输入：
root = [1], k = 1
输出：1

解释： 最近的叶节点是根结点自身。
```

**示例 3：**

```
输入：
root = [1,2,3,4,null,null,null,5,null,6], k = 2
二叉树图示：
             1
            / \
           2   3
          /
         4
        /
       5
      /
     6

输出：3
解释： 值为 3（而不是值为 6）的叶节点是距离结点 2 的最近结点。
```

**注：**

-   `root` 表示的二叉树最少有 `1` 个结点且最多有 `1000` 个结点。
-   每个结点都有一个唯一的 `node.val` ，范围为 `[1, 1000]`。
-   给定的二叉树中有某个结点使得 `node.val == k`。



## 2、解题思路

-   分两步
    -   第一步，找出每个节点最近的叶子节点的距离与值，从叶子节点向上更新
    -   第二步，从上向下更新，考虑经过父节点距离更短的情况



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None


from collections import defaultdict


class Solution:
    def findClosestLeaf(self, root: TreeNode, k: int) -> int:
        short_node = defaultdict(lambda: (float('inf'), -1))

        def dfs_bottom_up(node):
            if not node:
                return
            if not node.left and not node.right:
                short_node[node.val] = (0, node.val)
                return
            dfs_bottom_up(node.left)
            dfs_bottom_up(node.right)
            if node.left and short_node[node.left.val][0] + 1 < short_node[node.val][0]:
                short_node[node.val] = (short_node[node.left.val][0] + 1, short_node[node.left.val][1])
            if node.right and short_node[node.right.val][0] + 1 < short_node[node.val][0]:
                short_node[node.val] = (short_node[node.right.val][0] + 1, short_node[node.right.val][1])

        def dfs_up_bottom(node):
            if not node:
                return
            if node.left and short_node[node.val][0] + 1 < short_node[node.left.val][0]:
                short_node[node.left.val] = (short_node[node.val][0] + 1, short_node[node.val][1])
            if node.right and short_node[node.val][0] + 1 < short_node[node.right.val][0]:
                short_node[node.right.val] = (short_node[node.val][0] + 1, short_node[node.val][1])
            dfs_up_bottom(node.left)
            dfs_up_bottom(node.right)

        dfs_bottom_up(root)
        dfs_up_bottom(root)
        return short_node[k][1]
```

