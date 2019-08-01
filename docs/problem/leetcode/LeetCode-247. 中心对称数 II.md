# LeetCode: 247. 中心对称数 II

[TOC]

## 1、题目描述

中心对称数是指一个数字在旋转了 180 度之后看起来依旧相同的数字（或者上下颠倒地看）。

找到所有长度为 n 的中心对称数。

**示例 :**

```
输入:  n = 2
输出: ["11","69","88","96"]
```



## 2、解题思路

- 将数字对半分，并考虑中心数字（是否是奇数个数）
- 利用笛卡尔积找出所有可能性（第一位数不能为0）

- 处理中心位置数字
- 将左半部分的映射反序添加到右半边

```python
from itertools import product


class Solution:
    def findStrobogrammatic(self, n: int) -> [str]:

        mapping = {
            "0": "0",
            "1": "1",
            "6": "9",
            "8": "8",
            "9": "6",
        }

        side = ["0", "1", "6", "8", "9"]
        center = ["0", "1", "8"]
        res = []

        if not n:
            return []
        if n == 1:
            return center

        center_num = True if n % 2 else False
        side_nums = n // 2

        temp = []
        for i in product(side, repeat=side_nums):
            if i[0] != "0":
                temp.append("".join(i))

        for t in temp:
            if center_num:
                for c in center:
                    res.append(t + c + "".join(reversed([mapping[x] for x in t])))
            else:

                res.append(t + "".join(reversed([mapping[x] for x in t])))

        return res
```

