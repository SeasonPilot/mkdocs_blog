# LeetCode: 159. 至多包含两个不同字符的最长子串

[TOC]

## 1、题目描述

给定一个字符串 `s` ，找出 至多 包含两个不同字符的最长子串 `t` 。

**示例 1:**

```
输入: "eceba"
输出: 3
解释: t 是 "ece"，长度为3。
```


**示例 2:**

```
输入: "ccaabbb"
输出: 5
解释: t 是 "aabbb"，长度为5。
```



## 2、解题思路

-   双指针，字典计数，统计双指针之间的字符数量，保证每次都满足条件即可



```python
class Solution:
    def lengthOfLongestSubstringTwoDistinct(self, s: str) -> int:
        if not s:
            return 0
        chars = {}
        length = len(s)
        left = 0
        right = 0
        ans = 0
        while right < length:
            chars.setdefault(s[right], 0)
            chars[s[right]] += 1
            while len(chars) > 2:
                chars[s[left]] -= 1
                if chars[s[left]] == 0:
                    chars.pop(s[left])
                left += 1
            ans = max(ans, right - left + 1)
            right += 1
        return ans
```

