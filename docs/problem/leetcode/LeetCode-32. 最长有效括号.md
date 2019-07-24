# LeetCode: 32. 最长有效括号

[TOC]

## 1、题目描述

给定一个只包含 `'('` 和 `')'` 的字符串，找出最长的包含有效括号的子串的长度。

```
示例 1:
输入: "(()"
输出: 2
解释: 最长有效括号子串为 "()"

示例 2:
输入: ")()())"
输出: 4
解释: 最长有效括号子串为 "()()"
```





## 2、解题思路



- 第一次的代码，超时了
- 基本思路：
- 将"("看成1，")"看成-1，然后两个括号匹配的时候，加和为0
- 然后检测是否是正确的括号顺序

```python
from itertools import accumulate


class Solution:
    def longestValidParentheses(self, s: str) -> int:
        temp = [1 if x == "(" else -1 for x in s]
        left = [index for index, x in enumerate(temp) if x == 1]
        right = [index for index, x in enumerate(temp) if x == -1]

        sums = list(accumulate(temp))
        res = 0
        for i in left:
            for j in right:
                if i < j and sums[j] - sums[i] + 1 == 0 and all(
                        [True if x >= 0 else False for x in accumulate(temp[i:j + 1])]):
                    res = max(res, j - i + 1)
        return res
```



- 改进版1
- 使用栈存储"("，然后遇到对应的右括号，则出栈，并且将两个位置标识为1
- 最后判断连续的标识为1的长度即可

```python
class Solution:
    def longestValidParentheses(self, s: str) -> int:
        stack, sign = [], [0] * len(s)

        for index, i in enumerate(s):
            if i == "(":
                stack.append(index)
            else:
                if stack:
                    sign[stack.pop()], sign[index] = 1, 1

        res = 0
        count = 0
        for i in sign:
            if i:
                count += 1
            else:
                res = max(res, count)
                count = 0
        if count:
            res = max(res, count)
        return res
```

