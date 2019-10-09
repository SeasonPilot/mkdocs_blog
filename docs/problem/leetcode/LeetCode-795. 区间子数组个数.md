# LeetCode: 795. 区间子数组个数

[TOC]

## 1、题目描述

给定一个元素都是正整数的数组`A` ，正整数 `L` 以及 `R (L <= R)`。

求连续、非空且其中最大元素满足大于等于`L` 小于等于`R`的子数组个数。

**例如 :**

```
输入: 
A = [2, 1, 4, 3]
L = 2
R = 3
输出: 3
解释: 满足条件的子数组: [2], [2, 1], [3].
```

**注意:**

-   `L, R  和 A[i] 都是整数，范围在 [0, 10^9]。`
-   `数组 A 的长度范围在[1, 50000]。`



## 2、解题思路

-   在区间[L,R]之间的数组数量 = 小于等于R的数组数量 - 小于L的数组数量



```python
class Solution:
    def numSubarrayBoundedMax(self, A: List[int], L: int, R: int) -> int:
        start_pos_le_r = 0
        start_pos_lt_l = 0

        count_le_r = 0
        count_lt_l = 0

        for index, num in enumerate(A):
            if num > R:
                start_pos_le_r = index + 1
            else:
                count_le_r += index - start_pos_le_r + 1

            if num >= L:
                start_pos_lt_l = index + 1
            else:
                count_lt_l += index - start_pos_lt_l + 1

        return count_le_r - count_lt_l
```

