# LeetCode: 1081. 不同字符的最小子序列

[TOC]

## 1、题目描述

返回字符串 `text` 中按字典序排列最小的子序列，该子序列包含 `text` 中所有不同字符一次。

 

**示例 1：**

```
输入："cdadabcc"
输出："adbc"
```


**示例 2：**

```
输入："abcd"
输出："abcd"
```


**示例 3：**

```
输入："ecbacba"
输出："eacb"
```


**示例 4：**

```
输入："leetcode"
输出："letcod"
```

**提示：**

-   `1 <= text.length <= 1000`
-   `text 由小写英文字母组成`



## 2、解题思路

-   使用栈

```
如果当前字符小于栈顶的字符，并且栈顶字符数量大于1，出栈，并且数量减一
如果当前字符已经出现过，直接将数量减一即可
```



```python
from collections import Counter


class Solution:
    def smallestSubsequence(self, text: str) -> str:
        count = Counter(text)
        stack = []
        appear = set()

        for ch in text:

            if ch not in appear:
                while stack and stack[-1] > ch and count[stack[-1]] > 1:
                    count[stack[-1]] -= 1
                    appear.remove(stack.pop())

                stack.append(ch)
                appear.add(ch)
            else:
                count[ch] -= 1

        return "".join(stack)


```

