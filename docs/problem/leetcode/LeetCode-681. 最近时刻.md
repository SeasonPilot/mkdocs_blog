# LeetCode: 681. 最近时刻

[TOC]

## 1、题目描述

给定一个形如 `“HH:MM”` 表示的时刻，利用当前出现过的数字构造下一个距离当前时间最近的时刻。每个出现数字都可以被无限次使用。

你可以认为给定的字符串一定是合法的。例如，`“01:34”` 和 `“12:09”` 是合法的，`“1:34”` 和 `“12:9”` 是不合法的。

 

**样例 1:**

```
输入: "19:34"
输出: "19:39"
解释: 利用数字 1, 9, 3, 4 构造出来的最近时刻是 19:39，是 5 分钟之后。结果不是 19:33 因为这个时刻是 23 小时 59 分钟之后。
```

**样例 2:**

```
输入: "23:59"
输出: "22:22"
解释: 利用数字 2, 3, 5, 9 构造出来的最近时刻是 22:22。 答案一定是第二天的某一时刻，所以选择可构造的最小时刻。


```



## 2、解题思路

-   从当前时间向后寻找，每次增加一分钟，找到所有数字都出现的时刻为止



```python
class Solution:
    def nextClosestTime(self, time: str) -> str:
        nums = set(time)
        nums.remove(":")
        hour, minute = map(int, time.split(":"))

        def get_next_time(h, m):
            carry = (m + 1) // 60
            m = (m + 1) % 60
            h = (h + carry) % 24
            return h, m

        nh, nm = get_next_time(hour, minute)
        cur_nums = set(str(nh).zfill(2))
        cur_nums.update(set(str(nm).zfill(2)))
        flag = cur_nums.issubset(nums)
        while not flag:
            nh, nm = get_next_time(nh, nm)
            cur_nums = set(str(nh).zfill(2))
            cur_nums.update(set(str(nm).zfill(2)))
            flag = cur_nums.issubset(nums)

        return str(nh).zfill(2) + ":" + str(nm).zfill(2)

```

