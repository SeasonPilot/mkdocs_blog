# LeetCode: 765. 情侣牵手

[TOC]

## 1、题目描述

N 对情侣坐在连续排列的 `2N` 个座位上，想要牵到对方的手。 计算最少交换座位的次数，以便每对情侣可以并肩坐在一起。 一次交换可选择任意两人，让他们站起来交换座位。

人和座位用 `0` 到 `2N-1` 的整数表示，情侣们按顺序编号，第一对是 `(0, 1)`，第二对是 `(2, 3)`，以此类推，最后一对是 `(2N-2, 2N-1)`。

这些情侣的初始座位  `row[i]` 是由最初始坐在第 `i` 个座位上的人决定的。

**示例 1:**

```
输入: row = [0, 2, 1, 3]
输出: 1
解释: 我们只需要交换row[1]和row[2]的位置即可。
```

**示例 2:**

```
输入: row = [3, 2, 0, 1]
输出: 0
解释: 无需交换座位，所有的情侣都已经可以手牵手了。
```


**说明:**

- `len(row) 是偶数且数值在 [4, 60]范围内。`
- `可以保证row 是序列 0...len(row)-1 的一个全排列。`

## 2、解题思路

- 并查集
- 使用并查集关键在于如何判断移动的次数

首先假设情侣在同一个集合中

如果有两队情侣做错了位置，那么就需要移动一次

如果有3对情侣相互坐错了位置，需要移动两次

- 将做错位置的情侣放入一个集合中

默认情况应该有N个集合，每一次少一个集合，表示有情侣坐错了位置，因此为：

`N - 集合数`



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def minSwapsCouples(self, row: [int]) -> int:
        length = len(row)
        d = DFU(length // 2)
        for i in range(0, length, 2):
            d.union(row[i] // 2, row[i + 1] // 2)

        return length // 2 - d.count()

```

