# LeetCode: 970. 强整数

[TOC]

## 1、题目描述

给定两个正整数 x 和 y，如果某一整数等于  $x^i + y^j$ ，其中整数 $i >= 0$  且  $j >= 0$ ，那么我们认为该整数是一个强整数。

返回值小于或等于 bound 的所有强整数组成的列表。

你可以按任何顺序返回答案。在你的回答中，每个值最多出现一次。



**示例 1：**

```

输入：x = 2, y = 3, bound = 10
输出：[2,3,4,5,7,9,10]
解释： 
2 = 2^0 + 3^0
3 = 2^1 + 3^0
4 = 2^0 + 3^1
5 = 2^1 + 3^1
7 = 2^2 + 3^1
9 = 2^3 + 3^0
10 = 2^0 + 3^2
```

**示例 2：**

```
输入：x = 3, y = 5, bound = 15
输出：[2,4,6,8,10,14]
```


**提示：**

-  $1 <= x <= 100$ 

-  $1 <= y <= 100$ 

-  $0 <= bound <= 10^6$ 

## 2、解题思路

```python
from math import log
class Solution:
    def powerfulIntegers(self, x: int, y: int, bound: int) -> List[int]:
        res = set()
        power_x = int(log(bound, x)) if x != 1 else 1
        power_y = int(log(bound, y)) if y != 1 else 1
        for i in range(power_x + 1):
            for j in range(power_y + 1):
                temp = x ** i + y ** j
                if temp <= bound:
                    res.add(temp)

        return list(res)
```

