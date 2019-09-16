# LeetCode: 740. 删除与获得点数

[TOC]

## 1、题目描述

给定一个整数数组 `nums` ，你可以对它进行一些操作。

每次操作中，选择任意一个 `nums[i]` ，删除它并获得 `nums[i]` 的点数。之后，你必须删除每个等于 `nums[i] - 1` 或 `nums[i] + 1` 的元素。

开始你拥有 `0` 个点数。返回你能通过这些操作获得的最大点数。

**示例 1:**

```
输入: nums = [3, 4, 2]
输出: 6
解释: 
删除 4 来获得 4 个点数，因此 3 也被删除。
之后，删除 2 来获得 2 个点数。总共获得 6 个点数。
```


**示例 2:**

```
输入: nums = [2, 2, 3, 3, 3, 4]
输出: 9
解释: 
删除 3 来获得 3 个点数，接着要删除两个 2 和 4 。
之后，再次删除 3 获得 3 个点数，再次删除 3 获得 3 个点数。
总共获得 9 个点数。
```


**注意:**

- `nums的长度最大为20000。`
- `每个整数nums[i]的大小都在[1, 10000]范围内。`



## 2、解题思路

- 动态规划
- 首先需要统计数字的个数
- 初始化

```
dp[i] : 表示从开始到当前位置的最大点数
```

- 状态转换方程

```
 dp[i] = max(dp[i - 1], dp[i-2] + i * count[i])
```



```python
from collections import Counter


class Solution:
    def deleteAndEarn(self, nums: List[int]) -> int:
        if not nums:
            return 0
        max_length = max(nums) + 1
        dp = [0] * max_length
        count = Counter(nums)

        for i in range(1, max_length):
            if i not in count:
                dp[i] = dp[i - 1]
            else:
                m2 = dp[i - 2] if i >= 2 else 0
                dp[i] = max(dp[i - 1], m2 + i * count[i])

        return dp[-1]
```



- 简化版

```python
from collections import Counter


class Solution:
    def deleteAndEarn(self, nums: List[int]) -> int:
        
        if not nums:
            return 0
        count = Counter(nums)
        pre, cur = 0, 0
        for num in sorted(count.keys()):
            if num - 1 in count:
                pre, cur = cur, max(pre + num * count[num], cur)
            else:
                pre, cur = cur, cur + num * count[num]
        return cur
```

