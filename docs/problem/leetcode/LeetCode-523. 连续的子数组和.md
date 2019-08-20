# LeetCode: 523. 连续的子数组和

[TOC]

## 1、题目描述

给定一个包含非负数的数组和一个目标整数 k，编写一个函数来判断该数组是否含有连续的子数组，其大小至少为 2，总和为 k 的倍数，即总和为 n*k，其中 n 也是一个整数。

**示例 1:**

```
输入: [23,2,4,6,7], k = 6
输出: True
解释: [2,4] 是一个大小为 2 的子数组，并且和为 6。
```

**示例 2:**

```
输入: [23,2,6,4,7], k = 6
输出: True
解释: [23,2,6,4,7]是大小为 5 的子数组，并且和为 42。
```

说明:**

- 数组的长度不会超过10,000。
- 你可以认为所有数字总和在 32 位有符号整数范围内。




## 2、解题思路

- 这道题目偏数学

如果假设前面`i`个元素的和为`sum_i`，如果`sum_i%k=2`，那么，如果前j个元素之和为`sum_j`，并且`sum_j%k=2`，这时候，我们只需判断`i`和`j`之间是否有两个元素即可

```
sum_i %k == (sum_i + n*k)%k == sum_j %k
sum_j - sum_i == n*k
```

当他们得到相同的余数的时候，那么肯定中间有`k`的倍数存在

```python
class Solution:
    def checkSubarraySum(self, nums: List[int], k: int) -> bool:
        N = len(nums)

        mapping = {0: -1}
        add_sum = 0
        for index, num in enumerate(nums):
            add_sum += num
            if k:
                add_sum %= k
            if add_sum in mapping:
                if index - mapping[add_sum] > 1:
                    return True
            else:
                mapping[add_sum] = index

        return False
```

