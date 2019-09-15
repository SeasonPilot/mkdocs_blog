# LeetCode: 1004. 最大连续1的个数 III

[TOC]

## 1、题目描述

给定一个由若干 `0` 和 `1` 组成的数组 `A`，我们最多可以将 `K` 个值从 `0` 变成 `1` 。

返回仅包含 `1` 的最长（连续）子数组的长度。

 

**示例 1：**

```
输入：A = [1,1,1,0,0,0,1,1,1,1,0], K = 2
输出：6
解释： 
[1,1,1,0,0,1,1,1,1,1,1]
粗体数字从 0 翻转到 1，最长的子数组长度为 6。
```


**示例 2：**

```
输入：A = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], K = 3
输出：10
解释：
[0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
粗体数字从 0 翻转到 1，最长的子数组长度为 10。
```

**提示：**

- `1 <= A.length <= 20000`
- `0 <= K <= A.length`
- `A[i] 为 0 或 1` 



## 2、解题思路

- 滑动窗口，双指针

- 设置一个窗口，保证窗口中的0的数量小于等于K，更新结果即可



```python
class Solution:
    def longestOnes(self, A: List[int], K: int) -> int:
        count_zeros = 0
        left = 0
        res = 0
        for index, num in enumerate(A):
            if num == 0:
                count_zeros += 1
            if count_zeros > K:

                while A[left] != 0:
                    left += 1
                left += 1
                count_zeros -= 1
            res = max(res, index - left + 1)

        return res
```

