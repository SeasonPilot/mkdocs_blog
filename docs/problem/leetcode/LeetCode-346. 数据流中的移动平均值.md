# LeetCode: 346. 数据流中的移动平均值

[TOC]

## 1、题目描述

给定一个整数数据流和一个窗口大小，根据该滑动窗口的大小，计算其所有整数的移动平均值。

示例:

```
MovingAverage m = new MovingAverage(3);
m.next(1) = 1
m.next(10) = (1 + 10) / 2
m.next(3) = (1 + 10 + 3) / 3
m.next(5) = (10 + 3 + 5) / 3
```



## 2、解题思路

- 首先需要一个容器，存放新的数据
- 然后每次增加新的数据的时候，就会替换老数据，并且返回平均值



```python
class MovingAverage:

    def __init__(self, size: int):
        """
        Initialize your data structure here.
        """
        self.data = []
        self.pos = 0
        self.length = size

    def next(self, val: int) -> float:
        res = 0
        if len(self.data) < self.length:
            self.data.append(val)
            res = sum(self.data) / len(self.data)
        else:
            self.data[self.pos] = val
            res = sum(self.data) / self.length

        self.pos = (self.pos + 1) % self.length
        return res
    
# Your MovingAverage object will be instantiated and called as such:
# obj = MovingAverage(size)
# param_1 = obj.next(val)

```

