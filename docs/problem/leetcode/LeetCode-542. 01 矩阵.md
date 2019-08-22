# LeetCode: 542. 01 矩阵

[TOC]

## 1、题目描述

给定一个由 0 和 1 组成的矩阵，找出每个元素到最近的 0 的距离。

两个相邻元素间的距离为 1 。

**示例 1:** 

```
输入:

0 0 0
0 1 0
0 0 0
输出:

0 0 0
0 1 0
0 0 0
```

**示例 2:** 

```
输入:

0 0 0
0 1 0
1 1 1
输出:

0 0 0
0 1 0
1 2 1
```



**注意:**

- 给定矩阵的元素个数不超过 10000。

- 给定矩阵中至少有一个元素是 0。

- 矩阵中的元素只在四个方向上相邻: 上、下、左、右。

## 2、解题思路

- 分两步进行更新
- 首先从左上角进行更新，将左方和上方中路径较小的进行更新
- 然后从右下角进行更新，比较当前值，右方，下方



```python
class Solution:
    def updateMatrix(self, matrix: List[List[int]]) -> List[List[int]]:
        
        row = len(matrix)
        col = len(matrix[0])
        total = row * col
        for i in range(row):
            for j in range(col):
                if matrix[i][j] != 0:

                    left, top = total, total
                    if i > 0: top = matrix[i - 1][j]
                    if j > 0: left = matrix[i][j - 1]
                    matrix[i][j] = min(left, top) + 1

        for i in range(row - 1, -1, -1):
            for j in range(col - 1, -1, -1):
                if matrix[i][j] != 0:

                    bottom, right = total, total
                    if i < row - 1: bottom = matrix[i + 1][j]
                    if j < col - 1: right = matrix[i][j + 1]
                    matrix[i][j] = min(matrix[i][j], bottom + 1, right + 1)

        return matrix
```

