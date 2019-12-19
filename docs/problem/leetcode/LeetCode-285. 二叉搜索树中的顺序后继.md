# LeetCode: 285. 二叉搜索树中的顺序后继

[TOC]

## 1、题目描述

给你一个二叉搜索树和其中的某一个结点，请你找出该结点在树中顺序后继的节点。

结点 `p` 的后继是值比 `p.val` 大的结点中键值最小的结点。

 

**示例 1:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-19-102041.png)

```
输入: root = [2,1,3], p = 1
输出: 2
解析: 这里 1 的顺序后继是 2。请注意 p 和返回值都应是 TreeNode 类型。
```


**示例 2:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-19-102046.png)

```
输入: root = [5,3,6,2,4,null,null,1], p = 6
输出: null
解析: 因为给出的结点没有顺序后继，所以答案就返回 null 了。
```

**注意:**

-   假如给出的结点在该树中没有顺序后继的话，请返回 `null`
-   我们保证树中每个结点的值是唯一的



## 2、解题思路

-   如果目标节点小于当前节点，当前节点有可能是目标节点的后继节点，放入栈中保存
-   如果目标节点大于当前节点，继续判断右节点
-   如果当前节点等于目标节点，那么如果有右节点，就返回右节点的最左节点，如果没有，就返回栈中最后一个元素



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def inorderSuccessor(self, root: 'TreeNode', p: 'TreeNode') -> 'TreeNode':
        cur = root
        stack = []
        while cur:
            if cur.val > p.val:
                stack.append(cur)
                cur = cur.left
            elif cur.val < p.val:
                cur = cur.right
            else:
                if cur.right:
                    temp = cur.right
                    while temp.left:
                        temp = temp.left
                    return temp
                else:
                    if stack:
                        return stack[-1]
                    else:
                        return None

        return None
```

