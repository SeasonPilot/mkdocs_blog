# LeetCode: 524. 通过删除字母匹配到字典里最长单词

[TOC]

## 1、题目描述

给定一个字符串和一个字符串字典，找到字典里面最长的字符串，该字符串可以通过删除给定字符串的某些字符来得到。如果答案不止一个，返回长度最长且字典顺序最小的字符串。如果答案不存在，则返回空字符串。

**示例 1:**

```
输入:
s = "abpcplea", d = ["ale","apple","monkey","plea"]

输出: 
"apple"
```

**示例 2:**

```
输入:
s = "abpcplea", d = ["a","b","c"]

输出: 
"a"
```

**说明:**

- 所有输入的字符串只包含小写字母。
- 字典的大小不会超过 1000。
- 所有输入的字符串长度不会超过 1000。

## 2、解题思路

- 按照长度逆序排序，长度一致则按照字典序排序

- 如果s中能够得到对应的字符串，返回结果

```python
class Solution:
    def findLongestWord(self, s: str, d: List[str]) -> str:
        d.sort(key=lambda x: (-len(x), x))

        def judge(a: str, b: str):
            pos = 0
            for c in b:
                k = a.find(c, pos)
                if k == -1:
                    return False
                else:
                    pos = k + 1

            return True

        for n in d:
            if judge(s, n):
                return n
        return ""
```

