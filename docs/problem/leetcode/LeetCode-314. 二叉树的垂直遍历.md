# LeetCode: 314. 二叉树的垂直遍历

[TOC]

## 1、题目描述

给定一个二叉树，返回其结点 垂直方向（从上到下，逐列）遍历的值。

如果两个结点在同一行和列，那么顺序则为 从左到右。

**示例 1：**

```
输入: [3,9,20,null,null,15,7]

   3
  /\
 /  \
9   20
    /\
   /  \
  15   7 

输出:

[
  [9],
  [3,15],
  [20],
  [7]
]
```
**示例 2:**

```
输入: [3,9,8,4,0,1,7]

     3
    /\
   /  \
  9    8
  /\   /\
 /  \ /  \
4   0 1   7 

输出:

[
  [4],
  [9],
  [3,0,1],
  [8],
  [7]
]
```
**示例 3:**

```
输入: [3,9,8,4,0,1,7,null,null,null,2,5]（注意：0 的右侧子节点为 2，1 的左侧子节点为 5）

     3
    /\
   /  \
   9   8
  /\  /\
 /  \/  \
 4  01   7
    /\
   /  \
   5   2

输出:

[
  [4],
  [9,5],
  [3,0,1],
  [8,2],
  [7]
]

```

## 2、解题思路

-   带level的层次遍历



```python
from typing import List
from collections import deque, defaultdict


# Definition for a binary tree node.
# class TreeNode:
    # def __init__(self, x):
        # self.val = x
        # self.left = None
        # self.right = None


class Solution:
    def verticalOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []
        res = defaultdict(list)
        d = deque()
        d.append((root, 0))
        while d:
            node, level = d.popleft()
            res[level].append(node.val)
            if node.left:
                d.append((node.left, level - 1))
            if node.right:
                d.append((node.right, level + 1))

        return [res[x] for x in sorted(res.keys())]

```

