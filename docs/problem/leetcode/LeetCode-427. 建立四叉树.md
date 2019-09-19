# LeetCode: 427. 建立四叉树

[TOC]

## 1、题目描述

我们想要使用一棵四叉树来储存一个 N x N 的布尔值网络。网络中每一格的值只会是真或假。树的根结点代表整个网络。对于每个结点, 它将被分等成四个孩子结点直到这个区域内的值都是相同的.

每个结点还有另外两个布尔变量: isLeaf 和 val。isLeaf 当这个节点是一个叶子结点时为真。val 变量储存叶子结点所代表的区域的值。

你的任务是使用一个四叉树表示给定的网络。下面的例子将有助于你理解这个问题：

给定下面这个8 x 8 网络，我们将这样建立一个对应的四叉树：

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050656.png)

由上文的定义，它能被这样分割：

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050701.png)



 

对应的四叉树应该像下面这样，每个结点由一对 (isLeaf, val) 所代表.

对于非叶子结点，val 可以是任意的，所以使用 * 代替。

![](http://px3chmx10.bkt.clouddn.com/notebook/2019-09-19-050707.png)



**提示：**

- N 将小于 1000 且确保是 2 的整次幂。
- 如果你想了解更多关于四叉树的知识，你可以参考这个 wiki 页面。

## 2、解题思路

- 



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
    def construct(self, grid: [[int]]) -> 'Node':
        return self.dfs(grid, 0, len(grid), 0, len(grid))

    def dfs(self, grid, x1, x2, y1, y2):
        temp = self.judge_leaf(grid, x1, x2, y1, y2)
        if temp == 0:
            return Node(False, True, None, None, None, None)
        elif temp == 1:
            return Node(True, True, None, None, None, None)
        else:
            current_node = Node(True, False, None, None, None, None)
            current_node.topLeft = self.dfs(grid, x1, x1 + (x2 - x1) // 2, y1, y1 + (y2 - y1) // 2)
            current_node.topRight = self.dfs(grid, x1, x1 + (x2 - x1) // 2, y1 + (y2 - y1) // 2, y2)
            current_node.bottomLeft = self.dfs(grid, x1 + (x2 - x1) // 2, x2, y1, y1 + (y2 - y1) // 2)
            current_node.bottomRight = self.dfs(grid, x1 + (x2 - x1) // 2, x2, y1 + (y2 - y1) // 2, y2)
            return current_node

    def judge_leaf(self, grid, x1, x2, y1, y2):
        """

        :return: 0: all zero
                 1: all 1
                 2: zero and one
        """
        temp = sum([grid[x][y] for x in range(x1, x2) for y in range(y1, y2)])
        if temp == 0:
            return 0
        elif temp == (x2 - x1) * (y2 - y1):
            return 1
        return 2
```

