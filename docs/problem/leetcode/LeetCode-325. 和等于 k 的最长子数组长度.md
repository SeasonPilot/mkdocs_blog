# LeetCode: 325. 和等于 k 的最长子数组长度

[TOC]

## 1、题目描述

给定一个数组 `nums` 和一个目标值 `k`，找到和等于 `k` 的最长子数组长度。如果不存在任意一个符合要求的子数组，则返回 `0`。

**注意:**
 `nums` 数组的总和是一定在 `32` 位有符号整数范围之内的。

**示例 1:**

```
输入: nums = [1, -1, 5, -2, 3], k = 3
输出: 4 
解释: 子数组 [1, -1, 5, -2] 和等于 3，且长度最长。
```


**示例 2:**

```
输入: nums = [-2, -1, 2, 1], k = 1
输出: 2 
解释: 子数组 [-1, 2] 和等于 1，且长度最长。
```


**进阶:**

-   你能使时间复杂度在 `O(n)` 内完成此题吗?



## 2、解题思路

基本思路为：

**-** 计算前缀和

**-** 对当前的前缀和**`cur_sum`**，向前面找是否存在**`cur_sum -k`**，存在则更新ans

**-** 如果**`cur_sum`**不在**`pre`**中，将**`cur_sum`**加入（如果存在，前面的坐标更小，不需更新）



```python
from itertools import accumulate


class Solution:
    def maxSubArrayLen(self, nums: List[int], k: int) -> int:
        pre = {0: -1}
        ans = 0
        for index, cur_sum in enumerate(accumulate(nums)):
            if cur_sum - k in pre:
                ans = max(ans, index - pre[cur_sum - k])
            if cur_sum not in pre:
                pre[cur_sum] = index
        return ans

```

