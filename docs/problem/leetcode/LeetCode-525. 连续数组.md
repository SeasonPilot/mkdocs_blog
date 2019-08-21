# LeetCode: 525. 连续数组

[TOC]

## 1、题目描述

给定一个二进制数组, 找到含有相同数量的 0 和 1 的最长连续子数组（的长度）。

**示例 1:**

```
输入: [0,1]
输出: 2
说明: [0, 1] 是具有相同数量0和1的最长连续子数组。
```

**示例 2:**

```
输入: [0,1,0]
输出: 2
说明: [0, 1] (或 [1, 0]) 是具有相同数量0和1的最长连续子数组。
```



**注意:** 给定的二进制数组的长度不会超过50000。

## 2、解题思路

- 采用映射的思路
- 将当前位置的1的数量减去0的数量作为键，索引作为值
- 如果遇到键相同的，表示两个索引之间有相同数量的0，1



```python
class Solution:
    def findMaxLength(self, nums: List[int]) -> int:
        mapping = {0: -1}

        ones = 0
        zeros = 0

        res = 0
        for index, i in enumerate(nums):
            if i == 0:
                zeros += 1
            else:
                ones += 1

            temp = ones - zeros
            if temp in mapping:
                res = max(res, index - mapping[temp])
            else:
                mapping[temp] = index
        return res
```

