# LeetCode: 1175. 质数排列

[TOC]

## 1、题目描述

请你帮忙给从 `1` 到 `n` 的数设计排列方案，使得所有的「质数」都应该被放在「质数索引」（索引从 `1` 开始）上；你需要返回可能的方案总数。

让我们一起来回顾一下「质数」：质数一定是大于 `1` 的，并且不能用两个小于它的正整数的乘积来表示。

由于答案可能会很大，所以请你返回答案 **模 mod** `10^9 + 7` 之后的结果即可。

 

**示例 1：**

```
输入：n = 5
输出：12
解释：举个例子，[1,2,5,4,3] 是一个有效的排列，但 [5,2,3,4,1] 不是，因为在第二种情况里质数 5 被错误地放在索引为 1 的位置上。
```


**示例 2：**

```
输入：n = 100
输出：682289015
```

**提示：**

- `1 <= n <= 100`

## 2、解题思路

- 这道题目主要是将数据分成两部分，由于质数的位置是固定的，因此，分别统计质数和非质数的个数
- 将质数的全排列乘以非质数的全排列即可



```python
class Solution:
    def numPrimeArrangements(self, n: int) -> int:
        mod_num = (10 ** 9) + 7
        total = 101
        perms = [0] * total
        perms[0] = 1
        primes = [0] * total
        primes[0:2] = [1, 1]
        dp = [0] * total

        for i in range(1, total):
            perms[i] = (perms[i - 1] * i) % mod_num

        index = 2
        while index < total:
            while index < total and primes[index] == 1:
                index += 1

            for i in range(index * 2, total, index):
                primes[i] = 1
            index += 1

        sums = 0
        for index, v in enumerate(primes):
            if v == 0:
                sums += 1
            dp[index] = sums

        return (perms[dp[n]] * perms[n - dp[n]]) % mod_num
```

