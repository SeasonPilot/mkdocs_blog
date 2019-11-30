# LeetCode: 154. 寻找旋转排序数组中的最小值II

[TOC]

## 1、题目描述

假设按照升序排序的数组在预先未知的某个点上进行了旋转。

( 例如，数组 `[0,1,2,4,5,6,7]` 可能变为 `[4,5,6,7,0,1,2]` )。

请找出其中最小的元素。

注意数组中可能存在重复的元素。

**示例 1：**

```
输入: [1,3,5]
输出: 1
```


**示例 2：**

```
输入: [2,2,2,0,1]
输出: 0
```


**说明：**

-   这道题是 [寻找旋转排序数组中的最小值](https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/description/) 的延伸题目。
-   允许重复会影响算法的时间复杂度吗？会如何影响，为什么？



## 2、解题思路

-   二分法找出只有递增的区间
-   由于有重复值的存在，当左右区间端点值相等的时候，右端点左移即可



```python
class Solution:
    def findMin(self, nums: List[int]) -> int:
        length = len(nums)

        left = 0
        right = length - 1

        while left < right:
            mid = (left + right) // 2
            if nums[left] > nums[right]:
                if nums[mid] >= nums[left]:
                    left = mid + 1
                else:
                    right = mid
            elif nums[left] == nums[right]:
                right -= 1
            else:
                break
        return nums[left]
```

