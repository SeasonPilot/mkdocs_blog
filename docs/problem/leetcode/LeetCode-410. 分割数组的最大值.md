# LeetCode: 410. 分割数组的最大值

[TOC]

## 1、题目描述

给定一个非负整数数组和一个整数 `m`，你需要将这个数组分成 `m` 个非空的连续子数组。设计一个算法使得这 `m` 个子数组各自和的最大值最小。

注意:
数组长度 `n` 满足以下条件:

-   $1 ≤ n ≤ 1000$
-   $1 ≤ m ≤ min(50, n)$

**示例:**

```
输入:
nums = [7,2,5,10,8]
m = 2

输出:
18

解释:
一共有四种方法将nums分割为2个子数组。
其中最好的方式是将其分为[7,2,5] 和 [10,8]，
因为此时这两个子数组各自的和的最大值为18，在所有情况中最小。
```



## 2、解题思路

-   深度优先加二分法
-   首先计算出平均分成`m`份的平均为多少，每次使用二分法，尽可能取到平均值以及前后的值



```python
from itertools import accumulate
from functools import lru_cache
import bisect


class Solution:
    def splitArray(self, nums: List[int], m: int) -> int:
        length = len(nums)

        acc_sums = [0] + list(accumulate(nums))
        average = acc_sums[-1] / m

        @lru_cache(None)
        def dfs(pos, k):
            if k == 1:
                return acc_sums[length] - acc_sums[pos]
            ans = float('inf')
            target = acc_sums[pos] + average
            index = bisect.bisect_left(acc_sums, target, pos + 1)

            # for i in range(pos, index+1 if index+1 <= length - k + 1 else length - k + 1):
            #     ans = min(ans, max(acc_sums[i + 1] - acc_sums[pos], dfs(i + 1, k - 1)))

            if index > pos + 1:
                ans = min(ans, max(acc_sums[index - 1] - acc_sums[pos], dfs(index - 1, k - 1)))
            if index <= length - k + 1:
                ans = min(ans, max(acc_sums[index] - acc_sums[pos], dfs(index, k - 1)))
            if index + 1 <= length - k + 1:
                ans = min(ans, max(acc_sums[index + 1] - acc_sums[pos], dfs(index + 1, k - 1)))
            return ans

        return dfs(0, m)
    
    
    
```



-   和值二分法

-   最小的值就是数组中最大的数字，最大值就是数组之和
-   使用二分法不断逼近，每次尝试用中间值去划分数组，划分数量太少，表示和值需要减少，划分数量太多，表示需要增大和值

```python
class Solution:
    def splitArray(self, nums: List[int], m: int) -> int:


        def get_groups(current_sum):
            res = 1
            temp_sum = 0
            for num in nums:
                temp_sum += num
                if temp_sum > current_sum:
                    temp_sum = num
                    res += 1
            return res

        left, right = max(nums), sum(nums)
        while left <= right:
            mid = left + (right-left) // 2
            if get_groups(mid) > m:
                left = mid + 1
            else:
                right = mid - 1
        return left

```

