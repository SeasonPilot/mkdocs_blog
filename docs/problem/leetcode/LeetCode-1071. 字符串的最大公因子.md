# LeetCode: 1071. 字符串的最大公因子

[TOC]

## 1、题目描述

对于字符串 `S` 和` T`，只有在 `S = T + ... + T`（`T` 与自身连接` 1 `次或多次）时，我们才认定` “T 能除尽 S”`。

返回字符串 `X`，要求满足` X` 能除尽` str1` 且` X` 能除尽` str2`。

```
 示例 1：
输入：str1 = "ABCABC", str2 = "ABC"
输出："ABC"

示例 2：
输入：str1 = "ABABAB", str2 = "ABAB"
输出："AB"

示例 3：
输入：str1 = "LEET", str2 = "CODE"
输出：""
```



**提示：**

-  $1 <= str1.length <= 1000$ 

-  $1 <= str2.length <= 1000$ 

-  `str1[i] ` 和 ` str2[i]` 为大写英文字母



## 2、解题思路

- 求出两个字符串的最大公约数
- 判断最大公约数所代表的的字符串是否相等
- 判断两个字符串是否能够使用最大公约数所代表的的字符串循环构成

```python
import math


class Solution:
    def gcdOfStrings(self, str1: str, str2: str) -> str:
        g = math.gcd(len(str1), len(str2))

        if str1[:g] == str2[:g] and str1 == str1[:g] * (len(str1) // g) and str2 == str2[:g] * (len(str2) // g):
            return str1[:g]
        return ""

```

