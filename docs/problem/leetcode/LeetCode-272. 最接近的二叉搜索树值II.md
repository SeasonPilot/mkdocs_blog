# LeetCode: 272. 最接近的二叉搜索树值II

[TOC]

## 1、题目描述

给定一个不为空的二叉搜索树和一个目标值 `target`，请在该二叉搜索树中找到最接近目标值 `target` 的 `k` 个值。

**注意：**

-   给定的目标值 `target` 是一个浮点数
-   你可以默认 `k` 值永远是有效的，即 `k ≤` 总结点数
-   题目保证该二叉搜索树中只会存在一种 `k` 个值集合最接近目标值

**示例：**

```
输入: root = [4,2,5,1,3]，目标值 = 3.714286，且 k = 2

    4
   / \
  2   5
 / \
1   3

输出: [4,3]
```
**拓展：**

-   假设该二叉搜索树是平衡的，请问您是否能在小于 `O(n)`（`n` 为总结点数）的时间复杂度内解决该问题呢？



## 2、解题思路

-   使用中序遍历
-   使用长度为`k`的队列，不断的加入队列，直到新的元素距离`target`的距离大于队列中第一个元素离`target`的距离

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
from typing import List
from collections import deque


class Solution:
    def closestKValues(self, root: TreeNode, target: float, k: int) -> List[int]:
        d = deque(maxlen=k)
        stack = deque()
        stack.append(root)
        find = False
        while stack and not find:

            while stack[-1].left:
                stack.append(stack[-1].left)

            while stack:
                current = stack.pop()
                if len(d) < k:
                    d.append(current.val)
                else:
                    if abs(target - d[0]) < abs(target - current.val):
                        find = True
                        break
                    else:
                        d.append(current.val)
                if current.right:
                    stack.append(current.right)
                    break
        return list(d)

```

