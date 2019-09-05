# LeetCode: 145. 二叉树的后序遍历

[TOC]

## 1、题目描述

给定一个二叉树，返回它的 后序 遍历。

**示例:**

```
输入: [1,null,2,3]  
   1
    \
     2
    /
   3 

输出: [3,2,1]
```


**进阶:**

- 递归算法很简单，你可以通过迭代算法完成吗？



## 2、解题思路

- 使用mirris后序遍历



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def postorderTraversal(self, root: TreeNode) -> List[int]:
        res = []

        def mirris_postorder(node: TreeNode):
            tmp = TreeNode(0)
            tmp.left = node
            p = tmp
            while p:
                if not p.left:
                    # print(p.val)
                    p = p.right
                else:
                    temp = p.left
                    # 找到左子树的最右子节点
                    while temp.right and temp.right != p:
                        temp = temp.right

                    if not temp.right:
                        temp.right = p
                        p = p.left
                    else:
                        print_reverse(p.left, temp)
                        temp.right = None
                        p = p.right

        def reverse_node(from_node, to_node):
            if from_node == to_node:
                return
            x, y = from_node, from_node.right
            while x != to_node:
                z = y.right
                y.right = x
                x, y = y, z

        def print_reverse(from_node, to_node):
            reverse_node(from_node, to_node)
            p = to_node
            while True:
                res.append(p.val)
                if p == from_node:
                    break
                p = p.right
            reverse_node(to_node, from_node)

        mirris_postorder(root)

        return res
```

