# LeetCode: 362. 敲击计数器

[TOC]

## 1、题目描述

设计一个敲击计数器，使它可以统计在过去`5`分钟内被敲击次数。

每个函数会接收一个时间戳参数（以秒为单位），你可以假设最早的时间戳从`1`开始，且都是按照时间顺序对系统进行调用（即时间戳是单调递增）。

在同一时刻有可能会有多次敲击。

**示例:**

```
HitCounter counter = new HitCounter();

// 在时刻 1 敲击一次。
counter.hit(1);

// 在时刻 2 敲击一次。
counter.hit(2);

// 在时刻 3 敲击一次。
counter.hit(3);

// 在时刻 4 统计过去 5 分钟内的敲击次数, 函数返回 3 。
counter.getHits(4);

// 在时刻 300 敲击一次。
counter.hit(300);

// 在时刻 300 统计过去 5 分钟内的敲击次数，函数返回 4 。
counter.getHits(300);

// 在时刻 301 统计过去 5 分钟内的敲击次数，函数返回 3 。
counter.getHits(301); 
```

**进阶:**

-   如果每秒的敲击次数是一个很大的数字，你的计数器可以应对吗？



## 2、解题思路

- 双队列法
设置两个队列，最大长度为`301`
第一个队列存放时间戳
第二个存放时间戳的累计和

每次取的时候，使用二分查找，找出时间戳队列的两个索引，然后使用累积和相减的方式求值



```python
from collections import deque
import bisect


class HitCounter:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.timestamp = deque(maxlen=301)
        self.timestamp_accumulate = deque(maxlen=301)
        self.timestamp.append(0)
        self.timestamp_accumulate.append(0)

    def hit(self, timestamp: int) -> None:
        """
        Record a hit.
        @param timestamp - The current timestamp (in seconds granularity).
        """
        if timestamp == self.timestamp[-1]:
            self.timestamp_accumulate[-1] += 1
        else:
            self.timestamp.append(timestamp)
            self.timestamp_accumulate.append(self.timestamp_accumulate[-1] + 1)

    def getHits(self, timestamp: int) -> int:
        """
        Return the number of hits in the past 5 minutes.
        @param timestamp - The current timestamp (in seconds granularity).
        """
        right = bisect.bisect_right(self.timestamp, timestamp) - 1
        left = bisect.bisect_left(self.timestamp, timestamp - 299) - 1
        left_sum = self.timestamp_accumulate[left] if left >= 0 else 0
        right_sum = self.timestamp_accumulate[right] if right >= 0 else 0
        return right_sum - left_sum



# Your HitCounter object will be instantiated and called as such:
# obj = HitCounter()
# obj.hit(timestamp)
# param_2 = obj.getHits(timestamp)
```

