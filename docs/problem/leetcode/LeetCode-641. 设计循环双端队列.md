# LeetCode: 641. 设计循环双端队列

[TOC]

## 1、题目描述

设计实现双端队列。
你的实现需要支持以下操作：

- `MyCircularDeque(k)：`构造函数,双端队列的大小为`k`。
- `insertFront()：`将一个元素添加到双端队列头部。 如果操作成功返回 `true`。
- `insertLast()：`将一个元素添加到双端队列尾部。如果操作成功返回 `true`。
- `deleteFront()：`从双端队列头部删除一个元素。 如果操作成功返回 `true`。
- `deleteLast()：`从双端队列尾部删除一个元素。如果操作成功返回 `true`。
- `getFront()：`从双端队列头部获得一个元素。如果双端队列为空，返回 `-1`。
- `getRear()：`获得双端队列的最后一个元素。 如果双端队列为空，返回 `-1`。
- `isEmpty()：`检查双端队列是否为空。
- `isFull()：`检查双端队列是否满了。

**示例：**

```
MyCircularDeque circularDeque = new MycircularDeque(3); // 设置容量大小为3
circularDeque.insertLast(1);			        // 返回 true
circularDeque.insertLast(2);			        // 返回 true
circularDeque.insertFront(3);			        // 返回 true
circularDeque.insertFront(4);			        // 已经满了，返回 false
circularDeque.getRear();  				// 返回 2
circularDeque.isFull();				        // 返回 true
circularDeque.deleteLast();			        // 返回 true
circularDeque.insertFront(4);			        // 返回 true
circularDeque.getFront();				// 返回 4
```

 

**提示：**

- 所有值的范围为 `[1, 1000]`
- 操作次数的范围为 `[1, 1000]`
- 请不要使用内置的双端队列库。



## 2、解题思路

- 与双端队列同样的，额外处理队列首部索引值即可

```python
class MyCircularDeque:

    def __init__(self, k: int):
        """
        Initialize your data structure here. Set the size of the deque to be k.
        """
        self.q = [0] * k
        self.length = k
        self.data_length = 0
        self.start = 0
        self.end = 0

    def insertFront(self, value: int) -> bool:
        """
        Adds an item at the front of Deque. Return true if the operation is successful.
        """
        if self.data_length < self.length:
            self.start = (self.start + self.length - 1) % self.length
            self.q[self.start] = value
            self.data_length += 1
            return True
        return False

    def insertLast(self, value: int) -> bool:
        """
        Adds an item at the rear of Deque. Return true if the operation is successful.
        """
        if self.data_length < self.length:
            self.q[self.end] = value
            self.end = (self.end + 1) % self.length
            self.data_length += 1
            return True
        return False

    def deleteFront(self) -> bool:
        """
        Deletes an item from the front of Deque. Return true if the operation is successful.
        """
        if self.data_length > 0:
            self.start = (self.start + 1) % self.length
            self.data_length -= 1
            return True
        return False

    def deleteLast(self) -> bool:
        """
        Deletes an item from the rear of Deque. Return true if the operation is successful.
        """
        if self.data_length > 0:
            self.end = (self.end + self.length - 1) % self.length
            self.data_length -= 1
            return True
        return False

    def getFront(self) -> int:
        """
        Get the front item from the deque.
        """
        if self.data_length > 0:
            return self.q[self.start]
        return -1

    def getRear(self) -> int:
        """
        Get the last item from the deque.
        """
        if self.data_length > 0:
            return self.q[(self.end + self.length - 1) % self.length]
        return -1

    def isEmpty(self) -> bool:
        """
        Checks whether the circular deque is empty or not.
        """
        return self.data_length == 0

    def isFull(self) -> bool:
        """
        Checks whether the circular deque is full or not.
        """
        return self.data_length == self.length

# Your MyCircularDeque object will be instantiated and called as such:
# obj = MyCircularDeque(k)
# param_1 = obj.insertFront(value)
# param_2 = obj.insertLast(value)
# param_3 = obj.deleteFront()
# param_4 = obj.deleteLast()
# param_5 = obj.getFront()
# param_6 = obj.getRear()
# param_7 = obj.isEmpty()
# param_8 = obj.isFull()

```

