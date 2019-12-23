# LeetCode: 369. 给单链表加一

[TOC]

## 1、题目描述

用一个 非空 单链表来表示一个非负整数，然后将这个整数加一。

你可以假设这个整数除了 `0` 本身，没有任何前导的 `0`。

这个整数的各个数位按照 高位在链表头部、低位在链表尾部 的顺序排列。

**示例:**

```
输入: [1,2,3]
输出: [1,2,4]


```



## 2、解题思路

借助栈，从后向前进行进位加法，如果没有进位，可直接退出
如果最前面有进位，增加一个元素即可

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def plusOne(self, head: ListNode) -> ListNode:
        stack = []
        pre = ListNode(0)
        pre.next = head
        while head:
            stack.append(head)
            head = head.next
        carry = 0
        cur = stack.pop()
        carry = (cur.val + 1) // 10
        cur.val = (cur.val + 1) % 10
        while stack and carry:
            cur = stack.pop()
            carry = (cur.val + 1) // 10
            cur.val = (cur.val + 1) % 10
        if carry:
            pre.val += 1
            return pre
        else:
            return pre.next
```

