# LeetCode: 295. 数据流的中位数

[TOC]

## 1、题目描述

中位数是有序列表中间的数。如果列表长度是偶数，中位数则是中间两个数的平均值。

**例如，**

```
[2,3,4] 的中位数是 3

[2,3] 的中位数是 (2 + 3) / 2 = 2.5

设计一个支持以下两种操作的数据结构：

void addNum(int num) - 从数据流中添加一个整数到数据结构中。
double findMedian() - 返回目前所有元素的中位数。
```

**示例：**

```
addNum(1)
addNum(2)
findMedian() -> 1.5
addNum(3) 
findMedian() -> 2
```



**进阶:**

- 如果数据流中所有整数都在 0 到 100 范围内，你将如何优化你的算法？
- 如果数据流中 99% 的整数都在 0 到 100 范围内，你将如何优化你的算法？

## 2、解题思路

- 建立一个最大堆和最小堆
- 令最小堆的长度与最大堆相等或者大1



```python
# python2

class MedianFinder(object):
    def __init__(self):
        """
        initialize your data structure here.
        """
        self.max_heap = []
        self.min_heap = []

    def addNum(self, num):

        if not self.min_heap:
            self.min_heap.append(num)
            return
        if not self.max_heap:
            if num <= self.min_heap[0]:
                self.max_heap.append(-num)
            else:
                self.max_heap.append(-self.min_heap.pop())
                self.min_heap.append(num)
            return

        if len(self.min_heap) == len(self.max_heap):
            if num >= -self.max_heap[0]:
                heapq.heappush(self.min_heap, num)
            else:
                heapq.heappush(self.min_heap, -heapq.heappop(self.max_heap))
                heapq.heappush(self.max_heap, -num)
        else:
            if num <= self.min_heap[0]:
                heapq.heappush(self.max_heap, -num)
            else:
                heapq.heappush(self.max_heap, - heapq.heappop(self.min_heap))
                heapq.heappush(self.min_heap, num)

    def findMedian(self):
        if len(self.min_heap) == len(self.max_heap):
            return float(self.min_heap[0] - self.max_heap[0]) / 2
        else:
            return self.min_heap[0]


# Your MedianFinder object will be instantiated and called as such:
# obj = MedianFinder()
# obj.addNum(num)
# param_2 = obj.findMedian()
```

```python
# python3
import heapq


class MedianFinder:

    def __init__(self):
        """
        initialize your data structure here.
        """
        self.max_heap = []
        self.min_heap = []

    def addNum(self, num: int) -> None:

        if not self.min_heap:
            self.min_heap.append(num)
            return
        if not self.max_heap:
            if num <= self.min_heap[0]:
                self.max_heap.append(-num)
            else:
                self.max_heap.append(-self.min_heap.pop())
                self.min_heap.append(num)
            return

        if len(self.min_heap) == len(self.max_heap):
            if num >= -self.max_heap[0]:
                heapq.heappush(self.min_heap, num)
            else:
                heapq.heappush(self.min_heap, -heapq.heappop(self.max_heap))
                heapq.heappush(self.max_heap, -num)
        else:
            if num <= self.min_heap[0]:
                heapq.heappush(self.max_heap, -num)
            else:
                heapq.heappush(self.max_heap, - heapq.heappop(self.min_heap))
                heapq.heappush(self.min_heap, num)

    def findMedian(self) -> float:

        if len(self.min_heap) == len(self.max_heap):
            return (self.min_heap[0] - self.max_heap[0]) / 2
        else:
            return self.min_heap[0]


# Your MedianFinder object will be instantiated and called as such:
# obj = MedianFinder()
# obj.addNum(num)
# param_2 = obj.findMedian()
```

