# LeetCode: 41. 缺失的第一个正数

[TOC]

## 1、题目描述

给定一个未排序的整数数组，找出其中没有出现的最小的正整数。

**示例 1:**

```
输入: [1,2,0]
输出: 3
```


**示例 2:**

```
输入: [3,4,-1,1]
输出: 2
```


**示例 3:**

```
输入: [7,8,9,11,12]
输出: 1
```


**说明:**

-   你的算法的时间复杂度应为`O(n)`，并且只能使用常数级别的空间。



## 2、解题思路

-   使用标记法，首先明确，缺失的数字肯定在`[1,length+1]`中
-   首先找出大于0的最小的数字，判断如果不是1，返回1
-   然后针对所有的小于等于0的数字，替换为1
-   然后遍历数组，对每个一个数字求出对于`1`的距离，将距离 对应的数字变成负数

```
例如
[4,5,6,1,2,2,3,2]
4-1=3
[4,5,6,-1,2,2,3,2]
```

用正负号表示数字的连续性，最后遍历一次，找出第一个正数所在的下标，返回下标加一即可

如果没找到，表示数组是从1开始连续的，返回`length+1`



```python
class Solution:
    def firstMissingPositive(self, nums: List[int]) -> int:
        start = 2 ** 32
        length = len(nums)
        for num in nums:
            if num > 0:
                start = min(start, num)
        if start > 1:
            return 1

        for index in range(length):
            if nums[index] <= 0:
                nums[index] = 1

        for index in range(length):
            pos = abs(nums[index]) - start
            if 0 <= pos < length:
                if nums[pos] > 0:
                    nums[pos] = - nums[pos]

        for i in range(length):
            if nums[i] > 0:
                return i + 1
        return length + 1
```

