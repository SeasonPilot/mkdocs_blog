# LeetCode: 1144. 递减元素使数组呈锯齿状

[TOC]

## 1、题目描述

给你一个整数数组 `nums`，每次 操作 会从中选择一个元素并 将该元素的值减少 `1`。

如果符合下列情况之一，则数组 `A` 就是 锯齿数组：

-   每个偶数索引对应的元素都大于相邻的元素，即 `A[0] > A[1] < A[2] > A[3] < A[4] > ...`
-   或者，每个奇数索引对应的元素都大于相邻的元素，即 `A[0] < A[1] > A[2] < A[3] > A[4] < ...`
    返回将数组 `nums` 转换为锯齿数组所需的最小操作次数。

 

**示例 1：**

```
输入：nums = [1,2,3]
输出：2
解释：我们可以把 2 递减到 0，或把 3 递减到 1。
```


**示例 2：**

```
输入：nums = [9,6,1,6,2]
输出：4
```

**提示：**

-   $1 <= nums.length <= 1000$
-   $1 <= nums[i] <= 1000$



## 2、解题思路

-   分别对两种模式进行讨论
-   第一种模式，考虑中间的值最小，那么就是减小当前数字比周围两个数字更小
-   第二种模式，考虑中间的值最大，那么就是减小周围两个数字，减小到比当前数字更小

```python
class Solution:
    def movesToMakeZigzag(self, nums: List[int]) -> int:
        length = len(nums)
        pattern1_arr = nums[:]
        pattern2_arr = nums[:]
        pattern1 = 0
        pattern2 = 0

        for i in range(1, length, 2):

            if pattern1_arr[i - 1] >= pattern1_arr[i]:
                temp = pattern1_arr[i - 1] - pattern1_arr[i] + 1
                pattern1_arr[i - 1] -= temp
                pattern1 += temp

            if pattern2_arr[i - 1] <= pattern2_arr[i]:
                temp = pattern2_arr[i] - nums[i - 1] + 1
                pattern2_arr[i] -= temp
                pattern2 += temp

            if i + 1 < length:
                if pattern1_arr[i + 1] >= pattern1_arr[i]:
                    temp = pattern1_arr[i + 1] - pattern1_arr[i] + 1
                    pattern1 += temp
                    pattern1_arr[i + 1] -= temp
                if pattern2_arr[i + 1] <= pattern2_arr[i]:
                    temp = pattern2_arr[i] - pattern2_arr[i + 1] + 1
                    pattern2 += temp
                    pattern2_arr[i] -= temp

        return min(pattern1, pattern2)
```

