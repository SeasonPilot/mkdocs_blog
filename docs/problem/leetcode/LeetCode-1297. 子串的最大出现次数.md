# LeetCode: 1297. 子串的最大出现次数

[TOC]

## 1、题目描述

给你一个字符串 `s` ，请你返回满足以下条件且出现次数最大的 任意 子串的出现次数：

-   子串中不同字母的数目必须小于等于 `maxLetters` 。
-   子串的长度必须大于等于 `minSize` 且小于等于 `maxSize` 。

**示例 1：**

```
输入：s = "aababcaab", maxLetters = 2, minSize = 3, maxSize = 4
输出：2
解释：子串 "aab" 在原字符串中出现了 2 次。
它满足所有的要求：2 个不同的字母，长度为 3 （在 minSize 和 maxSize 范围内）。
```


**示例 2：**

```
输入：s = "aaaa", maxLetters = 1, minSize = 3, maxSize = 3
输出：2
解释：子串 "aaa" 在原字符串中出现了 2 次，且它们有重叠部分。
```


**示例 3：**

```
输入：s = "aabcabcab", maxLetters = 2, minSize = 2, maxSize = 3
输出：3
```


**示例 4：**

```
输入：s = "abcde", maxLetters = 2, minSize = 3, maxSize = 3
输出：0
```

**提示：**

-   $1 <= s.length <= 10^5$
-   $1 <= maxLetters <= 26$
-   $1 <= minSize <= maxSize <= min(26, s.length)$
-   `s` 只包含小写英文字母。



## 2、解题思路

-   题目的要求说明不明显

```
例如
aaa
能够分为 两个aa连续子串
```

由于比`minSize`大的串肯定能够包含这个小的串，因此直接以小的串进行计算



```python
from collections import defaultdict


class Solution:
    def maxFreq(self, s: str, maxLetters: int, minSize: int, maxSize: int) -> int:
        count = defaultdict(int)
        length = len(s)
        for i in range(length - minSize + 1):
            current = s[i:i + minSize]
            if len(set(current)) <= maxLetters:
                count[current] += 1
        return max(count.values()) if count else 0

```

