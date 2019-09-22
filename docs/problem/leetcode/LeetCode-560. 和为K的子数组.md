# LeetCode: 560. 和为K的子数组

[TOC]

## 1、题目描述

给定一个整数数组和一个整数 `k`，你需要找到该数组中和为 `k` 的连续的子数组的个数。

**示例 1 :**

```
输入:nums = [1,1,1], k = 2
输出: 2 , [1,1] 与 [1,1] 为两种不同的情况。
说明 :

数组的长度为 [1, 20,000]。
数组中元素的范围是 [-1000, 1000] ，且整数 k 的范围是 [-1e7, 1e7]。
```



## 2、解题思路

- 使用字典保存之前出现过的和值，每一次统计出现过的和值汇总是否有满足条件的



```python
class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        from collections import defaultdict
        res = 0

        sums = 0

        d = defaultdict(int)
        d[0] = 1

        for i in range(len(nums)):
            sums += nums[i]
            res += d[sums - k]
            d[sums] += 1
        return res
```

