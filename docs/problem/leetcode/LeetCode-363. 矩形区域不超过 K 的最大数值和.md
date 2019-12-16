# LeetCode: 363. 矩形区域不超过 K 的最大数值和

[TOC]

## 1、题目描述

给定一个非空二维矩阵 `matrix` 和一个整数 `k`，找到这个矩阵内部不大于 `k` 的最大矩形和。

**示例:**

```
输入: matrix = [[1,0,1],[0,-2,3]], k = 2
输出: 2 
解释: 矩形区域 [[0, 1], [-2, 3]] 的数值和是 2，且 2 是不超过 k 的最大数字（k = 2）。
```


**说明：**

-   矩阵内的矩形区域面积必须大于 `0`。
-   如果行数远大于列数，你将如何解答呢？



## 2、解题思路

-   首先固定左右边界
-   然后将行做前缀和进行搜索



```python
import bisect


class Solution:
    def maxSumSubmatrix(self, matrix: List[List[int]], k: int) -> int:
        row, col = len(matrix), len(matrix[0])

        res = float('-inf')
        for left in range(col):
            current_sums = [0] * row
            for right in range(left, col):
                prefix_top = [0]
                current = 0
                for i in range(row):
                    current_sums[i] += matrix[i][right]
                    current += current_sums[i]
                    target_below = current - k
                    below_index = bisect.bisect_left(prefix_top, target_below)
                    if below_index < len(prefix_top):
                        res = max(res, current - prefix_top[below_index])
                    if res == k:
                        return res
                    bisect.insort(prefix_top, current)
        return res
```

