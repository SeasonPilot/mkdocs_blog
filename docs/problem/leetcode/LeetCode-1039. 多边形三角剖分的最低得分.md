# LeetCode: 1039. 多边形三角剖分的最低得分

[TOC]

## 1、题目描述

给定 `N`，想象一个凸 `N` 边多边形，其顶点按顺时针顺序依次标记为 `A[0], A[i], ..., A[N-1]`。

假设您将多边形剖分为 `N-2` 个三角形。对于每个三角形，该三角形的值是顶点标记的乘积，三角剖分的分数是进行三角剖分后所有 `N-2` 个三角形的值之和。

返回多边形进行三角剖分后可以得到的最低分。



**示例 1：**

```
输入：[1,2,3]
输出：6
解释：多边形已经三角化，唯一三角形的分数为 6。
```

**示例 2：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-18-021454.png)

```
输入：[3,7,4,5]
输出：144
解释：有两种三角剖分，可能得分分别为：3*7*5 + 4*5*7 = 245，或 3*4*5 + 3*4*7 = 144。最低分数为 144。
```


**示例 3：**

```
输入：[1,3,1,4,1,5]
输出：13
解释：最低分数三角剖分的得分情况为 1*1*3 + 1*1*4 + 1*1*5 + 1*1*1 = 13。
```

**提示：**

-   `3 <= A.length <= 50`
-   `1 <= A[i] <= 100`



## 2、解题思路

-   动态规划

-   初始化：

```
dp[i][j]：表示从第i个到第j个角所形成的三角形的最小面积
```

-   状态转换方程

```
dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j] + A[i] * A[k] * A[j])
```



```python
class Solution:
    def minScoreTriangulation(self, A: List[int]) -> int:
        length = len(A)
        inf = float('inf')
        dp = [[inf for _ in range(length)] for _ in range(length)]

        for i in range(length - 1):
            dp[i][i + 1] = 0

        for d in range(2, length):
            for i in range(0, length - d):
                j = i + d
                for k in range(i + 1, j):
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j] + A[i] * A[k] * A[j])

        return dp[0][length - 1]
```

-   DFS加记忆化

主要是子问题的切分，dfs更容易理解一些

```python
from functools import lru_cache


class Solution:
    def minScoreTriangulation(self, A: List[int]) -> int:
        @lru_cache(None)
        def dfs(left, right):
            if left + 1 == right:
                return 0
            ans = float('inf')
            for k in range(left + 1, right):
                ans = min(ans, dfs(left, k) + dfs(k, right) + A[left] * A[k] * A[right])

            return ans

        return dfs(0, len(A) - 1)
```

