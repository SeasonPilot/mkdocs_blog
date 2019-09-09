# LeetCode: 931. 下降路径最小和

[TOC]

## 1、题目描述

给定一个方形整数数组 `A`，我们想要得到通过 `A` 的下降路径的**最小**和。

下降路径可以从第一行中的任何元素开始，并从每一行中选择一个元素。在下一行选择的元素和当前行所选元素最多相隔一列。

 

**示例：**

```
输入：[[1,2,3],[4,5,6],[7,8,9]]
输出：12
解释：
可能的下降路径有：
[1,4,7], [1,4,8], [1,5,7], [1,5,8], [1,5,9]
[2,4,7], [2,4,8], [2,5,7], [2,5,8], [2,5,9], [2,6,8], [2,6,9]
[3,5,7], [3,5,8], [3,5,9], [3,6,8], [3,6,9]
和最小的下降路径是 [1,4,7]，所以答案是 12。
```

 

**提示：**

- `1 <= A.length == A[0].length <= 100`
- `-100 <= A[i][j] <= 100`



## 2、解题思路

- 动态规划
- 从上往下更新，每次取可选路径中的最小值



```python
from copy import deepcopy
class Solution:
    def minFallingPathSum(self, A: List[List[int]]) -> int:
        row, col = len(A), len(A[0])

        top = [(-1, -1), (-1, 0), (-1, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        dp = deepcopy(A)
        inf = float('inf')
        res = inf
        for i in range(row):
            for j in range(col):
                temp = inf
                for di, dj in top:
                    xi, yj = i + di, j + dj
                    if available(xi, yj):
                        temp = min(temp, dp[xi][yj] + dp[i][j])
                if temp != inf:
                    dp[i][j] = temp
                if i == row - 1:
                    res = min(res, dp[i][j])
        return res
```

