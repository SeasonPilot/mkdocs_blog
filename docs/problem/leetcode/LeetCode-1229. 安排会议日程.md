# LeetCode: 1229. 安排会议日程

[TOC]

## 1、题目描述

你是一名行政助理，手里有两位客户的空闲时间表：`slots1` 和 `slots2`，以及会议的预计持续时间 `duration`，请你为他们安排合适的会议时间。

「会议时间」是两位客户都有空参加，并且持续时间能够满足预计时间 `duration` 的 最早的时间间隔。

如果没有满足要求的会议时间，就请返回一个 空数组。

 

`「空闲时间」`的格式是 `[start, end]`，由开始时间 `start` 和结束时间 `end` 组成，表示从 `start` 开始，到 `end` 结束。 

题目保证数据有效：同一个人的空闲时间不会出现交叠的情况，也就是说，对于同一个人的两个空闲时间 `[start1, end1]` 和 `[start2, end2]`，要么 `start1 > end2`，要么 `start2 > end1`。

 

**示例 1：**

```
输入：slots1 = [[10,50],[60,120],[140,210]], slots2 = [[0,15],[60,70]], duration = 8
输出：[60,68]
```


**示例 2：**

```
输入：slots1 = [[10,50],[60,120],[140,210]], slots2 = [[0,15],[60,70]], duration = 12
输出：[]
```

**提示：**

-   `1 <= slots1.length, slots2.length <= 10^4`
-   `slots1[i].length, slots2[i].length == 2`
-   `slots1[i][0] < slots1[i][1]`
-   `slots2[i][0] < slots2[i][1]`
-   `0 <= slots1[i][j], slots2[i][j] <= 10^9`
-   `1 <= duration <= 10^6` 



## 2、解题思路

-   双指针法
-   判断两个区间交叉的地方是否满足条件，如果不满足，判断下面的条件
    -   如果区间1的右边界较大，将pos2增加
    -   如果区间2的右边界较大，将pos1增加
    -   如果右边界相同，将pos1和pos2增加

通过上面的条件进行指针右移，找出最早的时间安排



```python
class Solution:
    def minAvailableDuration(self, slots1: List[List[int]], slots2: List[List[int]], duration: int) -> List[int]:
        length1 = len(slots1)
        length2 = len(slots2)

        slots1.sort()
        slots2.sort()
        pos1 = 0
        pos2 = 0

        while pos1 < length1 and pos2 < length2:
            first = slots1[pos1]
            second = slots2[pos2]
            if min(first[1], second[1]) - max(first[0], second[0]) >= duration:
                return [max(first[0], second[0]), max(first[0], second[0]) + duration]
            else:
                if first[1] == second[1]:
                    pos1 += 1
                    pos2 += 1
                elif first[1] > second[1]:
                    pos2 += 1
                else:
                    pos1 += 1
        return []
```

