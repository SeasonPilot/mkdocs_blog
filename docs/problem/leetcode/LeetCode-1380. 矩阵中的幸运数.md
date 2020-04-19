# LeetCode: 1380. 矩阵中的幸运数

[TOC]

## 1、题目描述

给你一个 `m * n` 的矩阵，矩阵中的数字 **各不相同** 。请你按 **任意** 顺序返回矩阵中的所有幸运数。

幸运数是指矩阵中满足同时下列两个条件的元素：

- 在同一行的所有元素中最小
- 在同一列的所有元素中最大

 

**示例 1：**

```
输入：matrix = [[3,7,8],[9,11,13],[15,16,17]]
输出：[15]
解释：15 是唯一的幸运数，因为它是其所在行中的最小值，也是所在列中的最大值。
```

**示例 2：**

```
输入：matrix = [[1,10,4,2],[9,3,8,7],[15,16,17,12]]
输出：[12]
解释：12 是唯一的幸运数，因为它是其所在行中的最小值，也是所在列中的最大值。
```

**示例 3：**

```
输入：matrix = [[7,8],[1,2]]
输出：[7]
```

 

**提示：**

- `m == mat.length`
- `n == mat[i].length`
- `1 <= n, m <= 50`
- `1 <= matrix[i][j] <= 10^5`
- 矩阵中的所有元素都是不同的



## 2、解题思路

- 针对某个元素进行判断，是幸运数字则将行列进行过滤

```python
from typing import List
from collections import defaultdict


class Solution:
    def luckyNumbers(self, matrix: List[List[int]]) -> List[int]:
        row, col = len(matrix), len(matrix[0])
        rows = set()
        cols = set()
        ans = []
        for i in range(row):
            for j in range(col):
                if i not in rows and j not in cols:
                    row_flag, col_flag = True, True
                    for row_i in range(row):
                        if matrix[i][j] < matrix[row_i][j]:
                            row_flag = False
                            break
                    if not row_flag:
                        continue
                    for col_j in range(col):
                        if matrix[i][j] > matrix[i][col_j]:
                            col_flag = False
                    if row_flag and col_flag:
                        ans.append(matrix[i][j])
                        rows.add(i)
                        cols.add(j)
        return ans


s = Solution()
print(s.luckyNumbers([[3, 7, 8], [9, 11, 13], [15, 16, 17]]))
print(s.luckyNumbers([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]))
print(s.luckyNumbers([[7, 8], [1, 2]]))

```

- 将行中最小值和列中最大值进行与操作（元素各不相同）

```python
class Solution:
    def luckyNumbers(self, A: List[List[int]]) -> List[int]:
        return list({min(row) for row in A} & {max(col) for col in zip(*A)})
```

