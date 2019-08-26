# LeetCode: 647. 回文子串

[TOC]

## 1、题目描述

给定一个字符串，你的任务是计算这个字符串中有多少个回文子串。

具有不同开始位置或结束位置的子串，即使是由相同的字符组成，也会被计为是不同的子串。

**示例 1:**

```
输入: "abc"
输出: 3
解释: 三个回文子串: "a", "b", "c".

```

**示例 2:**

```
输入: "aaa"
输出: 6
说明: 6个回文子串: "a", "a", "a", "aa", "aa", "aaa".

```

**注意:**

- 输入的字符串长度不会超过1000。

## 2、解题思路

- Manacher马拉车匹配算法



```python
class Solution:
    def countSubstrings(self, s: str) -> int:
        new_s = "#" + "#".join(s) + "#"

        res = 0

        mid, right = 0, 0
        p = [0] * len(new_s)
        for i in range(len(new_s)):
            p[i] = min(right - i + 1, p[2 * mid - i]) if right > i else 1
            while p[i] + i < len(new_s) and i - p[i] >= 0:
                if new_s[p[i] + i] == new_s[i - p[i]]:
                    p[i] += 1
                else:
                    break
            if p[i] + i - 1 > right:
                right = p[i] + i - 1
                mid = i
            res += p[i] // 2

        return res
```

