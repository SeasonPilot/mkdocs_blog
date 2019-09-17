# LeetCode: 718. 最长重复子数组

[TOC]

## 1、题目描述

给两个整数数组 `A` 和 `B` ，返回两个数组中公共的、长度最长的子数组的长度。

**示例 1:**

```
输入:
A: [1,2,3,2,1]
B: [3,2,1,4,7]
输出: 3
解释: 
长度最长的公共子数组是 [3, 2, 1]。
```


**说明:**

- `1 <= len(A), len(B) <= 1000`
- `0 <= A[i], B[i] < 100`



## 2、解题思路

- 使用动态规划
- 初始化

```
dp[i][j] ： 表示从A从i开始和B从j开始最长连续子数组
```

- 状态转换方程

```
if A[i] == B[j]:
	dp[i][j] = dp[i+1][j+1]+1
```



```python
class Solution:
    def findLength(self, A: List[int], B: List[int]) -> int:
        la, lb = len(A), len(B)

        dp = [[0 for _ in range(lb + 1)] for _ in range(la + 1)]

        for i in range(la - 1, -1, -1):
            for j in range(lb - 1, -1, -1):
                if A[i] == B[j]:
                    dp[i][j] = dp[i + 1][j + 1] + 1
        return max(max(row) for row in dp)

```

