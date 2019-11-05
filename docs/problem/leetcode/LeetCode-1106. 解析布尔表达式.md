# LeetCode: 1106. 解析布尔表达式

[TOC]

## 1、题目描述

给你一个以字符串形式表述的 布尔表达式`（boolean） expression`，返回该式的运算结果。

有效的表达式需遵循以下约定：

-   `"t"`，运算结果为 `True`
-   `"f"`，运算结果为 `False`
-   `"!(expr)"`，运算过程为对内部表达式 expr 进行逻辑 非的运算`（NOT）`
-   `"&(expr1,expr2,...)"`，运算过程为对 `2` 个或以上内部表达式 `expr1, expr2, ...` 进行逻辑 与的运算`（AND）`
-   `"|(expr1,expr2,...)"`，运算过程为对 `2` 个或以上内部表达式 `expr1, expr2, ...` 进行逻辑 或的运算`（OR）`

**示例 1：**

```
输入：expression = "!(f)"
输出：true
```


**示例 2：**

```
输入：expression = "|(f,t)"
输出：true
```


**示例 3：**

```
输入：expression = "&(t,f)"
输出：false
```


**示例 4：**

```
输入：expression = "|(&(t,f,t),!(t))"
输出：false
```

**提示：**

-   $1 <= expression.length <= 20000$
-   `expression[i] 由 {'(', ')', '&', '|', '!', 't', 'f', ','} 中的字符组成。`
-   `expression 是以上述形式给出的有效表达式，表示一个布尔值。`



## 2、解题思路

-   使用栈，分别保存下面的元素

    -   保存操作符：`|&!`
    -   保存当前为`True`还是`False`
    -   保存当前操作符下有几个操作数

    

```python
class Solution:
    def parseBoolExpr(self, expression: str) -> bool:
        stack_sign = []
        stack_operand = []
        stack_index = []

        def process():
            sign = stack_sign.pop()
            last_index = stack_index.pop()
            if sign == "!":
                stack_operand[-1] = not stack_operand[-1]
            elif sign == "|":
                stack_operand[-last_index:] = [any(stack_operand[-last_index:])]
            elif sign == "&":
                stack_operand[-last_index:] = [all(stack_operand[-last_index:])]

        for index, c in enumerate(expression):
            if c in ["&", "|", "!"]:
                stack_sign.append(c)
                if stack_index:
                    stack_index[-1] += 1
            elif c == "(":
                stack_index.append(0)
            elif c == "t":
                stack_operand.append(True)
                stack_index[-1] += 1
            elif c == "f":
                stack_operand.append(False)
                stack_index[-1] += 1
            elif c == ")":
                process()

        return stack_operand[-1]
```

上面的运算并没有进行短路运算加速，直接将所有的结果都计算出来了，可以在与运算和或运算中增加短路操作，这样就能更快的计算出结果



```python
class Solution:
    def parseBoolExpr(self, expression: str) -> bool:
        stack_sign = []
        stack_operand = []
        stack_index = []

        def process():
            sign = stack_sign.pop()
            last_index = stack_index.pop()
            if sign == "!":
                stack_operand[-1] = not stack_operand[-1]
            elif sign == "|":
                stack_operand[-last_index:] = [any(stack_operand[-last_index:])]
            elif sign == "&":
                stack_operand[-last_index:] = [all(stack_operand[-last_index:])]
            if stack_index:
                stack_index[-1] += 1

        index = 0
        length = len(expression)
        while index < length:
            # 短路操作
            if stack_sign and stack_index and stack_operand:
                flag = False
                if stack_sign[-1] == "&" and stack_index[-1] and not stack_operand[-1]:
                    flag = True
                if stack_sign[-1] == "|" and stack_index[-1] and stack_operand[-1]:
                    flag = True

                if flag:
                    left = 1
                    temp_pos = index
                    while left > 0:
                        if expression[temp_pos] == "(":
                            left += 1
                        elif expression[temp_pos] == ")":
                            left -= 1
                        temp_pos += 1
                    index = temp_pos
                    process()
            if index >= length:
                break
            c = expression[index]
            if c in ["&", "|", "!"]:
                stack_sign.append(c)
                stack_index.append(0)

            elif c == "t":
                stack_operand.append(True)
                stack_index[-1] += 1
            elif c == "f":
                stack_operand.append(False)
                stack_index[-1] += 1
            elif c == ")":
                process()
            index += 1
        return stack_operand[-1]
```

未增加短路操作，仅超过`60%`，增加短路操作以后，超过了`99.06%`

![image-20191105111900115](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-05-031905.png)