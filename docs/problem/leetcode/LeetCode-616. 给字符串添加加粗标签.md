# LeetCode: 616. 给字符串添加加粗标签

[TOC]

## 1、题目描述

给一个字符串 `s` 和一个字符串列表 `dict` ，你需要将在字符串列表中出现过的 `s` 的子串添加加粗闭合标签 `<b>` 和 `</b>` 。如果两个子串有重叠部分，你需要把它们一起用一个闭合标签包围起来。同理，如果两个子字符串连续被加粗，那么你也需要把它们合起来用一个加粗标签包围。

**样例 1：**

```
输入：
s = "abcxyz123"
dict = ["abc","123"]
输出：
"<b>abc</b>xyz<b>123</b>"
```

**样例 2：**

```
输入：
s = "aaabbcc"
dict = ["aaa","aab","bc"]
输出：
"<b>aaabbc</b>c"
```

**注意：**

-   给定的 `dict` 中不会有重复的字符串，且字符串数目不会超过 `100` 。
-   输入中的所有字符串长度都在范围 `[1, 1000]` 内。



## 2、解题思路

-   标记法
-   先标记能够加粗的部分，然后对应到源字符串中



```python
from itertools import groupby


class Solution:
    def addBoldTag(self, s: str, dict: List[str]) -> str:
        length = len(s)
        mark = [0] * length
        for d in dict:
            pos = 0
            cur_len = len(d)
            while pos < length and d in s[pos:]:
                index = s[pos:].index(d)
                mark[pos + index:pos + index + cur_len] = [1] * cur_len
                pos += 1
        ans = []
        pos = 0
        for k, val in groupby(mark):
            cur_len = len(list(val))
            if k == 0:
                ans.append(s[pos:pos + cur_len])
            else:
                ans.append("<b>")
                ans.append(s[pos:pos + cur_len])
                ans.append("</b>")
            pos += cur_len
        return "".join(ans)
```

