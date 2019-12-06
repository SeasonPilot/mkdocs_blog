# LeetCode: 321. 拼接最大数

[TOC]

## 1、题目描述

给定长度分别为 `m` 和 `n` 的两个数组，其元素由 `0-9` 构成，表示两个自然数各位上的数字。现在从这两个数组中选出 `k (k <= m + n)` 个数字拼接成一个新的数，要求从同一个数组中取出的数字保持其在原数组中的相对顺序。

求满足该条件的最大数。结果返回一个表示该最大数的长度为 `k` 的数组。

说明: 请尽可能地优化你算法的时间和空间复杂度。

**示例 1:**

```
输入:
nums1 = [3, 4, 6, 5]
nums2 = [9, 1, 2, 5, 8, 3]
k = 5
输出:
[9, 8, 6, 5, 3]
```


**示例 2:**

```
输入:
nums1 = [6, 7]
nums2 = [6, 0, 4]
k = 5
输出:
[6, 7, 6, 0, 4]
```


**示例 3:**

```
输入:
nums1 = [3, 9]
nums2 = [8, 9]
k = 3
输出:
[9, 8, 9]


```



## 2、解题思路

-   使用贪心法
-   在第一个数组中和第二个数组中取出所有可能的子数组和为`k`的最大子数组，然后根据字典序进行合并，取出其中最大的值



```python
from typing import List

class Solution:
    def maxNumber(self, nums1: List[int], nums2: List[int], k: int) -> List[int]:
        length1 = len(nums1)
        length2 = len(nums2)

        def get_max_k_num(arr: List, k_num: int) -> []:
            if k_num == 0:
                return []
            if k_num == len(arr):
                return arr
            ans_buff = []
            remove_num = len(arr) - k_num
            for arr_num in arr:
                while ans_buff and arr_num > ans_buff[-1] and remove_num > 0:
                    ans_buff.pop()
                    remove_num -= 1
                ans_buff.append(arr_num)
            return ans_buff[:k_num]

        ans = [-1] * k
        for i in range(0 if k - length2 <= 0 else k - length2, min(k, length1) + 1):
            first = get_max_k_num(nums1, i)
            second = get_max_k_num(nums2, k - i)
            pos1, pos2 = 0, 0
            l1, l2 = len(first), len(second)
            temp = []
            while pos1 < l1 and pos2 < l2:
                if first[pos1] > second[pos2]:
                    temp.append(first[pos1])
                    pos1 += 1
                elif first[pos1] < second[pos2]:
                    temp.append(second[pos2])
                    pos2 += 1
                else:
                    if first[pos1:] > second[pos2:]:
                        temp.append(first[pos1])
                        pos1 += 1
                    else:
                        temp.append(second[pos2])
                        pos2 += 1
            if pos1 < l1:
                temp.extend(first[pos1:])
            if pos2 < l2:
                temp.extend(second[pos2:])
            if ans < temp:
                ans = temp
        return ans

```

