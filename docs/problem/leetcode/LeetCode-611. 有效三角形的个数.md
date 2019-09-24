# LeetCode: 611. 有效三角形的个数

[TOC]

## 1、题目描述

给定一个包含非负整数的数组，你的任务是统计其中可以组成三角形三条边的三元组个数。

**示例 1:**

```
输入: [2,2,3,4]
输出: 3
解释:
有效的组合是: 
2,3,4 (使用第一个 2)
2,3,4 (使用第二个 2)
2,2,3
```


**注意:**

- 数组长度不超过`1000`。
- 数组里整数的范围为 `[0, 1000]`。



## 2、解题思路

- 先排序

- 然后固定右面的元素，从左面查找另外两个元素

  

```python
class Solution:
    def triangleNumber(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return 0
        length = len(nums)
        ans = 0
        nums.sort()

        for third in range(length - 1, 1, -1):
            left, right = 0, third-1
            while left < right:
                if nums[third] < nums[left] + nums[right]:
                    ans += right - left
                    right -= 1
                else:
                    left += 1
        return ans
```

