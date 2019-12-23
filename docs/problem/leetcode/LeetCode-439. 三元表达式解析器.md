# LeetCode: 439. 三元表达式解析器

[TOC]

## 1、题目描述

给定一个以字符串表示的任意嵌套的三元表达式，计算表达式的值。你可以假定给定的表达式始终都是有效的并且只包含数字 `0-9, ?, :,` `T` 和 `F` (`T` 和 `F` 分别表示真和假）。

**注意：**

1.  给定的字符串长度 `≤ 10000`。
2.  所包含的数字都只有一位数。
3.  条件表达式从右至左结合（和大多数程序设计语言类似）。
4.  条件是 `T` 和 `F`其一，即条件永远不会是数字。
5.  表达式的结果是数字 `0-9`, `T` 或者 `F`。

**示例 1：**

```
输入： "T?2:3"

输出： "2"

解释： 如果条件为真，结果为 2；否则，结果为 3。
```

**示例 2：**

```
输入： "F?1:T?4:5"

输出： "4"

解释： 条件表达式自右向左结合。使用括号的话，相当于：

             "(F ? 1 : (T ? 4 : 5))"                   "(F ? 1 : (T ? 4 : 5))"
          -> "(F ? 1 : 4)"                 或者     -> "(T ? 4 : 5)"
          -> "4"                                    -> "4"
```

**示例 3：**

```
输入： "T?T?F:5:3"

输出： "F"

解释： 条件表达式自右向左结合。使用括号的话，相当于：

             "(T ? (T ? F : 5) : 3)"                   "(T ? (T ? F : 5) : 3)"
          -> "(T ? F : 3)"                 或者       -> "(T ? F : 5)"
          -> "F"                                     -> "F"

```

## 2、解题思路

- 尾递归方式
- 对每个判断条件，找出分界点，分界点通过`?`和`:`的数量匹配进行查找
- 直到`expression`的长度为1的时候，结束，也就是找到了返回值



```python
class Solution:
    def parseTernary(self, expression: str) -> str:
        if len(expression) == 1:
            return expression
        condition = expression[0]
        position = 2
        left_count = 1
        while position < len(expression):
            if expression[position] == "?":
                left_count += 1
            elif expression[position] == ":":
                left_count -= 1
            if left_count == 0:
                break
            position += 1
        if condition == "T":
            return self.parseTernary(expression[2:position])
        else:
            return self.parseTernary(expression[position + 1:])

```