# LeetCode: 494. 目标和

[TOC]

## 1、题目描述

给定一个非负整数数组，a1, a2, ..., an, 和一个目标数，S。现在你有两个符号 + 和 -。对于数组中的任意一个整数，你都可以从 + 或 -中选择一个符号添加在前面。

返回可以使最终数组和为目标数 S 的所有添加符号的方法数。

**示例 1:**

```
输入: nums: [1, 1, 1, 1, 1], S: 3
输出: 5
解释: 

-1+1+1+1+1 = 3
+1-1+1+1+1 = 3
+1+1-1+1+1 = 3
+1+1+1-1+1 = 3
+1+1+1+1-1 = 3

一共有5种方法让最终目标和为3。
```



**注意:**

- 数组的长度不会超过20，并且数组中的值全为正数。

- 初始的数组的和不会超过1000。

- 保证返回的最终结果为32位整数。

## 2、解题思路

- DFS+记忆优化

- 使用dfs遍历所有的方式

- 如果在同一个位置并且已经得到了相同的目标值，那么就将这种情况记录下

  

```python
class Solution:
    def findTargetSumWays(self, nums: List[int], S: int) -> int:
        if not nums or sum(nums) < S:
            return 0

        d = {}

        def dfs(pos, target):

            if pos < len(nums) and (pos, target) not in d:
                d[(pos, target)] = dfs(pos + 1, target + nums[pos]) + dfs(pos + 1, target - nums[pos])
            return d.get((pos, target), int(target == S))

        return dfs(0, 0)
```



- 转化为01背包问题

最终数组中通过添加符号，将所有的数字分成两部分，一部分都是正数，一部分都是负数，正数看成集合P，负数看成集合N
$$
\begin{align} 
sum(P)+sum(N) &=target \\
sum(nums) + sum(P)+sum(N) &= target + sum(nums)\\
2*sum(P)  &=  target + sum(nums)\\
sum(P) &= \frac{target + sum(nums)}{2}

\end{align}
$$
如上所示，将上面的结果转变为从数组中找出多个数字和的组合，得到 $sum(P)$ 

```python
class Solution:
    def findTargetSumWays(self, nums: List[int], S: int) -> int:
        if not nums or sum(nums) < S or (S + sum(nums)) % 2:
            return 0

        p = (S + sum(nums)) // 2
        dp = [1] + [0] * p
        for num in nums:
            for i in range(p, num - 1, -1):
                dp[i] += dp[i - num]
        return dp[p]
    
```

