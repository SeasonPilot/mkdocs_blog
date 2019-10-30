# LeetCode: 918. 环形子数组的最大和

[TOC]

## 1、题目描述

给定一个由整数数组 `A` 表示的环形数组 `C`，求 `C` 的非空子数组的最大可能和。

在此处，环形数组意味着数组的末端将会与开头相连呈环状。（形式上，当`0 <= i < A.length 时 C[i] = A[i]`，而当 `i >= 0` 时 `C[i+A.length] = C[i]`）

此外，子数组最多只能包含固定缓冲区 `A` 中的每个元素一次。（形式上，对于子数组 `C[i], C[i+1], ..., C[j]`，不存在 `i <= k1, k2 <= j` 其中 `k1 % A.length = k2 % A.length`）

 

**示例 1：**

```
输入：[1,-2,3,-2]
输出：3
解释：从子数组 [3] 得到最大和 3
```


**示例 2：**

```
输入：[5,-3,5]
输出：10
解释：从子数组 [5,5] 得到最大和 5 + 5 = 10
```


**示例 3：**

```
输入：[3,-1,2,-1]
输出：4
解释：从子数组 [2,-1,3] 得到最大和 2 + (-1) + 3 = 4
```


**示例 4：**

```
输入：[3,-2,2,-3]
输出：3
解释：从子数组 [3] 和 [3,-2,2] 都可以得到最大和 3
```


**示例 5：**

```
输入：[-2,-3,-1]
输出：-1
解释：从子数组 [-1] 得到最大和 -1
```

**提示：**

-   $-30000 <= A[i] <= 30000$
-   $1 <= A.length <= 30000$



## 2、解题思路

-   一共有两种情况，一种是单区间最大，也就是直接利用`Kadane`算法

```python
# Kadane 算法
ans = cur = None
for x in A:
    cur = x + max(cur, 0)
    ans = max(ans, cur)
return ans
# buduan 不断地找出对后续增益最大的位置，向后更新
```

环形数组还需要考虑一种，首尾相加的情况，这里采用找出中间最小值，用整体和值减去的方式



```python
class Solution:
    def maxSubarraySumCircular(self, A: List[int]) -> int:
        total = sum(A)
        ans = A[0]
        res = ans
        for num in A[1:]:
            ans = num + max(ans, 0)
            res = max(res, ans)

        ans1 = A[1]
        cur = float('inf')
        for num in A[2:]:
            ans1 = num + min(ans1, 0)
            cur = min(cur, ans1)
        res = max(res, total - cur)

        ans2 = A[0]
        cur = float('inf')
        for num in A[1:-1]:
            ans2 = num + min(ans2, 0)
            cur = min(cur, ans2)
        res = max(res, total - cur)

        return res
```

