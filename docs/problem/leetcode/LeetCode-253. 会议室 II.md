# LeetCode: 253. 会议室 II

[TOC]

## 1、题目描述

给定一个会议时间安排的数组，每个会议时间都会包括开始和结束的时间 `[[s1,e1],[s2,e2],...] (si < ei)` ，为避免会议冲突，同时要考虑充分利用会议室资源，请你计算至少需要多少间会议室，才能满足这些会议安排。

```
示例 1:
输入: [[0, 30],[5, 10],[15, 20]]
输出: 2

示例 2:
输入: [[7,10],[2,4]]
输出: 1
```



## 2、解题思路

- 贪心算法
- 首先根据会议开始时间进行排序
- 然后找出会议开始时间最小的，接下来找出这个会议室最多安排多少会议，将这些会议进行标记
- 然后取出下一个未标记的最小开始会议，重新进行会议安排，直到所以会议都被标记



```python
class Solution:
    def minMeetingRooms(self, intervals: List[List[int]]) -> int:
        N = len(intervals)
        inter = sorted(intervals)
        visited = [False] * N

        if not inter:
            return 0

        nums = 0
        pre_x, pre_y = inter[0]

        while not all(visited):
            for index, i in enumerate(inter):
                if not visited[index]:
                    visited[index] = True
                    pre_x, pre_y = i
                    nums += 1
                    break

            for index, i in enumerate(inter):
                if not visited[index] and i[0] >= pre_y:
                    visited[index] = True
                    pre_x, pre_y = i

        return nums
```

