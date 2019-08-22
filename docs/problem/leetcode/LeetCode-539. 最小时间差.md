# LeetCode: 539. 最小时间差

[TOC]

## 1、题目描述

给定一个 24 小时制（小时:分钟）的时间列表，找出列表中任意两个时间的最小时间差并已分钟数表示。

**示例 1：**

```
输入: ["23:59","00:00"]
输出: 1
```

备注:**

- 列表中时间数在 2~20000 之间。

- 每个时间取值在 00:00~23:59 之间。

## 2、解题思路

- 将字符串转换成`0-1339`的分钟数的形式
- 排序，最低的间隔肯定出现在前后两个之间

```python
class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        target = sorted([int(t.split(":")[0]) * 60 + int(t.split(":")[1]) for t in timePoints])

        length = len(target)
        res = 1440
        for index, t in enumerate(target):
            pre = (index - 1 + length) % length
            nex = (index + 1) % length

            if target[pre] > t:
                temp1 = min(target[pre] - t, t + 1440 - target[pre])
            else:
                temp1 = min(t - target[pre], target[pre] + 1440 - t)
            if target[nex] > t:
                temp2 = min(target[nex] - t, t + 1440 - target[nex])
            else:
                temp2 = min(t - target[nex], target[nex] + 1440 - t)

            res = min(res, temp1, temp2)

        return res
```

