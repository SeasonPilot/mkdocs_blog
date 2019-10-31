# LeetCode: 923. 三数之和的多种可能

[TOC]

## 1、题目描述

给定一个整数数组 `A`，以及一个整数 `target` 作为目标值，返回满足 `i < j < k` 且 `A[i] + A[j] + A[k] == target` 的元组 `i, j, k` 的数量。

由于结果会非常大，请返回 结果除以 $10^9 + 7$ 的余数。

 

**示例 1：**

```
输入：A = [1,1,2,2,3,3,4,4,5,5], target = 8
输出：20
解释：
按值枚举（A[i]，A[j]，A[k]）：
(1, 2, 5) 出现 8 次；
(1, 3, 4) 出现 8 次；
(2, 2, 4) 出现 2 次；
(2, 3, 3) 出现 2 次。
```


**示例 2：**

```
输入：A = [1,1,2,2,2,2], target = 5
输出：12
解释：
A[i] = 1，A[j] = A[k] = 2 出现 12 次：
我们从 [1,1] 中选择一个 1，有 2 种情况，
从 [2,2,2,2] 中选出两个 2，有 6 种情况。
```

**提示：**

-   $3 <= A.length <= 3000$
-   $0 <= A[i] <= 100$
-   $0 <= target <= 300$



## 2、解题思路

-   双字典统计法
-   针对一个元素，分别在左侧和右侧取一个元素，判断能否得到target
-   左侧与右侧的元素分别使用字典进行数量的统计



```python
from collections import defaultdict


class Solution:
    def threeSumMulti(self, A: List[int], target: int) -> int:
        mod_num = 1000000007
        left = defaultdict(int)
        left_set = {A[0], }
        right = defaultdict(int)
        left[A[0]] += 1
        for i in A[1:]:
            right[i] += 1

        ans = 0

        for num in A[1:-1]:
            right[num] -= 1
            for left_num in left_set:
                ans += left[left_num] * right[target - num - left_num]
            ans %= mod_num
            left[num] += 1
            left_set.add(num)
        return ans
```

