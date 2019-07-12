# LeetCode: 270. 最接近的二叉搜索树值

[TOC]

## 1、题目描述

给定一个不为空的二叉搜索树和一个目标值 target，请在该二叉搜索树中找到最接近目标值 target 的数值。

注意：

给定的目标值 target 是一个浮点数
题目保证在该二叉搜索树中只会存在一个最接近目标值的数
示例：

```
输入: root = [4,2,5,1,3]，目标值 target = 3.714286

    4
   / \
  2   5
 / \
1   3

输出: 4
```



## 2、解题思路

- 给定一个数字，最接近的差值肯定是0，如果遇到差值为0，直接返回该数字
- 使用两个变量保存，一个是差值的绝对值，一个是差值对应的节点值
- 从根节点二分法开始查找，到叶子节点结束

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:    
    def closestValue(self, root: TreeNode, target: float) -> int:
        if not root:
            return None
        self.value = root.val
        self.difference = abs(root.val - target)
        
        self.treeValue(root,target)
        return self.value

    def treeValue(self, root: TreeNode, target):
        if not root:
            return

        temp = abs(target - root.val)
        if temp <= self.difference:
            self.value = root.val
            self.difference = temp

        if target > root.val:
            self.treeValue(root.right, target)
        else:
            self.treeValue(root.left, target)
```



下面是更简单的写法，直接保存当前值，然后通过判断递归调用，一直到叶子节点

- 如果当前节点是叶子节点，放回当前节点值
- 如果target大于当前节点值，下一次以右子树进行判断，否则判断左子树
- 判断当前节点与子树返回值哪一个更接近target，并返回



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:    
    def closestValue(self, root: TreeNode, target: float) -> int:
        temp_a = root.val
        next_node = root.left if target < temp_a else root.right
        if not next_node:
            return temp_a
        temp_b = self.closestValue(next_node,target)

        return temp_a if  abs(temp_a -target) < abs(temp_b - target) else temp_b
        
```

