# LeetCode: 186. 翻转字符串里的单词 II

[TOC]

## 1、题目描述

给定一个字符串，逐个翻转字符串中的每个单词。

**示例：**

```
输入: ["t","h","e"," ","s","k","y"," ","i","s"," ","b","l","u","e"]
输出: ["b","l","u","e"," ","i","s"," ","s","k","y"," ","t","h","e"]
```



**注意：**

- 单词的定义是不包含空格的一系列字符

- 输入字符串中不会包含前置或尾随的空格

- 单词与单词之间永远是以单个空格隔开的

**进阶：**使用 O(1) 额外空间复杂度的原地解法。

## 2、解题思路

- 首先判断单词，将所有单词原地反转
- 然后将整个字符串反转



```python
class Solution:
    def reverseWords(self, s: List[str]) -> None:
        """
        Do not return anything, modify s in-place instead.
        """
        N = len(s)
        pre = 0
        cur = 0
        for index, c in enumerate(s):
            if c == " ":
                cur = index-1
                for i in range((cur - pre + 1) // 2):
                    s[pre + i], s[cur - i] = s[cur - i], s[pre + i]
                pre = index + 1
        cur = N-1
        for i in range((cur - pre + 1) // 2):
            s[pre + i], s[cur - i] = s[cur - i], s[pre + i]

        pre = 0
        cur = N - 1
        for i in range(N // 2):
            s[pre + i], s[cur - i] = s[cur - i], s[pre + i]
            
```

