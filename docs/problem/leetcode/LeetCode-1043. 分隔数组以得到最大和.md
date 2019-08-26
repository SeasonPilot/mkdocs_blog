# LeetCode: 1043. 分隔数组以得到最大和

[TOC]

## 1、题目描述

给出整数数组 A，将该数组分隔为长度最多为 K 的几个（连续）子数组。分隔完成后，每个子数组的中的值都会变为该子数组中的最大值。

返回给定数组完成分隔后的最大和。

 

**示例：**

```
输入：A = [1,15,7,9,2,5,10], K = 3
输出：84
解释：A 变为 [15,15,15,9,10,10,10]
```

**提示：**

- `1 <= K <= A.length <= 500`
- `0 <= A[i] <= 10^6`

## 2、解题思路

- 使用动态规划
- 初始值为0
- 初始化dp数组：
  - 比数组长度多1
- 状态转换方程：
  - `dp[i] = max(dp[i],dp[j]+(i-j)*max_value)`

也就是查找当前节点在分组范围内向前找出最大的结果值

```python
class Solution:
    def maxSumAfterPartitioning(self, A: List[int], K: int) -> int:
        if not A:
            return 0

        N = len(A)
        dp = [0 for _ in range(N + 1)]
        for index in range(1, N + 1):
            max_val = float('-inf')
            for i in range(index-1, index - K-1, -1):
                if i >= 0:
                    max_val = max(max_val, A[i])
                    dp[index] = max(dp[index], dp[i] + (index - i) * max_val)

        return dp[N]

    
```

