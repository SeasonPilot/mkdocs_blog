# LeetCode: 1314. 矩阵区域和

[TOC]

## 1、题目描述

给你一个 `m * n` 的矩阵 mat 和一个整数 `K` ，请你返回一个矩阵 `answer` ，其中每个 `answer[i][j]` 是所有满足下述条件的元素 `mat[r][c]` 的和： 

-   $i - K <= r <= i + K, j - K <= c <= j + K$ 
-   `(r, c)` 在矩阵内。



**示例 1：**

```
输入：mat = [[1,2,3],[4,5,6],[7,8,9]], K = 1
输出：[[12,21,16],[27,45,33],[24,39,28]]
```


**示例 2：**

```
输入：mat = [[1,2,3],[4,5,6],[7,8,9]], K = 2
输出：[[45,45,45],[45,45,45],[45,45,45]]
```

**提示：**

-   $m == mat.length$
-   $n == mat[i].length$
-   $1 <= m, n, K <= 100$
-   $1 <= mat[i][j] <= 100$



## 2、解题思路

-   动态规划
-   首先计算当前节点到左上角的节点的矩形之和
-   计算每个节点形成的矩形的四个节点，使用矩形相交计算即可



```python
class Solution:
    def matrixBlockSum(self, mat: List[List[int]], K: int) -> List[List[int]]:
        row, col = len(mat), len(mat[0])
        sums = [[0 for _ in range(col + 2)] for _ in range(row + 2)]
        total = 0

        for i in range(row):
            for j in range(col):
                sums[i + 1][j + 1] = sums[i][j + 1] + sums[i + 1][j] - sums[i][j] + mat[i][j]

        ans = [[0 for _ in range(col)] for _ in range(row)]
        for i in range(row):
            for j in range(col):
                left_up = [max(i - K, 0), max(j - K, 0)]
                left_bottom = [min(row - 1, i + K), max(j - K, 0)]
                right_up = [max(i - K, 0), min(col - 1, j + K)]
                right_bottom = [min(row - 1, i + K), min(col - 1, j + K)]
                ans[i][j] = sums[left_up[0]][left_up[1]] - sums[left_bottom[0] + 1][left_bottom[1]] - sums[right_up[0]][right_up[1] + 1] + \
                            sums[right_bottom[0] + 1][right_bottom[1] + 1]
        return ans
```

