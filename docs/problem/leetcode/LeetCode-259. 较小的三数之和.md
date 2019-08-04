# LeetCode: 259. 较小的三数之和

[TOC]

## 1、题目描述

给定一个长度为 `n` 的整数数组和一个目标值 `target`，寻找能够使条件 `nums[i] + nums[j] + nums[k] < target` 成立的三元组 ` i, j, k` 个数`（0 <= i < j < k < n）`。

**示例：**

```
输入: nums = [-2,0,1,3], target = 2
输出: 2 
解释: 因为一共有两个三元组满足累加和小于 2:
     [-2,0,1]
     [-2,0,3]
```



- 进阶：是否能在 O(n2) 的时间复杂度内解决？

## 2、解题思路

- 首先对数组排序
- 然后取出一个元素，对这个元素右面的元素选出两个
- 设置一个left，right，当三个元素之和小于target的时候，我们认为当前元素，加上left元素，第三个元素作为可变元素

```
实例：
[-2,0,1,3]
首先判断能够和-2组成加和并满足条件的两个元素
在右面的0，1，3中，使用双指针找出范围，如果左右指针加起来满足条件，因为是有序的，所以当前节点加上左指针，然后从左指针到右指针中间任取一个数都是满足条件的

```





```python
class Solution:
    def threeSumSmaller(self, nums: List[int], target: int) -> int:
        nums.sort()
        res = 0
        for index, num in enumerate(nums):
            left = index + 1
            right = len(nums) - 1
            while left < right:
                temp = num + nums[left] + nums[right]
                if temp < target:
                    res += right - left
                    left += 1
                else:
                    right -= 1
        return res
```

