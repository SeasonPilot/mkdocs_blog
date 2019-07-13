# LeetCode: 709. 转换成小写字母

[TOC]

## 1、题目描述

实现函数 ToLowerCase()，该函数接收一个字符串参数 str，并将该字符串中的大写字母转换成小写字母，之后返回新的字符串。

 

```
示例 1：

输入: "Hello"
输出: "hello"


示例 2：

输入: "here"
输出: "here"


示例 3：

输入: "LOVELY"
输出: "lovely"

```



## 2、解题思路



```python
class Solution:
    def toLowerCase(self, str: str) -> str:
        temp = [ chr( ord(x)+32 if 65 <= ord(x) <= 90 else ord(x))  for x in str]
        return "".join(temp)
```



```python
class Solution:
    def toLowerCase(self, str: str) -> str:
        t = str.maketrans("ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
        return str.translate(t)
```



```python
class Solution:
    def toLowerCase(self, str: str) -> str:
        match = {
            'A': 'a',
            'B': 'b',
            'C': 'c',
            'D': 'd',
            'E': 'e',
            'F': 'f',
            'G': 'g',
            'H': 'h',
            'I': 'i',
            'J': 'j',
            'K': 'k',
            'L': 'l',
            'M': 'm',
            'N': 'n',
            'O': 'o',
            'P': 'p',
            'Q': 'q',
            'R': 'r',
            'S': 's',
            'T': 't',
            'U': 'u',
            'V': 'v',
            'W': 'w',
            'X': 'x',
            'Y': 'y',
            'Z': 'z',
        }
        
        temp = [x if x not in match else match[x] for x in str]
        return "".join(temp)
```

