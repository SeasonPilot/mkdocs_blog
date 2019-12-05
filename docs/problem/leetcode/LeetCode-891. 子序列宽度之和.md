# LeetCode: 891. 子序列宽度之和

[TOC]

## 1、题目描述

给定一个整数数组 `A` ，考虑 `A` 的所有非空子序列。

对于任意序列 `S` ，设 `S` 的宽度是 `S` 的最大元素和最小元素的差。

返回 `A` 的所有子序列的宽度之和。

由于答案可能非常大，请返回答案模 $10^9+7$。

 

**示例：**

```
输入：[2,1,3]
输出：6
解释：
子序列为 [1]，[2]，[3]，[2,1]，[2,3]，[1,3]，[2,1,3] 。
相应的宽度是 0，0，0，1，1，2，2 。
这些宽度之和是 6 。
```

**提示：**

-   $1 <= A.length <= 20000$
-   $1 <= A[i] <= 20000$



## 2、解题思路

-   首先进行排序
-   对每一个数字，如果这个数字是子序列的左边界，就需要减去这个数字，如果是右边界，就加上这个数字
-   因此，对每个数字找出所有可能的作为左边界的数量，作为右边界的数量

```
ans = (ans + num * (left_count - right_count)) % 1000000007
```

例如做右边界，也就相当于是做当前数字的左方，取0个元素，1个元素，一直到左边所有元素都取到的组合数之和，就等于`2^index`

因此，可以先将这些数字计算出来备用，如果这个数字已经超过了`1000000007`，直接取余即可



```python
class Solution:
    def sumSubseqWidths(self, A: List[int]) -> int:
        
        mod_num = 1000000007

        A.sort()
        ans = 0
        length = len(A)

        power = [1] * length
        for i in range(1, length):
            power[i] = power[i - 1] * 2 % mod_num
            
        for index, num in enumerate(A):
            ans = (ans + num * (power[index] - power[length - index - 1])) % mod_num
        return ans
```

