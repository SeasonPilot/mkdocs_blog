# LeetCode: 153. 寻找旋转排序数组中的最小值

[TOC]

## 1、题目描述



假设按照升序排序的数组在预先未知的某个点上进行了旋转。

( 例如，数组 `[0,1,2,4,5,6,7]` 可能变为 `[4,5,6,7,0,1,2]` )。

请找出其中最小的元素。

你可以假设数组中不存在重复元素。

**示例 1:**

```
输入: [3,4,5,1,2]
输出: 1
```

**示例 2:**

```
输入: [4,5,6,7,0,1,2]
输出: 0
```



## 2、解题思路

-   直接取最小值

```python
class Solution:
    def findMin(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        return min(nums)
```

-   使用二分法，找出递增区间，返回区间左侧的值

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
            else:
                break
        return nums[left]
```

