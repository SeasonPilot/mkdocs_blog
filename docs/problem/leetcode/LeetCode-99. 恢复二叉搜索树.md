# LeetCode: 99. 恢复二叉搜索树

[TOC]

## 1、题目描述

二叉搜索树中的两个节点被错误地交换。

请在不改变其结构的情况下，恢复这棵树。

**示例 1:**

```
输入: [1,3,null,null,2]

   1
  /
 3
  \
   2

输出: [3,1,null,null,2]

   3
  /
 1
  \
   2
```


**示例 2:**

```
输入: [3,1,4,null,null,2]

  3
 / \
1   4
   /
  2

输出: [2,1,4,null,null,3]

  2
 / \
1   4
   /
  3
```


**进阶:**

- `使用 O(n) 空间复杂度的解法很容易实现。`
- `你能想出一个只使用常数空间的解决方案吗？`

## 2、解题思路

- 使用中序遍历

因为是二叉搜索树，因此中序遍历能够得到顺序值

假设是下面的顺序：

```
3 2 1 4 5 6
如上，我们发现3和1的位置是相反的
因此，只要找到两次相反的顺序，并且记住这两个节点，交换它们的值即可
```



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def recoverTree(self, root: TreeNode) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        
        pre, t1, t2 = None, None, None

        def inorder(node: TreeNode):
            nonlocal pre, t1, t2
            if not node:
                return
            inorder(node.left)
            if pre and pre.val > node.val:
                if not t1:
                    t1 = pre
                t2 = node
            pre = node

            inorder(node.right)

        inorder(root)
        t1.val, t2.val = t2.val, t1.val
```

