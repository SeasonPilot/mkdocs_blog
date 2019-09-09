# LeetCode: 1185. 一周中的第几天

[TOC]

## 1、题目描述

给你一个日期，请你设计一个算法来判断它是对应一周中的哪一天。

输入为三个整数：`day`、`month` 和 `year`，分别表示日、月、年。

您返回的结果必须是这几个值中的一个 `{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}`。

 

**示例 1：**

```
输入：day = 31, month = 8, year = 2019
输出："Saturday"
```


**示例 2：**

```
输入：day = 18, month = 7, year = 1999
输出："Sunday"
```


**示例 3：**

```
输入：day = 15, month = 8, year = 1993
输出："Sunday"
```

**提示：**

- 给出的日期一定是在 1971 到 2100 年之间的有效日期。



## 2、解题思路

- 直接计算出当前天数距离1971年1月1日（周五）的天数，然后`%7`，看剩余几天，然后在周五的基础上进行计算

```python
class Solution:
    def dayOfTheWeek(self, day: int, month: int, year: int) -> str:
        from itertools import accumulate
        import operator
        NORMAL_YEAR = 365
        LEAP_YEAR = 366
        week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        month_days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        monthes = list(accumulate(month_days, func=operator.add))

        def leap_year_judge(y):

            if (not y % 400) or (y % 100 and not y % 4):
                return True
            else:
                return False

        days = day
        if leap_year_judge(year) and month >= 3:
            days += monthes[month - 1] + 1
        else:
            days += monthes[month - 1]

        for start_year in range(1971, year):
            if leap_year_judge(start_year):
                days += LEAP_YEAR
            else:
                days += NORMAL_YEAR

        # 1971年1月1日是周5，在数组中的位置是第5个
        return week[((days - 1) % 7 + 5) % 7]
```

