# LeetCode: 460. LFU缓存

[TOC]

## 1、题目描述

设计并实现[最不经常使用（LFU）](https://baike.baidu.com/item/缓存算法)缓存的数据结构。它应该支持以下操作：get 和 put。

-   `get(key)` - 如果键存在于缓存中，则获取键的值（总是正数），否则返回 -1。
-   `put(key, value)` - 如果键不存在，请设置或插入值。当缓存达到其容量时，它应该在插入新项目之前，使最不经常使用的项目无效。在此问题中，当存在平局（即两个或更多个键具有相同使用频率）时，最近最少使用的键将被去除。

**进阶：**

-   你是否可以在 `O(1)` 时间复杂度内执行两项操作？



**示例：**

```
LFUCache cache = new LFUCache( 2 /* capacity (缓存容量) */ );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // 返回 1
cache.put(3, 3);    // 去除 key 2
cache.get(2);       // 返回 -1 (未找到key 2)
cache.get(3);       // 返回 3
cache.put(4, 4);    // 去除 key 1
cache.get(1);       // 返回 -1 (未找到 key 1)
cache.get(3);       // 返回 3
cache.get(4);       // 返回 4
```



## 2、解题思路

-   使用哈希表存储节点所对应的值与访问次数
-   使用链表存储不同的访问次数对应的节点集合，同一个集合中按照先后顺序摆放，后来的放到后面
-   需要注意的是，如果是新的put更新已存在的值，更新以后，访问数量也要增加，相当于`更新值+访问一次`



```python
from collections import defaultdict, OrderedDict


class Node:
    def __init__(self, num, previous, forward):
        self.bucket_num = num
        self.previous = previous
        self.forward = forward
        self.values = OrderedDict()


class LFUCache:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.data_length = 0
        zero = Node(0, None, None)
        self.bucket = {0: zero}
        self.count = defaultdict(list)

    def get(self, key: int) -> int:
        if self.count[key]:
            cur_bucket_num = self.count[key][1]
            cur_bucket = self.bucket[cur_bucket_num]
            target_bucket_num = self.count[key][1] + 1

            self.count[key][1] += 1

            if target_bucket_num not in self.bucket:
                target_bucket = Node(target_bucket_num, cur_bucket, cur_bucket.forward)
                cur_bucket.forward = target_bucket
                if target_bucket.forward:
                    target_bucket.forward.previous = target_bucket
                self.bucket[target_bucket_num] = target_bucket
            else:
                target_bucket = self.bucket[target_bucket_num]

            target_bucket.values[key] = cur_bucket.values.pop(key)

            if not cur_bucket.values:
                self.bucket.pop(cur_bucket_num)
                target_bucket.previous = cur_bucket.previous
                cur_bucket.previous.forward = target_bucket

            return self.count[key][0]
        return -1

    def put(self, key: int, value: int) -> None:
        if self.capacity == 0:
            return
        if not self.count[key]:
            self.count[key] = [value, 1]
            cur_bucket = self.bucket[0]
            remove_bucket = cur_bucket.forward
            target_bucket_num = 1
            if target_bucket_num not in self.bucket:
                target_bucket = Node(target_bucket_num, cur_bucket, cur_bucket.forward)
                cur_bucket.forward = target_bucket
                if target_bucket.forward:
                    target_bucket.forward.previous = target_bucket
                self.bucket[target_bucket_num] = target_bucket
            else:
                target_bucket = self.bucket[target_bucket_num]

            if self.data_length < self.capacity:
                self.data_length += 1

            else:
                remove_key, remove_value = remove_bucket.values.popitem(last=False)
                self.count.pop(remove_key)
                if target_bucket != remove_bucket and not remove_bucket.values:
                    self.bucket.pop(remove_bucket.bucket_num)
                    remove_bucket.previous.forward = remove_bucket.forward
                    if remove_bucket.forward:
                        remove_bucket.forward.previous = remove_bucket.previous

            target_bucket.values[key] = value
        else:
            self.count[key][0] = value
            self.get(key)


# Your LFUCache object will be instantiated and called as such:
# obj = LFUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)

```

