# LeetCode: 910. 最小差值 II

[TOC]

## 1、题目描述

给定一个整数数组 A，对于每个整数 `A[i]`，我们可以选择 `x = -K` 或是 `x = K`，并将 `x` 加到 `A[i]` 中。

在此过程之后，我们得到一些数组 `B`。

返回 `B` 的最大值和 `B` 的最小值之间可能存在的最小差值。

 

**示例 1：**

```
输入：A = [1], K = 0
输出：0
解释：B = [1]
```


**示例 2：**

```
输入：A = [0,10], K = 2
输出：6
解释：B = [2,8]
```


**示例 3：**

```
输入：A = [1,3,6], K = 3
输出：3
解释：B = [4,6,3]
```

**提示：**

-   $1 <= A.length <= 10000$
-   $0 <= A[i] <= 10000$
-   $0 <= K <= 10000$



## 2、解题思路

-   先排序
-    `A[0] + K, A[i] + K, A[i+1] - K, A[A.length - 1] - K`找出结果



```python
class Solution:
    def smallestRangeII(self, A: List[int], K: int) -> int:
        A.sort()

        min_val, max_val = A[0], A[-1]
        ans = max_val - min_val
        for i in range(len(A) - 1):
            ans = min(ans, max(max_val - K, A[i] + K) - min(A[i + 1] - K, min_val + K))

        return ans
```

