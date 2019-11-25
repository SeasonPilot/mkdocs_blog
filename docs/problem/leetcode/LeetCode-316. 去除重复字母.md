# LeetCode: 316. 去除重复字母

[TOC]

## 1、题目描述

给定一个仅包含小写字母的字符串，去除字符串中重复的字母，使得每个字母只出现一次。需保证返回结果的字典序最小（要求不能打乱其他字符的相对位置）。

**示例 1:**

```
输入: "bcabc"
输出: "abc"
```


**示例 2:**

```
输入: "cbacdcbc"
输出: "acdb"
```



## 2、解题思路

-   使用栈
-   如果元素没有出现在栈中，首先用当前元素将栈中大于当前元素，并且确保后续数量大于等于一的元素出栈，然后将当前元素放入栈中即可



```python
from collections import Counter


class Solution:
    def removeDuplicateLetters(self, s: str) -> str:
        stack = []
        count = Counter(s)
        appear = set()

        for c in s:
            if not stack:
                stack.append(c)
                appear.add(c)
            else:
                if c not in appear:
                    while stack and count[stack[-1]] and c < stack[-1]:
                        appear.remove(stack.pop())
                    stack.append(c)
                    appear.add(c)

            count[c] -= 1

        return "".join(stack)
```

