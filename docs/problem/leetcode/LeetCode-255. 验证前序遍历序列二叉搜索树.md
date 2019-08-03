# LeetCode: 255. 验证前序遍历序列二叉搜索树

[TOC]

## 1、题目描述

给定一个整数数组，你需要验证它是否是一个二叉搜索树正确的先序遍历序列。

你可以假定该序列中的数都是不相同的。

参考以下这颗二叉搜索树：

```
     5
    / \
   2   6
  / \
 1   3
```

**示例 1：**

```
输入: [5,2,6,1,3]
输出: false
```



**示例 2：**

```
输入: [5,2,1,3,6]
输出: true
```



**进阶挑战：**

- 您能否使用恒定的空间复杂度来完成此题？

## 2、解题思路

- 设计一个栈，将不大于当前节点的值入栈

- 前序遍历的时候，当遇到一个不小于前一个节点值的节点，就表示找到了一个右节点，从栈中弹出左节点，根节点
- 后续的节点都要大于刚刚的根节点，因此使用一个变量存储，不断的更新阈值，也就是后续节点不能小于当前节点



```python
class Solution:
    def verifyPreorder(self, preorder: List[int]) -> bool:
        if not preorder:
            return True

        stack = []

        last_max = min(preorder)
        stack.append(preorder[0])

        for num in preorder[1:]:
            if num < last_max:
                return False

            while stack and stack[-1] < num:
                last_max = stack.pop()
            stack.append(num)

        return True
```

