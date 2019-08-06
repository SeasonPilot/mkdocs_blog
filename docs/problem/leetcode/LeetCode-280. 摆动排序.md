# LeetCode: 280. 摆动排序

[TOC]

## 1、题目描述

给你一个无序的数组 nums, 将该数字 原地 重排后使得 nums[0] <= nums[1] >= nums[2] <= nums[3]...。

**示例:**

```
输入: nums = [3,5,2,1,6,4]
输出: 一个可能的解答是 [3,5,1,6,2,4]
```



## 2、解题思路

- 排序后，从第二个元素开始，两两交换位置

```python
class Solution:
    def wiggleSort(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        nums.sort()
        t = 1
        N = len(nums)
        while t < N - 1:
            nums[t], nums[t + 1] = nums[t + 1], nums[t]
            t += 2
```

