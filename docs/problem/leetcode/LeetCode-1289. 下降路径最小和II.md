# LeetCode: 1289. 下降路径最小和II

[TOC]

## 1、题目描述

给你一个整数方阵 `arr` ，定义「非零偏移下降路径」为：从 `arr` 数组中的每一行选择一个数字，且按顺序选出来的数字中，相邻数字不在原数组的同一列。

请你返回非零偏移下降路径数字和的最小值。

 

**示例 1：**

```
输入：arr = [[1,2,3],[4,5,6],[7,8,9]]
输出：13
解释：
所有非零偏移下降路径包括：
[1,5,9], [1,5,7], [1,6,7], [1,6,8],
[2,4,8], [2,4,9], [2,6,7], [2,6,8],
[3,4,8], [3,4,9], [3,5,7], [3,5,9]
下降路径中数字和最小的是 [1,5,7] ，所以答案是 13 。
```

**提示：**

-   $1 <= arr.length == arr[i].length <= 200$
-   $-99 <= arr[i][j] <= 99$



## 2、解题思路

-   动态规划

```
dp[i][j] 表示从第一层开始到当前层的当前节点能够取得的最小值

从第二层开始更新即可

for i in range(1, row):
            for j in range(col):
                dp[i][j] = min(dp[i - 1][:j] + dp[i - 1][j + 1:]) + arr[i][j]
```



```python
class Solution:
    def minFallingPathSum(self, arr: List[List[int]]) -> int:
        row, col = len(arr), len(arr[0])
        inf = float('inf')
        dp = [[inf for _ in range(col)] for _ in range(row)]

        dp[0] = arr[0][:]

        for i in range(1, row):
            for j in range(col):
                dp[i][j] = min(dp[i - 1][:j] + dp[i - 1][j + 1:]) + arr[i][j]

        return min(dp[-1])
```

