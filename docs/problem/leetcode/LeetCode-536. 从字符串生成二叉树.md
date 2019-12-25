# LeetCode: 536. 从字符串生成二叉树

[TOC]

## 1、题目描述

你需要从一个包括括号和整数的字符串构建一棵二叉树。

输入的字符串代表一棵二叉树。它包括整数和随后的`0`，`1`或`2`对括号。整数代表根的值，一对括号内表示同样结构的子树。

若存在左子结点，则从左子结点开始构建。

**示例:**

```
输入: "4(2(3)(1))(6(5))"
输出: 返回代表下列二叉树的根节点:

       4
     /   \
    2     6
   / \   / 
  3   1 5   

```
**注意:**

-   输入字符串中只包含 `'(', ')'`, `'-'` 和 `'0' ~ '9'` 
-   空树由 "" 而非`"()"`表示。



## 2、解题思路

-   递归

1.  首先判断是否有字符，没有的话，返回`None`
2.  如果没有左右节点，字符串的值就是当前节点的值，返回即可
3.  如果有左右节点，找出分界点，递归



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def str2tree(self, s: str) -> TreeNode:
        if not s:
            return None
        if "(" not in s:
            return TreeNode(int(s))

        left_node_start = s.index("(")
        current_node = TreeNode(int(s[:left_node_start]))
        pos = left_node_start + 1
        left_count = 1
        while left_count:
            if s[pos] == "(":
                left_count += 1
            if s[pos] == ")":
                left_count -= 1
            pos += 1
        current_node.left = self.str2tree(s[left_node_start + 1:pos - 1])
        current_node.right = self.str2tree(s[pos + 1:-1])
        return current_node
```

