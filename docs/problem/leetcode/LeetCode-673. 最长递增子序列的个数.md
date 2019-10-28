# LeetCode: 673. 最长递增子序列的个数

[TOC]

## 1、题目描述

给定一个未排序的整数数组，找到最长递增子序列的个数。

**示例 1:**

```
输入: [1,3,5,4,7]
输出: 2
解释: 有两个最长递增子序列，分别是 [1, 3, 4, 7] 和[1, 3, 5, 7]。
```


**示例 2:**

```
输入: [2,2,2,2,2]
输出: 5
解释: 最长递增子序列的长度是1，并且存在5个子序列的长度为1，因此输出5。
```

**注意:**

-    `给定的数组长度不超过 2000 并且结果一定是32位有符号整数。`



## 2、解题思路

-   动态规划
-   用当前位置之前所有小于当前数字的子序列的长度更新当前位置的子序列长度与子序列的数量
-   最后统计所有等于最长子序列长度的子序列数量的和



```python
class Solution:
    def findNumberOfLIS(self, nums: List[int]) -> int:
        length = len(nums)

        dp = [1] * length
        sub_count = [0] * length
        max_sub = 1
        for i, num in enumerate(nums):
            for j in range(i):
                if nums[j] < nums[i]:
                    if dp[j] + 1 == dp[i]:
                        sub_count[i] += sub_count[j]
                    elif dp[j] + 1 > dp[i]:
                        sub_count[i] = sub_count[j]

                    dp[i] = max(dp[i], dp[j] + 1)

            sub_count[i] = max(sub_count[i], 1)
            max_sub = max(max_sub, dp[i])

        return sum([count for sub, count in zip(dp, sub_count) if sub == max_sub])


```

