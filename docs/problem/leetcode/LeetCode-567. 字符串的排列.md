# LeetCode: 567. 字符串的排列

[TOC]

## 1、题目描述

给定两个字符串 `s1` 和 `s2`，写一个函数来判断 `s2` 是否包含 `s1` 的排列。

换句话说，第一个字符串的排列之一是第二个字符串的子串。

**示例1:**

```
输入: s1 = "ab" s2 = "eidbaooo"
输出: True
解释: s2 包含 s1 的排列之一 ("ba").
```

**示例2:**

```
输入: s1= "ab" s2 = "eidboaoo"
输出: False
```

**注意：**

- `输入的字符串只包含小写字母`
- `两个字符串的长度都在 [1, 10,000] 之间`



## 2、解题思路

- 因为只有26个小写字母，只要s2中有一段连续的字符串每个字符出现的次数与s1相同即可



```python
class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        from collections import Counter

        l1, l2 = len(s1), len(s2)

        if l2 < l1:
            return False

        s1_c = [0] * 26
        for char, num in Counter(s1).items():
            s1_c[ord(char) - ord('a')] = num

        s2_windows = [0] * 26
        for char, num in Counter(s2[:l1]).items():
            s2_windows[ord(char) - ord('a')] = num

        if s1_c == s2_windows:
            return True
        for i in range(l1, l2):
            s2_windows[ord(s2[i]) - ord('a')] += 1
            s2_windows[ord(s2[i - l1]) - ord('a')] -= 1
            if s1_c == s2_windows:
                return True

        return False
```

