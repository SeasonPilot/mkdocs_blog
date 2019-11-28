# LeetCode: 65. 有效数字

[TOC]

## 1、题目描述

验证给定的字符串是否可以解释为十进制数字。

例如:

```
"0" => true
" 0.1 " => true
"abc" => false
"1 a" => false
"2e10" => true
" -90e3   " => true
" 1e" => false
"e3" => false
" 6e-1" => true
" 99e2.5 " => false
"53.5e93" => true
" --6 " => false
"-+3" => false
"95a54e53" => false
```

说明: 我们有意将问题陈述地比较模糊。在实现代码之前，你应当事先思考所有可能的情况。这里给出一份可能存在于有效十进制数字中的字符列表：

-   数字 `0-9`
-   指数 - `"e"`
-   正/负号 - `"+"/"-"`
-   小数点 - `"."`

当然，在输入中，这些字符的上下文也很重要。

更新于 2015-02-10:
C++函数的形式已经更新了。如果你仍然看见你的函数接收 const char * 类型的参数，请点击重载按钮重置你的代码。

## 2、解题思路

-   使用`python`自带的`float`若捕获异常，返回false

```python
class Solution:
    def isNumber(self, s: str) -> bool:
        ans = True
        try:
            val = float(s)
        except ValueError:
            ans = False
        return ans
```

-   使用`DFA(确定有穷自动机，Deterministic Finite Automaton)`

![image-20191128163109377](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-28-085140.png)

从初始状态开始进行转换，如果终止状态停留在上面的绿色状态上，表示有效数字



```python
class Solution:
    def isNumber(self, s: str) -> bool:
        mapping = {
            ".": 0,
            "0": 1,
            "+": 2,
            "-": 2,
            "e": 3,
        }
        next_state = {
            (0, 0): 3,
            (0, 1): 2,
            (0, 2): 1,
            (1, 0): 3,
            (1, 1): 2,
            (2, 0): 4,
            (2, 1): 2,
            (2, 3): 5,
            (3, 1): 4,
            (4, 1): 4,
            (4, 3): 5,
            (5, 1): 6,
            (5, 2): 7,
            (6, 1): 6,
            (7, 1): 6,
        }

        s = s.strip()
        final = {2, 4, 6}
        cur_state = 0
        for c in s:
            c_mapping = mapping.get("0" if c.isdigit() else c, -1)
            cur_state = next_state.get((cur_state, c_mapping), -1)
            if cur_state == -1:
                return False

        return cur_state in final
```

