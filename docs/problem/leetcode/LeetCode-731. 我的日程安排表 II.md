# LeetCode: 731. 我的日程安排表 II

[TOC]

## 1、题目描述

实现一个 `MyCalendar` 类来存放你的日程安排。如果要添加的时间内不会导致三重预订时，则可以存储这个新的日程安排。

`MyCalendar` 有一个 `book(int start, int end)`方法。它意味着在 `start` 到 `end` 时间内增加一个日程安排，注意，这里的时间是半开区间，即 `[start, end)`, 实数 `x` 的范围为，  `start <= x < end`。

当三个日程安排有一些时间上的交叉时（例如三个日程安排都在同一时间内），就会产生三重预订。

每次调用 `MyCalendar.book`方法时，如果可以将日程安排成功添加到日历中而不会导致三重预订，返回 `true`。否则，返回 `false` 并且不要将该日程安排添加到日历中。

请按照以下步骤调用`MyCalendar` 类: `MyCalendar cal = new MyCalendar(); MyCalendar.book(start, end)`

 

**示例：**

```
MyCalendar();
MyCalendar.book(10, 20); // returns true
MyCalendar.book(50, 60); // returns true
MyCalendar.book(10, 40); // returns true
MyCalendar.book(5, 15); // returns false
MyCalendar.book(5, 10); // returns true
MyCalendar.book(25, 55); // returns true
解释： 
前两个日程安排可以添加至日历中。 第三个日程安排会导致双重预订，但可以添加至日历中。
第四个日程安排活动（5,15）不能添加至日历中，因为它会导致三重预订。
第五个日程安排（5,10）可以添加至日历中，因为它未使用已经双重预订的时间10。
第六个日程安排（25,55）可以添加至日历中，因为时间 [25,40] 将和第三个日程安排双重预订；
时间 [40,50] 将单独预订，时间 [50,55）将和第二个日程安排双重预订。
```

**提示：**

-   `每个测试用例，调用 MyCalendar.book 函数最多不超过 1000次。`
-   `调用函数 MyCalendar.book(start, end)时， start 和 end 的取值范围为 [0, 10^9]。`



## 2、解题思路

-   双数组记录+二分查找

```
设置两个数组，分别记录出现一次的范围以及出现两次的范围

判断流程：
- 判断当前范围是否在出现2次的数组中有交叉，有交叉则返回False
- 没有交叉
    - 更新出现一次的数组
    - 将在一次数组中重复出现的范围更新在出现两次的数组
```

>    这里为了查询方便，出现一次的范围分别保存了首部和尾部



```python
from bisect import bisect_right


class MyCalendarTwo:

    def __init__(self):
        self.first_starts = []
        self.first_ends = []
        self.second_starts = []
        self.second_ends = []

    def update_first(self, start, end):

        first_index = bisect_right(self.first_starts, end)
        temp_index = first_index - 1
        if first_index == 0 or self.first_ends[temp_index] < start:
            self.first_starts.insert(first_index, start)
            self.first_ends.insert(first_index, end)
        else:
            overlap_left = max(start, self.first_starts[temp_index])
            overlap_right = min(end, self.first_ends[temp_index])
            self.update_second(overlap_left, overlap_right)
            if end > overlap_right:
                self.first_ends[temp_index] = end

            if overlap_left - 1 >= start:
                self.update_first(start, overlap_left - 1)

    def update_second(self, start, end):
        second_index = bisect_right(self.second_starts, end)
        if second_index == 0 or self.second_ends[second_index - 1] < start:
            self.second_starts.insert(second_index, start)
            self.second_ends.insert(second_index, end)
        else:
            if end > self.second_ends[second_index - 1]:
                self.second_ends[second_index - 1] = end

            if start < self.second_starts[second_index - 1]:
                self.update_second(start, self.second_starts[second_index - 1] - 1)

    def book(self, start: int, end: int) -> bool:
        end = end - 1

        second_index = bisect_right(self.second_starts, end)
        if second_index > 0 and self.second_ends[second_index - 1] >= start:
            return False

        first_index = bisect_right(self.first_starts, end)

        if first_index == 0 or self.first_ends[first_index - 1] < start:
            self.first_starts.insert(first_index, start)
            self.first_ends.insert(first_index, end)
        else:
            self.update_first(start, end)

        return True


# Your MyCalendarTwo object will be instantiated and called as such:
# param_1 = obj.book(start,end)
# obj = MyCalendarTwo()

```



