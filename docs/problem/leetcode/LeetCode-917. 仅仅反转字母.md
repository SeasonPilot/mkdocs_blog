# LeetCode: 917. 仅仅反转字母

[TOC]

## 1、题目描述

给定一个字符串 S，返回 “反转后的” 字符串，其中不是字母的字符都保留在原地，而所有字母的位置发生反转。

 ```
示例 1：

输入："ab-cd"
输出："dc-ba"
示例 2：

输入："a-bC-dEf-ghIj"
输出："j-Ih-gfE-dCba"
示例 3：

输入："Test1ng-Leet=code-Q!"
输出："Qedo1ct-eeLg=ntse-T!"

 ```




提示：

- S.length <= 100
- 33 <= S[i].ASCIIcode <= 122 
- S 中不包含 \ or "

## 2、解题思路

- 设置一个缓冲数组，将不是字母的留在其中
- 将所有的字母取出来，反转并填充到缓冲数组中



```python
class Solution:
    def reverseOnlyLetters(self, S: str) -> str:
        buff = [None] * len(S)
        alpha = []
        for index, x in enumerate(S):
            if x.isalpha():
                alpha.append(x)
            else:
                buff[index] = x

        alpha.reverse()
        pos = 0
        for i in alpha:
            while buff[pos]:
                pos += 1
            buff[pos] = i
        return "".join(buff)
```

