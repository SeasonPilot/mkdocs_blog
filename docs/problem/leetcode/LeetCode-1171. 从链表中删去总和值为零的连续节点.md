# LeetCode: 1171. 从链表中删去总和值为零的连续节点

[TOC]

## 1、题目描述

给你一个链表的头节点 `head`，请你编写代码，反复删去链表中由 总和 值为 `0` 的连续节点组成的序列，直到不存在这样的序列为止。

删除完毕后，请你返回最终结果链表的头节点。

 

你可以返回任何满足题目要求的答案。

（注意，下面示例中的所有序列，都是对 `ListNode` 对象序列化的表示。）

**示例 1：**

```
输入：head = [1,2,-3,3,1]
输出：[3,1]
提示：答案 [1,2,1] 也是正确的。
```


**示例 2：**

```
输入：head = [1,2,3,-3,4]
输出：[1,2,4]
```


**示例 3：**

```
输入：head = [1,2,3,-3,-2]
输出：[1]
```

**提示：**

- `给你的链表中可能有 1 到 1000 个节点。`
- `对于链表中的每个节点，节点的值：-1000 <= node.val <= 1000.`



## 2、解题思路

- 设计一个字典，保存当前位置的累计和，如果之前出现过当前值，那么这两个值之间的数据都可以删除
- 并且需要删除两个值之间的那些节点累积和
- 使用`OrderedDict`实现



```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def removeZeroSumSublists(self, head: ListNode) -> ListNode:
        from collections import OrderedDict
        res = ListNode(0)
        res.next = head

        accumulate = OrderedDict()
        accumulate[0] = res
        sums = 0
        temp = res.next

        while temp:
            sums += temp.val
            next_node = temp.next
            if sums in accumulate:

                accumulate[sums].next = temp.next
                while accumulate:
                    value, node = accumulate.popitem()
                    if value == sums:
                        accumulate[value] = node
                        break
            else:
                accumulate[sums] = temp
            temp = next_node

        return res.next
```

