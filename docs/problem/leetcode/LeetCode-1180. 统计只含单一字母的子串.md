# LeetCode: 1180. 统计只含单一字母的子串

[TOC]

## 1、题目描述

给你一个字符串 `S`，返回只含 单一字母 的子串个数。

**示例 1：**

```
输入： "aaaba"
输出： 8
解释： 
只含单一字母的子串分别是 "aaa"， "aa"， "a"， "b"。
"aaa" 出现 1 次。
"aa" 出现 2 次。
"a" 出现 4 次。
"b" 出现 1 次。
所以答案是 1 + 2 + 4 + 1 = 8。
```

**示例 2:**

```
输入： "aaaaaaaaaa"
输出： 55
```

**提示：**

-   $1 <= S.length <= 1000$
-   `S[i]` 仅由小写英文字母组成。



## 2、解题思路

-   首先分组，相同字母的子串放在一起

```
例如 aaabb

前面的aaa能够得到的子串为：
a   *3
aa  *2
aaa *1

count = length * (length + 1) / 2
```

分组统计即可



```python
from itertools import groupby


class Solution:
    def countLetters(self, S: str) -> int:
        ans = 0

        for key, vals in groupby(S):
            l = len(list(vals))
            ans += l * (l + 1) // 2

        return ans

```

