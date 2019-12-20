# LeetCode: 487. 最大连续1的个数II

[TOC]

## 1、题目描述

给定一个二进制数组，你可以最多将 `1` 个 `0` 翻转为 `1`，找出其中最大连续 `1` 的个数。

**示例 1：**

```
输入：[1,0,1,1,0]
输出：4
解释：翻转第一个 0 可以得到最长的连续 1。
     当翻转以后，最大连续 1 的个数为 4。
```

**注：**

-   输入数组只包含 `0` 和 `1.`
-   输入数组的长度为正整数，且不超过 `10,000`

**进阶：**
如果输入的数字是作为 **无限流** 逐个输入如何处理？换句话说，内存不能存储下所有从流中输入的数字。您可以有效地解决吗？



## 2、解题思路

-   两个变量存储两段值
    -   `pre_consecutive_ones`：存储直到遇到0的连续1的长度
    -   `reverse_count`：存储当前位置为`0`，加上前面连续`1`的长度的值



```python
class Solution:
    def findMaxConsecutiveOnes(self, nums: List[int]) -> int:
        if not nums:
            return 0
        length = len(nums)
        pre_consecutive_ones = 0
        reverse_count = 0
        ans = 0
        pos = 0
        while pos < length:
            while pos < length:
                if nums[pos] == 1:
                    pre_consecutive_ones += 1
                    pos += 1
                else:
                    break
            ans = max(ans, reverse_count + pre_consecutive_ones)
            reverse_count = pre_consecutive_ones + 1 if pos < length else pre_consecutive_ones
            pre_consecutive_ones = 0
            pos += 1
        ans = max(ans, reverse_count + pre_consecutive_ones)
        return ans
```

