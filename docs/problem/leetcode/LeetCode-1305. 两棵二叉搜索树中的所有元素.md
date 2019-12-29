# LeetCode: 1305. 两棵二叉搜索树中的所有元素

[TOC]

## 1、题目描述

给你 `root1` 和 `root2` 这两棵二叉搜索树。

请你返回一个列表，其中包含 **两棵树** 中的所有整数并按 **升序** 排序。.

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-29-070840.png)

```
输入：root1 = [2,1,4], root2 = [1,0,3]
输出：[0,1,1,2,3,4]
```


**示例 2：**

```
输入：root1 = [0,-10,10], root2 = [5,1,7,0,2]
输出：[-10,0,0,1,2,5,7,10]
```


**示例 3：**

```
输入：root1 = [], root2 = [5,1,7,0,2]
输出：[0,1,2,5,7]
```

**示例 4：**

```
输入：root1 = [0,-10,10], root2 = []
输出：[-10,0,10]
```


**示例 5：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-29-070851.png)

```
输入：root1 = [1,null,8], root2 = [8,1]
输出：[1,1,8,8]
```

**提示：**

-   每棵树最多有 `5000` 个节点。
-   每个节点的值在 `[-10^5, 10^5]` 之间。



## 2、解题思路

-   中序遍历取出所有数字，排序输出(也可以归并输出，已经排好序)



```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
from collections import deque


class Solution:
    def getAllElements(self, root1: TreeNode, root2: TreeNode) -> List[int]:

        ans = []

        def inorder_stack(root: TreeNode):
            nonlocal ans
            if not root:
                return
            stack = deque()
            stack.append(root)
            while stack:
                while stack[-1].left:
                    stack.append(stack[-1].left)

                while stack:

                    current = stack.pop()
                    # 操作
                    ans.append(current.val)
                    if current.right:
                        stack.append(current.right)
                        break

        inorder_stack(root1)
        inorder_stack(root2)
        return sorted(ans)
```

