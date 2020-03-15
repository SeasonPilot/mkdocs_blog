# LeetCode: 1360. 日期之间隔几天

[TOC]

## 1、题目描述

请你编写一个程序来计算两个日期之间隔了多少天。

日期以字符串形式给出，格式为 `YYYY-MM-DD`，如示例所示。

**示例 1：**

```
输入：date1 = "2019-06-29", date2 = "2019-06-30"
输出：1
```

**示例 2：**

```
输入：date1 = "2020-01-15", date2 = "2019-12-31"
输出：15
```

**提示：**

-   给定的日期是 `1971` 年到 `2100` 年之间的有效日期。

## 2、解题思路

-   使用 datetime 转换成日期，然后计算两个日期之间的天数

```python
import datetime


class Solution:
    def daysBetweenDates(self, date1: str, date2: str) -> int:
        d1 = datetime.date(*list(map(int, date1.split("-"))))
        d2 = datetime.date(*list(map(int, date2.split("-"))))
        if d1 >= d2:
            return (d1-d2).days
        else:
            return (d2-d1).days
```

