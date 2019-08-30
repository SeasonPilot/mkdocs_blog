# LeetCode: 128. 最长连续序列

[TOC]

## 1、题目描述

给定一个未排序的整数数组，找出最长连续序列的长度。

要求算法的时间复杂度为 `O(n)`。

**示例:**

```
输入: [100, 4, 200, 1, 3, 2]
输出: 4
解释: 最长连续序列是 [1, 2, 3, 4]。它的长度为 4。
```



## 2、解题思路

- 使用并查集
- 首先将数组去重并映射为相应的索引值
- 每一次遇到一个数前后值存在，就将对应索引值进行更新
- 并查集需要同时保存集合中元素的数量



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))
        self.size = [1] * length

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            if self.size[xp] > self.size[yp]:
                self.size[xp] += self.size[yp]
                self.data[yp] = xp
            else:
                self.size[yp] += self.size[xp]
                self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def longestConsecutive(self, nums: [int]) -> int:
        if not nums:
            return 0
        res = 0
        num_mapping = {}
        pos = 0
        for value in nums:
            if value not in num_mapping:
                num_mapping[value] = pos
                pos += 1

        d = DFU(pos)
        for key, value in num_mapping.items():
            if key - 1 in num_mapping:
                d.union(value, num_mapping[key - 1])
            if key + 1 in num_mapping:
                d.union(value, num_mapping[key + 1])

            res = max(res, d.size[d.find(value)])
        return res
```

