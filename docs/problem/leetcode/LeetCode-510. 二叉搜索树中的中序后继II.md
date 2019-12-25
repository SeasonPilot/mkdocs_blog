# LeetCode: 510. 二叉搜索树中的中序后继II

[TOC]

## 1、题目描述

给定一棵二叉搜索树和其中的一个节点，找到该节点在树中的中序后继。

一个结点 `p` 的中序后继是键值比 `p.val`大所有的结点中键值最小的那个。

你可以直接访问结点，但无法直接访问树。每个节点都会有其父节点的引用。

 

**示例 1:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-25-032123.png)

```
输入: 
root = {"$id":"1","left":{"$id":"2","left":null,"parent":{"$ref":"1"},"right":null,"val":1},"parent":null,"right":{"$id":"3","left":null,"parent":{"$ref":"1"},"right":null,"val":3},"val":2}
p = 1
输出: 2
解析: 1的中序后继结点是2。注意p和返回值都是Node类型的。
```


**示例 2:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-25-032131.png)

```
输入: 
root = {"$id":"1","left":{"$id":"2","left":{"$id":"3","left":{"$id":"4","left":null,"parent":{"$ref":"3"},"right":null,"val":1},"parent":{"$ref":"2"},"right":null,"val":2},"parent":{"$ref":"1"},"right":{"$id":"5","left":null,"parent":{"$ref":"2"},"right":null,"val":4},"val":3},"parent":null,"right":{"$id":"6","left":null,"parent":{"$ref":"1"},"right":null,"val":6},"val":5}
p = 6
输出: null
解析: 该结点没有中序后继，因此返回null。
```


**示例 3:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-25-032144.png)

```
输入: 
root = {"$id":"1","left":{"$id":"2","left":{"$id":"3","left":{"$id":"4","left":null,"parent":{"$ref":"3"},"right":null,"val":2},"parent":{"$ref":"2"},"right":{"$id":"5","left":null,"parent":{"$ref":"3"},"right":null,"val":4},"val":3},"parent":{"$ref":"1"},"right":{"$id":"6","left":null,"parent":{"$ref":"2"},"right":{"$id":"7","left":{"$id":"8","left":null,"parent":{"$ref":"7"},"right":null,"val":9},"parent":{"$ref":"6"},"right":null,"val":13},"val":7},"val":6},"parent":null,"right":{"$id":"9","left":{"$id":"10","left":null,"parent":{"$ref":"9"},"right":null,"val":17},"parent":{"$ref":"1"},"right":{"$id":"11","left":null,"parent":{"$ref":"9"},"right":null,"val":20},"val":18},"val":15}
p = 15
输出: 17
```

**示例 4:**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-25-032157.png)

**输入:** 

```
root = {"$id":"1","left":{"$id":"2","left":{"$id":"3","left":{"$id":"4","left":null,"parent":{"$ref":"3"},"right":null,"val":2},"parent":{"$ref":"2"},"right":{"$id":"5","left":null,"parent":{"$ref":"3"},"right":null,"val":4},"val":3},"parent":{"$ref":"1"},"right":{"$id":"6","left":null,"parent":{"$ref":"2"},"right":{"$id":"7","left":{"$id":"8","left":null,"parent":{"$ref":"7"},"right":null,"val":9},"parent":{"$ref":"6"},"right":null,"val":13},"val":7},"val":6},"parent":null,"right":{"$id":"9","left":{"$id":"10","left":null,"parent":{"$ref":"9"},"right":null,"val":17},"parent":{"$ref":"1"},"right":{"$id":"11","left":null,"parent":{"$ref":"9"},"right":null,"val":20},"val":18},"val":15}
p = 13
输出: 15
```

**注意:**

-   如果给定结点不存在中序后继，返回`null`。
-   树中各结点的值均保证唯一。
-   注意我们使用的是`Node`类型而不是`TreeNode`类型，它们的字符串表示不一样。



**延伸:**

-   你能否在不访问任何结点的值的情况下解决问题?



## 2、解题思路

-   比当前节点大的首先判断右节点，如果存在右节点，就找到右节点的最左节点
-   如果没有右节点，就到父节点中查找第一个大于当前节点值的节点

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, left, right, parent):
        self.val = val
        self.left = left
        self.right = right
        self.parent = parent
"""
class Solution:
    def inorderSuccessor(self, node: 'Node') -> 'Node':
        ans = None
        if node.right:
            ans = node.right
            while ans.left:
                ans = ans.left
        else:
            temp = node
            while temp and temp.val <= node.val:
                temp = temp.parent
            ans = temp

        return ans
```



-   拓展

通过判断当前节点是父节点的左节点还是右节点，记性向上回溯，找到第一个是父节点左节点的，返回其父节点即可



```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, left, right, parent):
        self.val = val
        self.left = left
        self.right = right
        self.parent = parent
"""
class Solution:
    def inorderSuccessor(self, node: 'Node') -> 'Node':
        ans = None
        if node.right:
            ans = node.right
            while ans.left:
                ans = ans.left
        else:
            temp = node
            while temp.parent and temp.parent.right == temp:
                temp = temp.parent
            ans = temp.parent
        return ans

```

