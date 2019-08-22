# LeetCode: 540. 有序数组中的单一元素

[TOC]

## 1、题目描述

给定一个只包含整数的有序数组，每个元素都会出现两次，唯有一个数只会出现一次，找出这个数。

**示例 1:**

```
输入: [1,1,2,3,3,4,4,8,8]
输出: 2
```

**示例 2:**

```
输入: [3,3,7,7,10,11,11]
输出: 10
```


**注意:** 您的方案应该在 O(log n)时间复杂度和 O(1)空间复杂度中运行。

## 2、解题思路

- 所有数值异或即可

```python
class Solution:
    def singleNonDuplicate(self, nums: List[int]) -> int:
        from functools import reduce

        return reduce(lambda x, y: x ^ y, nums)
```

```python
class Solution:
    def singleNonDuplicate(self, nums: List[int]) -> int:
        target = 0
        for i in nums:
            target ^= i
        return target
```

- 奇偶位不同

```python
class Solution:
    def singleNonDuplicate(self, nums: List[int]) -> int:
				for i in range(0, len(nums), 2):
            if i == len(nums) - 1 or nums[i] != nums[i + 1]:
                return nums[i]
```

- 二分法

```python
class Solution:
    def singleNonDuplicate(self, nums: List[int]) -> int:
        
        left = 0
        right = len(nums) - 1

        while left < right:
            mid = (left + right) // 2
            if mid % 2:
                mid -= 1

            if nums[mid] == nums[mid + 1]:
                left = mid + 2
            else:
                right = mid
        return nums[left]
```

