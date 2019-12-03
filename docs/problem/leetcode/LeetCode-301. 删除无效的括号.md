# LeetCode: 301. 删除无效的括号

[TOC]

## 1、题目描述

删除最小数量的无效括号，使得输入的字符串有效，返回所有可能的结果。

说明: 输入可能包含了除 `(` 和 `)` 以外的字符。

**示例 1:**

```
输入: "()())()"
输出: ["()()()", "(())()"]
```


**示例 2:**

```
输入: "(a)())()"
输出: ["(a)()()", "(a())()"]
```


**示例 3:**

```
输入: ")("
输出: [""]
```



## 2、解题思路

-   首先从左只有扫描一遍，找出需要删除的最小数量的左括号和右括号
-   然后从右向左扫描，找出当前位置需要的左括号的数量（如果当前位置左括号数量已经超过右括号，跳出）
-   采用回溯法，从第一个位置开始，尝试进行左右括号的删除操作
-   当删除的左右括号数量等于最少删除数量时，判断两个拼接的字符串是否



```python
class Solution:
    def removeInvalidParentheses(self, s: str) -> List[str]:
        ans = set()
        length = len(s)
        left_del = 0
        right_del = 0
        for c in s:
            if c == "(":
                left_del += 1
            if c == ")":
                if left_del:
                    left_del -= 1
                else:
                    right_del += 1
        right_no_remove = [float('-inf')] * len(s)
        right_right = 0
        for i in range(length - 1, -1, -1):
            if s[i] == ")":
                right_right += 1
            if s[i] == "(":
                if right_right:
                    right_right -= 1
                else:
                    break
            right_no_remove[i] = right_right

        def dfs(pos, left_bracket_num, left_d, right_d, cur_s):
            if left_d == left_del and right_d == right_del:
                if pos >= length:
                    if left_bracket_num == 0:
                        ans.add(cur_s)
                else:
                    if left_bracket_num == right_no_remove[pos]:
                        ans.add(cur_s + s[pos:])
            else:
                if pos >= length:
                    return
                if s[pos] == "(":
                    dfs(pos + 1, left_bracket_num + 1, left_d, right_d, cur_s + s[pos])
                    if left_d < left_del:
                        dfs(pos + 1, left_bracket_num, left_d + 1, right_d, cur_s)
                elif s[pos] == ")":
                    if right_d < right_del:
                        dfs(pos + 1, left_bracket_num, left_d, right_d + 1, cur_s)
                    if left_bracket_num:
                        dfs(pos + 1, left_bracket_num - 1, left_d, right_d, cur_s + s[pos])
                else:
                    dfs(pos + 1, left_bracket_num, left_d, right_d, cur_s + s[pos])

        dfs(0, 0, 0, 0, "")
        return list(ans)
```

