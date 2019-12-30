# LeetCode: 708. 循环有序列表的插入

[TOC]

## 1、题目描述

给定循环升序列表中的一个点，写一个函数向这个列表中插入一个新元素，使这个列表仍然是循环升序的。给定的可以是这个列表中任意一个顶点的指针，并不一定是这个列表中最小元素的指针。

如果有多个满足条件的插入位置，你可以选择任意一个位置插入新的值，插入后整个列表仍然保持有序。

如果列表为空（给定的节点是 `null`），你需要创建一个循环有序列表并返回这个点。否则。请返回原先给定的节点。

下面的例子可以帮你更好的理解这个问题：

 ![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-30-095340.jpg)



在上图中，有一个包含三个元素的循环有序列表，你获得值为 `3` 的节点的指针，我们需要向表中插入元素 `2`。

 ![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-30-095338.jpg)




新插入的节点应该在 `1` 和 `3` 之间，插入之后，整个列表如上图所示，最后返回节点 `3`。



## 2、解题思路

-   由于是递增序列，因此只有一个逆序对存在，找出这个逆序对，定位最大值与最小值
    -   如果插入值小于最小值或者大于等于最大值，将值插入到最大与最小中间
    -   从最小值开始查找，找到第一个不大于插入值的节点，将值插入到该点后面



```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val=None, next=None):
        self.val = val
        self.next = next
"""
class Solution:
    def insert(self, head: 'Node', insertVal: int) -> 'Node':
        if not head:
            ans = Node(insertVal)
            ans.next = ans
            return ans
        max_node = head
        min_node = head.next

        while min_node.val >= max_node.val and min_node != head:
            max_node, min_node = min_node, min_node.next

        insert_node = Node(insertVal)
        if insertVal < min_node.val or insertVal >= max_node.val:
            insert_node.next = min_node
            max_node.next = insert_node
        else:
            less_equal_node = min_node
            while less_equal_node != max_node and less_equal_node.next.val <= insertVal:
                less_equal_node = less_equal_node.next
            insert_node.next = less_equal_node.next
            less_equal_node.next = insert_node
        return head

```

