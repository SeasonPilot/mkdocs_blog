# LeetCode: 1287. 有序数组中出现次数超过25%的元素

[TOC]

## 1、题目描述

给你一个非递减的 有序 整数数组，已知这个数组中恰好有一个整数，它的出现次数超过数组元素总数的 `25%`。

请你找到并返回这个整数

 

**示例：**

```
输入：arr = [1,2,2,6,6,6,6,7,10]
输出：6
```

**提示：**

-   $1 <= arr.length <= 10^4$
-   $0 <= arr[i] <= 10^5$



## 2、解题思路

-   对数组进行切分，均匀切成4份，超过`25%`的元素肯定在这几个分界点中
-   然后利用二分查找，找出分界点的出现频率，取最大频率即可



```python
import bisect


class Solution:
    def findSpecialInteger(self, arr: List[int]) -> int:
        length = len(arr)
        quarter = length // 4 if length > 4 else 1

        max_num = [0, -1]
        for index in range(quarter - 1, length, quarter):
            current_num = arr[index]
            freq_num = bisect.bisect_right(arr, current_num) - bisect.bisect_left(arr, current_num)
            if freq_num > max_num[0]:
                max_num = [freq_num, current_num]
        return max_num[1]
```

