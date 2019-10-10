# LeetCode: 813. 最大平均值和的分组

[TOC]

## 1、题目描述

我们将给定的数组 `A` 分成 `K` 个相邻的非空子数组 ，我们的分数由每个子数组内的平均值的总和构成。计算我们所能得到的最大分数是多少。

注意我们必须使用 `A` 数组中的每一个数进行分组，并且分数不一定需要是整数。

**示例:**

```
输入: 
A = [9,1,2,3,9]
K = 3
输出: 20
解释: 
A 的最优分组是[9], [1, 2, 3], [9]. 得到的分数是 9 + (1 + 2 + 3) / 3 + 9 = 20.
我们也可以把 A 分成[9, 1], [2], [3, 9].
这样的分组得到的分数为 5 + 2 + 6 = 13, 但不是最大值.
```



**说明:**

-   `1 <= A.length <= 100.`
-   `1 <= A[i] <= 10000.`
-   `1 <= K <= A.length.`
-   `答案误差在 10^-6 内被视为是正确的。`



## 2、解题思路

-   动态规划

初始化：

```
dp[i][k]  表示前面i个数字分割成k组的最大平均值
```

状态转换方程：

```
for j in range(i):
    dp[i][k] = max(dp[i][k], dp[j][k - 1] + (sums[i] - sums[j]) / (i - j))

前向更新，利用前面的元素更新当前最大值
```



```python
class Solution:
    def largestSumOfAverages(self, A: List[int], K: int) -> float:
        if K == 1:
            return sum(A) / len(A)

        if len(A) == K:
            return float(sum(A))

        length = len(A)
        dp = [[0.0 for _ in range(K + 1)] for _ in range(length + 1)]
        sums = [0] * (length + 1)
        for i in range(1, length + 1):
            sums[i] = sums[i - 1] + A[i - 1]
            dp[i][1] = sums[i] / i

        for i in range(1, length + 1):
            for k in range(2, K + 1):
                for j in range(i):
                    dp[i][k] = max(dp[i][k], dp[j][k - 1] + (sums[i] - sums[j]) / (i - j))
        return dp[length][K]
```

