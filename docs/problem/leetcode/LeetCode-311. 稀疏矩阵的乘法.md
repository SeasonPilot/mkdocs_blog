# LeetCode: 311. 稀疏矩阵的乘法

[TOC]

## 1、题目描述

给定两个 稀疏矩阵 `A` 和 `B`，请你返回 `AB`。你可以默认 `A` 的列数等于 `B` 的行数。

请仔细阅读下面的示例。

**示例：**

```
输入:

A = [
  [ 1, 0, 0],
  [-1, 0, 3]
]

B = [
  [ 7, 0, 0 ],
  [ 0, 0, 0 ],
  [ 0, 0, 1 ]
]

输出:

     |  1 0 0 |   | 7 0 0 |   |  7 0 0 |
AB = | -1 0 3 | x | 0 0 0 | = | -7 0 3 |
                  | 0 0 1 |

```

## 2、解题思路

-   将稀疏矩阵的非零元素取出，根据行和列中非零元素的多少选择依据谁来进行计算



```python
from collections import defaultdict


class Solution:
    def multiply(self, A: List[List[int]], B: List[List[int]]) -> List[List[int]]:
        a_row, a_col, b_row, b_col = len(A), len(A[0]), len(B), len(B[0])

        ad = defaultdict(dict)
        bd = defaultdict(dict)
        ans = [[0 for _ in range(b_col)] for _ in range(a_row)]

        for i in range(a_row):
            for j in range(a_col):
                if A[i][j] != 0:
                    ad[i][(i, j)] = A[i][j]
        for i in range(b_row):
            for j in range(b_col):
                if B[i][j] != 0:
                    bd[j][(i, j)] = B[i][j]

        for i in range(a_row):
            for j in range(b_col):
                if not ad[i] or not bd[j]:
                    continue
                current = 0
                if len(ad[i]) < len(bd[j]):
                    for (x, y), v in ad[i].items():
                        if (y, j) in bd[j]:
                            current += v * bd[j][(y, j)]
                else:
                    for (x, y), v in bd[j].items():
                        if (i, x) in ad[i]:
                            current += v * ad[i][(i, x)]
                ans[i][j] = current
        return ans
```

