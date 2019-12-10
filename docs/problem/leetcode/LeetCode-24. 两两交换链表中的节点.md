# LeetCode: 24. 两两交换链表中的节点

[TOC]



## 1、题目描述



给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。

**示例:**

```
给定 1->2->3->4, 你应该返回 2->1->4->3.
```

**说明:**

- 你的算法只能使用常数的额外空间。
- **你不能只是单纯的改变节点内部的值**，而是需要实际的进行节点交换。



## 2、解题思路

​	设置3个指针，

​	指向第一个，第二个，第三个节点，然后第一个节点指向第三个节点，第二个节点指向第一个节点，然后向后移动



​	直接用递归来做，很简单

​	

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def swapPairs(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """

        
        result = self.swap(head)

        return result

    def swap(self, current):
        if current:
            second = current.next
            if second:
                third = second.next
                prev = second
                second.next = current
                current.next = self.swap(third)
                return second

            else:
                return current
        else:
            return current

```



-   效率更高的版本

首先我们做一下分析，如果我们有一个前驱结点，想要把这个节点之后的两个节点交换位置，如何做呢？

```
1 -> 2 -> 3 -> 4

如果想要将前驱结点之后的两个节点2，3交换位置，
1 -> 3 -> 2 -> 4

实际上就是改变1，2，3 这三个节点的指针即可
1 -> 3
2 -> 4
3 -> 2

```

利用python的特性，可以使用一行代码实现：

```python
# pre                   => 1
# pre.next              => 2
# pre.next.next         => 3
# pre.next.next.next    => 4
pre.next,pre.next.next,pre.next.next.next = pre.next.next,pre.next,pre.next.next.next
```

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def swapPairs(self, head: ListNode) -> ListNode:
        
        pre = ListNode(0)
        pre.next = head
        ans = pre
        while pre.next and pre.next.next:
            pre.next,pre.next.next,pre.next.next.next = pre.next.next,pre.next,pre.next.next.next
            pre = pre.next.next
            
        return ans.next
```

