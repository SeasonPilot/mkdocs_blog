# LeetCode: 224. 基本计算器

[TOC]

## 1、题目描述

实现一个基本的计算器来计算一个简单的字符串表达式的值。

字符串表达式可以包含左括号 `(` ，右括号 `)`，加号 `+` ，减号 `-`，非负整数和空格  。

**示例 1:**

```
输入: "1 + 1"
输出: 2
```


**示例 2:**

```
输入: " 2-1 + 2 "
输出: 3
```


**示例 3:**

```
输入: "(1+(4+5+2)-3)+(6+8)"
输出: 23
```


**说明：**

-   你可以假设所给定的表达式都是有效的。
-   请不要使用内置的库函数 `eval`。



## 2、解题思路

-   使用栈保存数字和运算符
-   遇到右括号就将当前括号中的所有的数字进行计算



```python
class Solution:
    def calculate(self, s: str) -> int:
        sign = []
        numbers = []
        cur_num = []
        for c in s:
            if c in ["+", "-", "("]:
                sign.append(c)
                if cur_num:
                    numbers.append(int("".join(cur_num)))
                cur_num = []
            elif c.isdigit():
                cur_num.append(c)
            elif c == ")":
                if cur_num:
                    numbers.append(int("".join(cur_num)))
                cur_num = []
                # 计算当前括号中的数字
                sign_length = len(sign)
                right_pos = sign_length - 1
                while sign[right_pos] != "(":
                    right_pos -= 1
                if right_pos == sign_length - 1:
                    sign.pop()
                else:
                    number_length = sign_length - right_pos
                    current_sign_length = number_length - 1
                    for i in range(current_sign_length, 0, -1):
                        if sign[-i] == "+":
                            numbers[-i] = numbers[-i - 1] + numbers[-i]
                        elif sign[-i] == "-":
                            numbers[-i] = numbers[-i - 1] - numbers[-i]

                    numbers = numbers[:-number_length] + [numbers[-1]]
                    sign = sign[:-current_sign_length - 1]

        if cur_num:
            numbers.append(int("".join(cur_num)))

        if len(sign):
            for index, c in enumerate(sign):
                if c == "+":
                    numbers[index + 1] = numbers[index] + numbers[index + 1]
                elif c == "-":
                    numbers[index + 1] = numbers[index] - numbers[index + 1]

        return numbers[-1]
```

