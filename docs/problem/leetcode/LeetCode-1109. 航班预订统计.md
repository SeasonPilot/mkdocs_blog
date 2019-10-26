# LeetCode: 1109. 航班预订统计

[TOC]

## 1、题目描述

这里有 `n` 个航班，它们分别从 `1` 到 `n` 进行编号。

我们这儿有一份航班预订表，表中第 i 条预订记录 `bookings[i] = [i, j, k]` 意味着我们在从 `i` 到 `j` 的每个航班上预订了 `k` 个座位。

请你返回一个长度为 `n` 的数组 `answer`，按航班编号顺序返回每个航班上预订的座位数。

 

**示例：**

```
输入：bookings = [[1,2,10],[2,3,20],[2,5,25]], n = 5
输出：[10,55,45,25,25]
```

**提示：**

-   $1 <= bookings.length <= 20000$
-   $1 <= bookings[i][0] <= bookings[i][1] <= n <= 20000$
-   $1 <= bookings[i][2] <= 10000$



## 2、解题思路

-   动态规划
-   将一段距离看成是上下车，一共有n站，看成求解某一站车上的人数是多少
-   首先更新每一站上车下车的人数，

```
[i, j, k]
[上车，下车，人数]
count 作为统计，公交车在某一站的上下车情况
count[i] += k
count[j+1]-=k

在i站上了k人
在j没有下车，j+1下车k人

```

-   最后从前向后更新即可，初始车上没有人

```
count[i] += count[i-1]
```

**实例代码：**

```python
class Solution:
    def corpFlightBookings(self, bookings: List[List[int]], n: int) -> List[int]:
        length = n
        count = [0] * (length + 2)

        for x, t, c in bookings:
            count[x] += c
            count[t + 1] -= c

        for i in range(1, length + 2):
            count[i] += count[i - 1]

        return count[1:-1]
```

