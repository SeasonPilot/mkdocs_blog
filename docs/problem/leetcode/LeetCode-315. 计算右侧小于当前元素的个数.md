# LeetCode: 315. 计算右侧小于当前元素的个数

[TOC]

## 1、题目描述

给定一个整数数组 `nums`，按要求返回一个新数组 `counts`。数组 `counts` 有该性质： `counts[i]` 的值是  nums[i] 右侧小于 `nums[i]` 的元素的数量。

**示例:**

```
输入: [5,2,6,1]
输出: [2,1,1,0] 
解释:
5 的右侧有 2 个更小的元素 (2 和 1).
2 的右侧仅有 1 个更小的元素 (1).
6 的右侧有 1 个更小的元素 (1).
1 的右侧有 0 个更小的元素.
```



## 2、解题思路

-   首先进行值的映射，将对应的值映射为正确的顺序
-   然后采用树状数组反向查询，小于当前数的有几个元素



```python
class BinaryIndexTree:
    def __init__(self, num):
        """
        :type nums: List[int]
        """

        self.buff = [0] * (num + 1)

    def update(self, i, val):
        """
        :type i: int
        :type val: int
        :rtype: void
        """
        index = i + 1
        while index < len(self.buff):
            self.buff[index] += val
            index += index & (-index)

    def getSum(self, index):
        index += 1
        res = 0
        while index > 0:
            res += self.buff[index]
            index -= index & (-index)
        return res


class Solution:
    def countSmaller(self, nums: List[int]) -> List[int]:
        mapping = {val: key for key, val in enumerate(sorted(set(nums)))}
        bit = BinaryIndexTree(len(mapping))

        ans = [0] * len(nums)

        for index, num in enumerate(reversed(nums)):
            bit.update(mapping[num], 1)
            ans[-1 - index] = bit.getSum(mapping[num] - 1)

        return ans
```

