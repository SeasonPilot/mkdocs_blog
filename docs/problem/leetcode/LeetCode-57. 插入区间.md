# LeetCode: 57. 插入区间

[TOC]

## 1、题目描述

给出一个无重叠的 ，按照区间起始端点排序的区间列表。

在列表中插入一个新的区间，你需要确保列表中的区间仍然有序且不重叠（如果有必要的话，可以合并区间）。

**示例 1:**

```
输入: intervals = [[1,3],[6,9]], newInterval = [2,5]
输出: [[1,5],[6,9]]
```


**示例 2:**

```
输入: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
输出: [[1,2],[3,10],[12,16]]
解释: 这是因为新的区间 [4,8] 与 [3,5],[6,7],[8,10] 重叠。


```



## 2、解题思路

-   判断需要插入还是需要合并

-   采用二分查找找到对应的位置

    -   然后判断与前后区间是否有交叉，有交叉则进行合并
    -   无交叉直接插入

    

```python
from typing import List
import bisect


class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
        x, y = newInterval
        length = len(intervals)

        if not intervals:
            return [[x, y]]

        left = bisect.bisect_left(intervals, [x, x])
        if left == 0:
            if y < intervals[0][0]:
                return [[x, y]] + intervals
            start = min(x, intervals[left][0])

        elif left >= length:
            if x > intervals[left - 1][1]:
                return intervals + [[x, y]]
            left -= 1
            start = min(x, intervals[left][0])

        else:
            if x > intervals[left - 1][1] and y < intervals[left][0]:
                intervals.insert(left, [x, y])
                return intervals
            if x <= intervals[left - 1][1]:
                left -= 1
            start = min(x, intervals[left][0])

        if y < intervals[0][0]:
            return [[x, y]] + intervals

        if left and x > intervals[left - 1][1] and left < length - 1 and y < intervals[left][0]:
            intervals.insert(left, [x, y])
            return intervals

        right = left
        while right < length - 1 and y >= intervals[right + 1][0]:
            right += 1
        end = max(y, intervals[right][1])
        intervals[left:right + 1] = [[start, end]]

        return intervals
```

