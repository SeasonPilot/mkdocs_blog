# LeetCode: 493. 翻转对

[TOC]

## 1、题目描述

给定一个数组 `nums` ，如果 `i < j` 且 `nums[i] > 2*nums[j]` 我们就将 `(i, j)` 称作一个重要翻转对。

你需要返回给定数组中的重要翻转对的数量。

**示例 1:**

```
输入: [1,3,2,3,1]
输出: 2
```


**示例 2:**

```
输入: [2,4,3,5,1]
输出: 3
```


**注意:**

-   给定数组的长度不会超过`50000`。
-   输入数组中的所有数字都在`32`位整数的表示范围内。



## 2、解题思路

-   使用树状数组
-   根据题意分析，`i < j` 且 `nums[i] > 2*nums[j]`，这个条件我们可以解读为，当前元素后方有多少元素比这个元素的一半还小
-   首先我们队所有`num`以及`2*num+1`排序后做映射，然后从后向前扫描
-   首先找出满足小于等于当前元素的数量有多少，然后将当前元素的2倍加一，更新到树状数组中，也就是这个元素至少为多少才能作为满足条件的元素

```
基本思路很简单：
	我们用当前数字查找有多少小于等于当前数字的元素
	每个元素以2倍加一更新到树状数组，保证第一步查出的数量都是这个元素后方满足条件元素
```



```python
from typing import List


class BinaryIndexTree:
    def __init__(self, length):
        self.buff = [0] * (length + 1)

    def update(self, i):
        """
        :type i: int
        :rtype: void
        """
        index = i + 1
        while index < len(self.buff):
            self.buff[index] += 1
            index += index & (-index)

    def getSum(self, index):
        res = 0
        index += 1
        while index > 0:
            res += self.buff[index]
            index -= index & (-index)

        return res


class Solution:
    def reversePairs(self, nums: List[int]) -> int:
        mapping_index = {val: index for index, val in enumerate(sorted(set(map(lambda x: 2 * x + 1, nums)).union(set(nums))))}
        bit = BinaryIndexTree(len(mapping_index))
        ans = 0

        for num in reversed(nums):
            ans += bit.getSum(mapping_index[num])
            bit.update(mapping_index[2 * num + 1])
        return ans
```

