# LeetCode: 252. 会议室

[TOC]

## 1、题目描述



给定一个会议时间安排的数组，每个会议时间都会包括开始和结束的时间 [[s1,e1],[s2,e2],...] (si < ei)，请你判断一个人是否能够参加这里面的全部会议。

示例 1:

输入: [[0,30],[5,10],[15,20]]
输出: false
示例 2:

输入: [[7,10],[2,4]]
输出: true



## 2、解题思路

- 首先按照开始时间进行排序
- 然后依次开始查找，只要出现前面结束时间大于下一个的开始时间，就返回FALSE



```python
class Solution:
    def canAttendMeetings(self, intervals: List[List[int]]) -> bool:
        temp = sorted(intervals)

        if len(temp) <= 1:
            return True

        finish_time = temp[0][1]

        for meeting_time in temp[1:]:
            if finish_time > meeting_time[0]:
                return False
            finish_time = meeting_time[1]

        return True
```

