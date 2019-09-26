# LeetCode: 432. 全 O(1) 的数据结构

[TOC]

## 1、题目描述

实现一个数据结构支持以下操作：

1.  `Inc(key)` - 插入一个新的值为 `1` 的 `key`。或者使一个存在的 `key` 增加一，保证 `key` 不为空字符串。
2.  `Dec(key)` - 如果这个 `key` 的值是 `1`，那么把他从数据结构中移除掉。否者使一个存在的 `key` 值减一。如果这个 key 不存在，这个函数不做任何事情。`key` 保证不为空字符串。
3.  `GetMaxKey()` - 返回 `key` 中值最大的任意一个。如果没有元素存在，返回一个空字符串`""`。
4.  `GetMinKey()` - 返回 `key` 中值最小的任意一个。如果没有元素存在，返回一个空字符串`""`。

**挑战：**以 `O(1)` 的时间复杂度实现所有操作。



## 2、解题思路

-   双字典加链表
-   使用字典存储每个桶以及每个元素的数量
-   使用链表维护桶的大小关系，在$O(1)$时间找到对应的元素



```python
from collections import defaultdict


class Node:
    def __init__(self, previous, forward):
        self.previous = previous
        self.forward = forward
        self.values = set()


class AllOne:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.key_count = defaultdict(int)
        zero_bucket = Node(None, None)
        self.bucket = {0: zero_bucket}
        self.tail = self.head = zero_bucket

    def inc(self, key: str) -> None:
        """
        Inserts a new key <Key> with value 1. Or increments an existing key by 1.
        """
        bucket = self.bucket[self.key_count[key]]
        if self.key_count[key] != 0:
            bucket.values.remove(key)

        target_bucket = self.key_count[key] + 1
        self.key_count[key] += 1
        if target_bucket not in self.bucket:
            self.bucket[target_bucket] = Node(bucket, bucket.forward)
            if bucket.forward:
                bucket.forward.previous = self.bucket[target_bucket]
            bucket.forward = self.bucket[target_bucket]

            # 判断是否需要更新尾指针
            if self.tail == self.bucket[self.key_count[key] - 1]:
                self.tail = self.bucket[self.key_count[key]]

        if bucket != self.head:
            if not bucket.values:
                self.bucket.pop(self.key_count[key] - 1)
                bucket.previous.forward = bucket.forward
                bucket.forward.previous = bucket.previous

        self.bucket[target_bucket].values.add(key)

    def dec(self, key: str) -> None:
        """
        Decrements an existing key by 1. If Key's value is 1, remove it from the data structure.
        """
        if self.key_count[key] > 0:
            bucket = self.bucket[self.key_count[key]]
            bucket.values.remove(key)

            self.key_count[key] -= 1

            if self.key_count[key] > 0:
                target_bucket_num = self.key_count[key]
                if target_bucket_num not in self.bucket:
                    self.bucket[target_bucket_num] = Node(bucket.previous, bucket)
                    bucket.previous.forward = self.bucket[target_bucket_num]
                    bucket.previous = self.bucket[target_bucket_num]

                self.bucket[target_bucket_num].values.add(key)

            if not bucket.values:
                bucket.previous.forward = bucket.forward
                if bucket.forward:
                    bucket.forward.previous = bucket.previous
                self.bucket.pop(self.key_count[key] + 1)
                if self.tail == bucket:
                    self.tail = bucket.previous

    def getMaxKey(self) -> str:
        """
        Returns one of the keys with maximal value.
        """
        res = ""
        if self.tail.values:
            res = self.tail.values.pop()
            self.tail.values.add(res)
        return res

    def getMinKey(self) -> str:
        """
        Returns one of the keys with Minimal value.
        """
        res = ""
        bucket = self.head.forward
        if bucket:
            res = bucket.values.pop()
            bucket.values.add(res)
        return res


# Your AllOne object will be instantiated and called as such:
# obj = AllOne()
# obj.inc(key)
# obj.dec(key)
# param_3 = obj.getMaxKey()
# param_4 = obj.getMinKey()

```

