# LeetCode: 1296. 划分数组为连续数字的集合

[TOC]

## 1、题目描述

给你一个整数数组 `nums` 和一个正整数 `k`，请你判断是否可以把这个数组划分成一些由 `k` 个连续数字组成的集合。
如果可以，请返回 `True`；否则，返回 `False`。

 

**示例 1：**

```
输入：nums = [1,2,3,3,4,4,5,6], k = 4
输出：true
解释：数组可以分成 [1,2,3,4] 和 [3,4,5,6]。
```


**示例** 2：

```
输入：nums = [3,2,1,2,3,4,3,4,5,9,10,11], k = 3
输出：true
解释：数组可以分成 [1,2,3] , [2,3,4] , [3,4,5] 和 [9,10,11]。
```


**示例 3：**

```
输入：nums = [3,3,2,2,1,1], k = 3
输出：true
```


**示例 4：**

```
输入：nums = [1,2,3,4], k = 3
输出：false
解释：数组不能分成几个大小为 3 的子数组。
```

**提示：**

-   $1 <= nums.length <= 10^5$
-   $1 <= nums[i] <= 10^9$
-   $1 <= k <= nums.length$



## 2、解题思路

-   每次取最小值，然后将最小值向上`k-1`个数字减少最小值的频率
-   一旦出现小于`0`的情况，返回`False`



```python
from collections import Counter


class Solution:
    def isPossibleDivide(self, nums: List[int], k: int) -> bool:
        count = Counter(nums)

        for key in sorted(count.keys()):
            if count[key] == 0:
                continue
            elif count[key] > 0:
                cur = count[key]
                for i in range(1, k):
                    count[key + i] -= cur
                    if count[key + i] < 0:
                        return False

            else:
                return False
        return True
```

