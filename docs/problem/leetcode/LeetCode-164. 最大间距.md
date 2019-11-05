# LeetCode: 164. 最大间距

[TOC]

## 1、题目描述

给定一个无序的数组，找出数组在排序之后，相邻元素之间最大的差值。

如果数组元素个数小于 `2`，则返回 `0`。

**示例 1:**

```
输入: [3,6,9,1]
输出: 3
解释: 排序后的数组是 [1,3,6,9], 其中相邻元素 (3,6) 和 (6,9) 之间都存在最大差值 3。
```


**示例 2:**

```
输入: [10]
输出: 0
解释: 数组元素个数小于 2，因此返回 0。
```


**说明:**

-   你可以假设数组中所有元素都是非负整数，且数值在 32 位有符号整数范围内。
-   请尝试在线性时间复杂度和空间复杂度的条件下解决此问题。



## 2、解题思路

-   使用桶排序
-   这个题目的关键点就是以最小的间距作为桶的容量

```
假如一个数组有5个元素，那么正常排序之后，会产生4个间距，如果间距均匀，就能得到最小间距，也就是
(max_num - min_num) / (len(nums) -1 )

如果不均匀，那么，间距肯定会超过这个均匀间距
因此，按照均匀间距做桶，在同一个桶中的元素的间距肯定不会超过均匀间距，因此只需要记住同一个桶中的最大值和最小值，用来做前后桶之间的比较即可
```



```python
import math


class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        length = len(nums)
        if length < 2:
            return 0
        min_num, max_num = min(nums), max(nums)
        if max_num == min_num:
            return 0
        bucket_length = math.ceil((max_num - min_num) / (length - 1))
        bucket_num = math.ceil((max_num - min_num) / bucket_length) + 1
        max_inf = 2 ** 32
        min_inf = -2 ** 32
        buckets = [[max_inf, min_inf] for _ in range(bucket_num)]

        for num in nums:
            target_bucket = (num - min_num) // bucket_length
            buckets[target_bucket][0] = min(num, buckets[target_bucket][0])
            buckets[target_bucket][1] = max(num, buckets[target_bucket][1])

        pre_max = min_num
        ans = 0
        for cur_min, cur_max in buckets:
            if cur_min != max_inf:
                ans = max(ans, cur_min - pre_max)
                pre_max = cur_max
        return ans

```

