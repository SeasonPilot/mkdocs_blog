# LeetCode: 713. 乘积小于K的子数组

[TOC]

## 1、题目描述

给定一个正整数数组 `nums`。

找出该数组内乘积小于 `k` 的连续的子数组的个数。



**示例 1:**

```
输入: nums = [10,5,2,6], k = 100
输出: 8
解释: 8个乘积小于100的子数组分别为: [10], [5], [2], [6], [10,5], [5,2], [2,6], [5,2,6]。
需要注意的是 [10,5,2] 并不是乘积小于100的子数组。
```


**说明:**

-   $0 < nums.length <= 50000$
-   $0 < nums[i] < 1000$
-   $0 <= k < 10^6$



## 2、解题思路

-   双指针法
-   基本思路为找出截止到当前位置的满足条件的组序列长度为多少
-   由于右指针在右移的过程中，左指针也会跟着右移，而不需要从头判断



```python
class Solution:
    def numSubarrayProductLessThanK(self, nums: List[int], k: int) -> int:
        if k <= 1:
            return 0
        ans = 0
        left = 0
        current_sums = 1
        for index, num in enumerate(nums):
            current_sums *= num
            while current_sums >= k:
                current_sums /= nums[left]
                left += 1
            ans += index - left + 1
        return ans
```

