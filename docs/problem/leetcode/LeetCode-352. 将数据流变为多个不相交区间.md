# LeetCode: 352. 将数据流变为多个不相交区间

[TOC]

## 1、题目描述

给定一个非负整数的数据流输入 `a1，a2，…，an，…，`将到目前为止看到的数字总结为不相交的区间列表。

例如，假设数据流中的整数为 `1，3，7，2，6，…，`每次的总结为：

```
[1, 1]
[1, 1], [3, 3]
[1, 1], [3, 3], [7, 7]
[1, 3], [7, 7]
[1, 3], [6, 7]
```

**进阶：**
如果有很多合并，并且与数据流的大小相比，不相交区间的数量很小，该怎么办?



## 2、解题思路

-   使用区间二分查找法

每次使用二分查找定位可能更新的位置，判断能否与前后位置合并



```python
import bisect


class SummaryRanges:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.data = []

    def addNum(self, val: int) -> None:
        index = bisect.bisect_left(self.data, [val, val])
        if index < len(self.data):
            max_interval = self.data[index]
            if index == 0:
                if val == max_interval[0] - 1:
                    self.data[index][0] = val
                elif val < max_interval[0] - 1:
                    self.data.insert(index, [val, val])
            else:
                min_interval = self.data[index - 1]
                if min_interval[1] + 1 < val < max_interval[0] - 1:
                    self.data.insert(index, [val, val])
                else:
                    if val == min_interval[1] + 1:
                        self.data[index - 1][1] = val
                    if val == max_interval[0] - 1:
                        self.data[index][0] = val
                    if self.data[index - 1][1] == self.data[index][0]:
                        self.data[index][0] = self.data[index - 1][0]
                        self.data.pop(index - 1)
        else:
            if not self.data or val > self.data[-1][1] + 1:

                self.data.append([val, val])
            elif val == self.data[-1][1] + 1:
                self.data[-1][1] = val
                
    def getIntervals(self) -> List[List[int]]:
        return self.data


# Your SummaryRanges object will be instantiated and called as such:
# obj = SummaryRanges()
# obj.addNum(val)
# param_2 = obj.getIntervals()
```

