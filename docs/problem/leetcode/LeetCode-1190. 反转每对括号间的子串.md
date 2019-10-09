# LeetCode: 1190. 反转每对括号间的子串

[TOC]

## 1、题目描述

给出一个字符串 `s`（仅含有小写英文字母和括号）。

请你按照从括号内到外的顺序，逐层反转每对匹配括号中的字符串，并返回最终的结果。

注意，您的结果中 不应 包含任何括号。

 

**示例 1：**

```
输入：s = "(abcd)"
输出："dcba"
```


**示例 2：**

```
输入：s = "(u(love)i)"
输出："iloveu"
```


**示例 3：**

```
输入：s = "(ed(et(oc))el)"
输出："leetcode"
```


**示例 4：**

```
输入：s = "a(bcdefghijkl(mno)p)q"
输出："apmnolkjihgfedcbq"
```

**提示：**

-   `0 <= s.length <= 2000`
-   `s 中只有小写英文字母和括号`
-   `我们确保所有括号都是成对出现的`



## 2、解题思路

-   使用栈

```
每一次遇到 （， 在栈中放一个空字符串，主要是因为可能出现空括号这种情况
如果遇到 ），就将最后一个字符串反转，然后合并到前面的字符串中，栈最后一个元素出栈
如果遇到字符，就添加到最后一个字符串中
```

```
"sxmdll(q)eki(x)"
下面为栈的变化：

['']
['s']
['sx']
['sxm']
['sxmd']
['sxmdl']
['sxmdll']
['sxmdll', '']
['sxmdll', 'q']
['sxmdllq']
['sxmdllqe']
['sxmdllqek']
['sxmdllqeki']
['sxmdllqeki', '']
['sxmdllqeki', 'x']
['sxmdllqekix']
```



```python
class Solution:
    def reverseParentheses(self, s: str) -> str:
        stack = [""]

        for ch in s:
            if ch == "(":
                stack.append("")
            elif ch == ")":
                stack[-2] += "".join(stack[-1][::-1])
                stack.pop()
            else:
                stack[-1] += ch

        return stack[0]
```

