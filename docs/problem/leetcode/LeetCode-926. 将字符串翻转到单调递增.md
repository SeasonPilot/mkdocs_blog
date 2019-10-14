# LeetCode: 926. 将字符串翻转到单调递增

[TOC]

## 1、题目描述

如果一个由 `'0'` 和 `'1'` 组成的字符串，是以一些 `'0'`（可能没有 `'0'`）后面跟着一些 `'1'`（也可能没有 `'1'`）的形式组成的，那么该字符串是单调递增的。

我们给出一个由字符 `'0'` 和 `'1'` 组成的字符串 `S`，我们可以将任何 `'0'` 翻转为 `'1'` 或者将 `'1'` 翻转为 `'0'`。

返回使 `S` 单调递增的最小翻转次数。

 

**示例 1：**

```
输入："00110"
输出：1
解释：我们翻转最后一位得到 00111.
```


**示例 2：**

```
输入："010110"
输出：2
解释：我们翻转得到 011111，或者是 000111。
```


**示例 3：**

```
输入："00011000"
输出：2
解释：我们翻转得到 00000000。
```

**提示：**

-   `1 <= S.length <= 20000`
-   `S 中只包含字符 '0' 和 '1'`



## 2、解题思路

-   可以看成有一条分界线，在这条线的左边都变为0，右边都变成1
-   统计左侧0的数量和右侧1的数量，就能计算出得到当前结果需要转换的次数



```python
class Solution:
    def minFlipsMonoIncr(self, S: str) -> int:
        length = len(S)
        ans = length
        left_zeros = [0] * (length + 1)
        right_ones = [0] * (length + 1)

        for index, ch in enumerate(S):
            if ch == "0":
                left_zeros[index + 1] = left_zeros[index] + 1
            else:
                left_zeros[index + 1] = left_zeros[index]

        for index, ch in enumerate(reversed(S)):
            if ch == "1":
                right_ones[index + 1] = right_ones[index] + 1
            else:
                right_ones[index + 1] = right_ones[index]

        for i in range(length + 1):
            ans = min(ans, length - left_zeros[i] - right_ones[length - i])

        return ans
```

