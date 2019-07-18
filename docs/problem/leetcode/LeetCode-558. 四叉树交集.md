# LeetCode: 558. 四叉树交集

[TOC]

## 1、题目描述

四叉树是一种树数据，其中每个结点恰好有四个子结点：topLeft、topRight、bottomLeft 和 bottomRight。四叉树通常被用来划分一个二维空间，递归地将其细分为四个象限或区域。

我们希望在四叉树中存储 True/False 信息。四叉树用来表示 N * N 的布尔网格。对于每个结点, 它将被等分成四个孩子结点直到这个区域内的值都是相同的。每个节点都有另外两个布尔属性：isLeaf 和 val。当这个节点是一个叶子结点时 isLeaf 为真。val 变量储存叶子结点所代表的区域的值。

例如，下面是两个四叉树 A 和 B：

```
A:
+-------+-------+   T: true
|       |       |   F: false
|   T   |   T   |
|       |       |
+-------+-------+
|       |       |
|   F   |   F   |
|       |       |
+-------+-------+
topLeft: T
topRight: T
bottomLeft: F
bottomRight: F

B:               
+-------+---+---+
|       | F | F |
|   T   +---+---+
|       | T | T |
+-------+---+---+
|       |       |
|   T   |   F   |
|       |       |
+-------+-------+
topLeft: T
topRight:
     topLeft: F
     topRight: F
     bottomLeft: T
     bottomRight: T
bottomLeft: T
bottomRight: F
```



你的任务是实现一个函数，该函数根据两个四叉树返回表示这两个四叉树的逻辑或(或并)的四叉树。

```

A:                 B:                 C (A or B):
+-------+-------+  +-------+---+---+  +-------+-------+
|       |       |  |       | F | F |  |       |       |
|   T   |   T   |  |   T   +---+---+  |   T   |   T   |
|       |       |  |       | T | T |  |       |       |
+-------+-------+  +-------+---+---+  +-------+-------+
|       |       |  |       |       |  |       |       |
|   F   |   F   |  |   T   |   F   |  |   T   |   F   |
|       |       |  |       |       |  |       |       |
+-------+-------+  +-------+-------+  +-------+-------+
```

提示：

- A 和 B 都表示大小为 N * N 的网格。
- N 将确保是 2 的整次幂。
- 如果你想了解更多关于四叉树的知识，你可以参考这个 wiki 页面。
- 逻辑或的定义如下：如果 A 为 True ，或者 B 为 True ，或者 A 和 B 都为 True，则 "A 或 B" 为 True。
- 

## 2、解题思路

四叉树合并的关键点在于理解两个区域是否能够合并

有下面几种情况：

- A，B都是叶子，返回结果为或的结果
- A为叶子，B不为叶子，判断A是否为真，若为真，则该区域将被覆盖为真，返回A
- B为叶子，A不为叶子，判断B是否为真，若为真，则该区域将被覆盖为真，返回B
- A，B都不为叶子，使用四叉树重复上面的判断

```python
"""
# Definition for a QuadTree node.
class Node:
    def __init__(self, val, isLeaf, topLeft, topRight, bottomLeft, bottomRight):
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
"""
class Solution:
    def intersect(self, quadTree1: 'Node', quadTree2: 'Node') -> 'Node':
        # 判断是否存在一个叶子节点

        if quadTree1.isLeaf:
            if quadTree1.val:
                return quadTree1
            else:
                return quadTree2

        if quadTree2.isLeaf:
            if quadTree2.val:
                return quadTree2
            else:
                return quadTree1

        topLeft = self.intersect(quadTree1.topLeft, quadTree2.topLeft)
        topRight = self.intersect(quadTree1.topRight, quadTree2.topRight)
        bottomLeft = self.intersect(quadTree1.bottomLeft, quadTree2.bottomLeft)
        bottomRight = self.intersect(quadTree1.bottomRight, quadTree2.bottomRight)

        # 如果返回的结果都为叶子，并且都为真，那么这个区域能够被合并为真
        if topLeft.isLeaf and topRight.isLeaf and bottomLeft.isLeaf and bottomRight.isLeaf:
            if topLeft.val and topRight.val and bottomLeft.val and bottomRight.val:
                return Node(True, True, None, None, None, None)

        return Node(False, False, topLeft, topRight, bottomLeft, bottomRight)
```





