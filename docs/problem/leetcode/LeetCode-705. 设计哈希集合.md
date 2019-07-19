# LeetCode: 705. 设计哈希集合

[TOC]

## 1、题目描述

不使用任何内建的哈希表库设计一个哈希集合

具体地说，你的设计应该包含以下的功能

add(value)：向哈希集合中插入一个值。
contains(value) ：返回哈希集合中是否存在这个值。
remove(value)：将给定值从哈希集合中删除。如果哈希集合中没有这个值，什么也不做。

示例:

```
MyHashSet hashSet = new MyHashSet();
hashSet.add(1);         
hashSet.add(2);         
hashSet.contains(1);    // 返回 true
hashSet.contains(3);    // 返回 false (未找到)
hashSet.add(2);          
hashSet.contains(2);    // 返回 true
hashSet.remove(2);          
hashSet.contains(2);    // 返回  false (已经被删除)
```



**注意：**

- 所有的值都在 [1, 1000000]的范围内。

- 操作的总数目在[1, 10000]范围内。

- 不要使用内建的哈希集合库。



## 2、解题思路



```python
class Node:
    def __init__(self, existed, val, next_node):
        self.existed = existed
        self.val = val
        self.next_node = next_node

 
class MyHashSet:
    
    
    
    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.capacity = 100000
        self.pool = [Node(False, None, None) for _ in range(self.capacity)]

    def add(self, key: int) -> None:
        hash = key % self.capacity

        if self.pool[hash].existed:
            temp = self.pool[hash]
            while temp.next_node:
                if temp.val == key:
                    return
            if temp.val != key:
                node = Node(True, key, None)
                temp.next_node = node
            return

        else:
            self.pool[hash].existed = True
            self.pool[hash].val = key

    def remove(self, key: int) -> None:
        hash = key % self.capacity
        if not self.pool[hash].existed:
            return
        else:
            pre = None
            temp = self.pool[hash]
            while temp.next_node:
                if temp.val == key:
                    if not pre:
                        self.pool[hash] = temp.next_node
                    else:
                        pre.next_node = temp.next_node
                    return
                pre = temp
                temp = temp.next_node
            if temp.val == key:
                temp.existed = False

    def contains(self, key: int) -> bool:
        """
        Returns true if this set contains the specified element
        """
        hash = key % self.capacity

        if self.pool[hash].existed:
            temp = self.pool[hash]
            while temp.next_node:
                if temp.val == key:
                    return True
                temp = temp.next_node
            if temp.val == key:
                return True
            return False
        else:
            return False


# Your MyHashSet object will be instantiated and called as such:
# obj = MyHashSet()
# obj.add(key)
# obj.remove(key)
# param_3 = obj.contains(key)
```



