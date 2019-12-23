# LeetCode: 426. 将二叉搜索树转化为排序的双向链表

[TOC]

## 1、题目描述

将一个二叉搜索树就地转化为一个已排序的双向循环链表。可以将左右孩子指针作为双向循环链表的前驱和后继指针。

为了让您更好地理解问题，以下面的二叉搜索树为例：

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-23-061324.png" alt="img" style="zoom:50%;" />



 

我们希望将这个二叉搜索树转化为双向循环链表。链表中的每个节点都有一个前驱和后继指针。对于双向循环链表，第一个节点的前驱是最后一个节点，最后一个节点的后继是第一个节点。

下图展示了上面的二叉搜索树转化成的链表。“head” 表示指向链表中有最小元素的节点。

 

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-23-061331.png)

 

特别地，我们希望可以就地完成转换操作。当转化完成以后，树中节点的左指针需要指向前驱，树中节点的右指针需要指向后继。还需要返回链表中的第一个节点的指针。

下图显示了转化后的二叉搜索树，实线表示后继关系，虚线表示前驱关系。

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-23-061354.png" alt="img" style="zoom:67%;" />



## 2、解题思路

-   使用基于栈的中序遍历
-   首先创建一个`head`作为前驱节点
-   设置一个前驱结点`pre`，每次都是将前面的pre和当前节点进行左右链接
-   最后处理`head`与最后一个节点之间的链接即可



```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
"""
from collections import deque


class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        if not root:
            return root
        head = Node(-1)
        pre = head

        stack = deque()
        stack.append(root)
        while stack:
            while stack[-1].left:
                stack.append(stack[-1].left)
            while stack:
                current = stack.pop()
                current.left = pre
                pre.right = current
                pre = current
                # 操作
                if current.right:
                    stack.append(current.right)
                    break
        head.right.left = pre
        pre.right = head.right
        return head.right
```

