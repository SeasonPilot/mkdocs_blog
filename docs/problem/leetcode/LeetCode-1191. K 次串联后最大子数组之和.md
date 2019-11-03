# LeetCode: 1191. K 次串联后最大子数组之和

[TOC]

## 1、题目描述

给你一个整数数组 `arr` 和一个整数 `k`。

首先，我们要对该数组进行修改，即把原数组 `arr` 重复 `k` 次。

举个例子，如果 `arr = [1, 2]` 且 `k = 3`，那么修改后的数组就是 `[1, 2, 1, 2, 1, 2]`。

然后，请你返回修改后的数组中的最大的子数组之和。

注意，子数组长度可以是 `0`，在这种情况下它的总和也是 `0`。

由于 结果可能会很大，所以需要 模$(mod) 10^9 + 7$ 后再返回。 

 

**示例 1：**

```
输入：arr = [1,2], k = 3
输出：9
```


**示例 2：**

```
输入：arr = [1,-2,1], k = 5
输出：2
```


**示例 3：**

```
输入：arr = [-1,-2], k = 7
输出：0
```

**提示：**

-   $1 <= arr.length <= 10^5$
-   $1 <= k <= 10^5$
-   $-10^4 <= arr[i] <= 10^4$



## 2、解题思路

-   如果循环一次，直接求出最大子数组
-   如果超过2个，中间有循环数组，判断数组和是不是大于0即可
-   求出两个数组延长的最大子数组和，加上中间部分，`k-2`长度的数组和

```python
class Solution:
    def kConcatenationMaxSum(self, arr: List[int], k: int) -> int:
        mod_num = 1000000007

        def get_max(arraylist):
            ans = 0
            max_sum = 0
            for num in arraylist:
                max_sum = num + max(max_sum, 0)
                ans = max(ans, max_sum)
            return ans

        if k == 1:
            return get_max(arr) % mod_num
        else:
            total = sum(arr)
            two_max = get_max(arr * 2)
            if total > 0:
                return (two_max + total * (k - 2)) % mod_num
            else:
                return two_max % mod_num
```

