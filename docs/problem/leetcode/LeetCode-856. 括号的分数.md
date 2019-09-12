# LeetCode: 856. 括号的分数

[TOC]

## 1、题目描述

给定一个平衡括号字符串 `S`，按下述规则计算该字符串的分数：

`()` 得 `1` 分。
`AB` 得 `A + B` 分，其中 `A` 和 `B` 是平衡括号字符串。
`(A)` 得 `2 * A` 分，其中 `A` 是平衡括号字符串。

**示例 1：**

```
输入： "()"
输出： 1
```


**示例 2：**

```
输入： "(())"
输出： 2
```


**示例 3：**

```
输入： "()()"
输出： 2
```


**示例 4：**

```
输入： "(()(()))"
输出： 6
```

**提示：**

- `S 是平衡括号字符串，且只含有 ( 和 ) 。`
- `2 <= S.length <= 50`



## 2、解题思路

- 使用栈
- 设置一个标记位
- 如果遇到左括号，入栈，设置标记位
- 如果遇到右括号，判断标记是否为真，为真则更新结果，因此保障了只有最里面一层可以更新结果



```
class Solution:
    def scoreOfParentheses(self, S: str) -> int:
        ans = 0

        count = False
        stack = []

        for c in S:
            if c == "(":
                count = True
                stack.append("(")
            elif c == ")":
                stack.pop()
                if count:
                    count = False
                    ans += 2 ** len(stack)
        return ans
```

