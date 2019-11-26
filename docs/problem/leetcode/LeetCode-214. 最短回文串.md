# LeetCode: 214. 最短回文串

[TOC]

## 1、题目描述

给定一个字符串 `s`，你可以通过在字符串前面添加字符将其转换为回文串。找到并返回可以用这种方式转换的最短回文串。

**示例 1:**

```
输入: "aacecaaa"
输出: "aaacecaaa"
```


**示例 2:**

```
输入: "abcd"
输出: "dcbabcd"
```



## 2、解题思路

-   使用Manacher算法，从前向后找，找到最长的能够包含第一个字符的回文串，然后将剩余部分反转补齐到最前方



```python
class Solution:
    def shortestPalindrome(self, s: str) -> str:

        if len(s) == 0: return ""
        s_new = '#' + '#'.join(s) + '#'

        # 最大右边界
        mx = 0
        # 中心点
        mid = 0

        l = len(s_new)
        p = [1] * l

        for i in range(l // 2 + 1):
            if i < mx:
                p[i] = min(mx - i, p[2 * mid - i])

            while (i - p[i] >= 0 and i + p[i] < l and s_new[i - p[i]] == s_new[i + p[i]]):
                p[i] += 1

            if i + p[i] > mx:
                mx = i + p[i]
                mid = i
        ans = [0, 0]
        for index, num in enumerate(p):
            if index + 1 == num:
                if index % 2:
                    ans = [index // 2, 1]
                else:
                    ans = [index // 2, 0]
        if not ans[1]:
            return "".join(reversed(s[2 * ans[0]:])) + s
        else:
            return "".join(reversed(s[2 * ans[0] + 1:])) + s

```

