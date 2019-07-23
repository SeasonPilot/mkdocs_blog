# LeetCode: 1118. 一月有多少天

[TOC]

## 1、题目描述

指定年份 Y 和月份 M，请你帮忙计算出该月一共有多少天。

```
示例 1：
输入：Y = 1992, M = 7
输出：31

示例 2：
输入：Y = 2000, M = 2
输出：29

示例 3：
输入：Y = 1900, M = 2
输出：28

```

**提示：**

-  $1583 <= Y <= 2100$ 

-  $1 <= M <= 12$ 



## 2、解题思路

- 判断是否是闰年，对2月特殊处理

```python
class Solution:
    def numberOfDays(self, Y: int, M: int) -> int:
        months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        if (not Y %400) or (not Y % 4 and Y % 100)  and M == 2:
            return 29
        else:
            return months[M - 1]
```

