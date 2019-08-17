# LeetCode: 528. 按权重随机选择

[TOC]

## 1、题目描述

给定一个正整数数组 `w` ，其中 `w[i]` 代表位置` i` 的权重，请写一个函数 `pickIndex` ，它可以随机地获取位置 `i`，选取位置 `i` 的概率与 `w[i]` 成正比。

**说明:**

-  $1 <= w.length <= 10000$ 
-  $1 <= w[i] <= 10^5$ 
-  `pickIndex` 将被调用不超过  `10000` 次

**示例1:**

```
输入: 
["Solution","pickIndex"]
[[[1]],[]]
输出: [null,0]
```



**示例2:**

```
输入: 
["Solution","pickIndex","pickIndex","pickIndex","pickIndex","pickIndex"]
[[[1,3]],[],[],[],[],[]]
输出: [null,0,1,1,1,0]
```

**输入语法说明：**

- 输入是两个列表：调用成员函数名和调用的参数。`Solution` 的构造函数有一个参数，即数组 `w`。`pickIndex` 没有参数。输入参数是一个列表，即使参数为空，也会输入一个 `[]` 空列表。

## 2、解题思路

- 将权重转化为长度，变成数轴上的一段不同的长度
- 然后在这段距离中随机取点，落到哪个区间则使用哪个索引

> 与497题相似

```python
import random
import bisect


class Solution:

    def __init__(self, w: List[int]):
        self.weight = []
        s = 0

        for i in w:
            s += i
            self.weight.append(s)

    def pickIndex(self) -> int:
        return bisect.bisect_left(self.weight, random.randint(1, self.weight[-1]))

# Your Solution object will be instantiated and called as such:
# obj = Solution(w)
# param_1 = obj.pickIndex()

```

