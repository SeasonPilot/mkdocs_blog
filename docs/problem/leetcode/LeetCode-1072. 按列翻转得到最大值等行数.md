# LeetCode: 1072. 按列翻转得到最大值等行数

[TOC]

## 1、题目描述

给定由若干 `0` 和 `1` 组成的矩阵 `matrix`，从中选出任意数量的列并翻转其上的 每个 单元格。翻转后，单元格的值从 `0` 变成 `1`，或者从 `1` 变为 `0` 。

返回经过一些翻转后，行上所有值都相等的最大行数。

 

**示例 1：**

```
输入：[[0,1],[1,1]]
输出：1
解释：不进行翻转，有 1 行所有值都相等。
```


**示例 2：**

```
输入：[[0,1],[1,0]]
输出：2
解释：翻转第一列的值之后，这两行都由相等的值组成。
```


**示例 3：**

```
输入：[[0,0,0],[0,0,1],[1,1,0]]
输出：2
解释：翻转前两列的值之后，后两行由相等的值组成。
```

**提示：**

-   `1 <= matrix.length <= 300`
-   `1 <= matrix[i].length <= 300`
-   `所有 matrix[i].length 都相等`
-   `matrix[i][j] 为 0 或 1`



## 2、解题思路

-   题目的关键点在于如何判断两行通过列取反操作就能得到一行全部相同
    -   两行相同
    -   两行相反
-   因此，直接用当前行的字符串作为键，取反作为键，统计整个数组中出现的最高频率状态即可



```python
from collections import defaultdict


class Solution:
    def maxEqualRowsAfterFlips(self, matrix: List[List[int]]) -> int:
        count_map = defaultdict(int)

        for row in matrix:
            key = "".join([str(x) for x in row])
            reverse_key = "".join([str(x ^ 1) for x in row])
            count_map[key] += 1
            count_map[reverse_key] += 1
        return max(count_map.values())
```

