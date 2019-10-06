# LeetCode: 5079. 三个有序数组的交集

[TOC]

## 1、题目描述

给出三个均为 严格递增排列 的整数数组 `arr1`，`arr2` 和 `arr3`。

返回一个由 仅 在这三个数组中 同时出现 的整数所构成的有序数组。

 

**示例：**

```
输入: arr1 = [1,2,3,4,5], arr2 = [1,2,5,7,9], arr3 = [1,3,4,5,8]
输出: [1,5]
解释: 只有 1 和 5 同时在这三个数组中出现.
```

**提示：**

-   `1 <= arr1.length, arr2.length, arr3.length <= 1000`
-   `1 <= arr1[i], arr2[i], arr3[i] <= 2000`



## 2、解题思路



```python
class Solution:
    def arraysIntersection(self, arr1: List[int], arr2: List[int], arr3: List[int]) -> List[int]:
        from collections import Counter
        ans = []
        c1 = Counter(arr1)
        c2 = Counter(arr2)
        c3 = Counter(arr3)

        for k, num in c1.items():
            if k in c2 and k in c3:
                ans.extend([k] * min(num, c2[k], c3[k]))
        return ans
```

