# LeetCode: 1223. 掷骰子模拟

[TOC]

## 1、题目描述

有一个骰子模拟器会每次投掷的时候生成一个 `1` 到 `6` 的随机数。

不过我们在使用它时有个约束，就是使得投掷骰子时，连续 掷出数字 i 的次数不能超过 `rollMax[i]`（`i` 从 1 开始编号）。

现在，给你一个整数数组 `rollMax` 和一个整数 `n`，请你来计算掷 `n` 次骰子可得到的不同点数序列的数量。

假如两个序列中至少存在一个元素不同，就认为这两个序列是不同的。由于答案可能很大，所以请返回 模 $10^9 + 7$ 之后的结果。

 

**示例 1：**

```
输入：n = 2, rollMax = [1,1,2,2,2,3]
输出：34
解释：我们掷 2 次骰子，如果没有约束的话，共有 6 * 6 = 36 种可能的组合。但是根据 rollMax 数组，数字 1 和 2 最多连续出现一次，所以不会出现序列 (1,1) 和 (2,2)。因此，最终答案是 36-2 = 34。
```


**示例 2：**

```
输入：n = 2, rollMax = [1,1,1,1,1,1]
输出：30
```


**示例 3：**

```
输入：n = 3, rollMax = [1,1,1,2,2,3]
输出：181
```

**提示：**

-   $1 <= n <= 5000$
-   $rollMax.length == 6$
-   $1 <= rollMax[i] <= 15$



## 2、解题思路

-   动态规划

初始化：

```
dp[i][j]: 前面i个骰子，j表示出现的数字 
```

状态转换方程

```
将不连续的数字向前推进，例如有5个骰子，数字1最大连续2
因此，当前数字1所对应的就是
第3个骰子除了1以外的数字总数之和
第4个骰子除了1以外的数字总数之和
```



```python
class Solution:
    def dieSimulator(self, n: int, rollMax: List[int]) -> int:
        mod_num = 1000000007
        dp = [[0] * 6 for _ in range(n)]
        # init
        for j in range(6):
            for i in range(min(n, rollMax[j])):
                dp[i][j] = 1
                
        for i in range(1, n):
            for j in range(6):
                for k in range(1, min(rollMax[j] + 1, i + 1)):
                    for m in range(6):
                        if j != m:
                            dp[i][j] = (dp[i][j] + dp[i - k][m]) % mod_num

        return sum(dp[-1]) % mod_num
```

