# LeetCode: 336. 回文对

[TOC]

## 1、题目描述

给定一组唯一的单词， 找出所有不同 的索引对`(i, j)`，使得列表中的两个单词， `words[i] + words[j]` ，可拼接成回文串。

**示例 1:**

```
输入: ["abcd","dcba","lls","s","sssll"]
输出: [[0,1],[1,0],[3,2],[2,4]] 
解释: 可拼接成的回文串为 ["dcbaabcd","abcddcba","slls","llssssll"]
```


**示例 2:**

```
输入: ["bat","tab","cat"]
输出: [[0,1],[1,0]] 
解释: 可拼接成的回文串为 ["battab","tabbat"]
```



## 2、解题思路

- 因为是两个串进行连接，那么考虑下面的几种情况：

  - 有一个串是当前字符串的反序
  - 当前字符串中最后1，2...n-1位判断是不是回文串，如果是，剩余的部分取反，看看是不是存在这个字符串

  - 当前字符串从前面开始，判断能够提供给什么字符串连接成为回文串，判断当前串1，2，3.。。一直到n-1，如果出现了回文串，那么剩余部分反转，当前串就能够提供给这个串作为回文串

```

例如：
   "abcd"
   
"dcba"存在，那么就能够形成回文串
"cba"存在，也能够形成回文串

另外这个串能够提供给谁做为回文串组合呢？
可以提供给 "dcba"
可以提供给 "dcb"

```



```python
from collections import defaultdict


class Solution:
    def palindromePairs(self, words: [str]) -> [[int]]:
        offered = defaultdict(list)
        need = {}
        ans = []

        def judge_palindrome(word):
            if not word:
                return True
            length = len(word)
            if length == 1:
                return True

            if word[:length // 2] == "".join(reversed(word[length - length // 2:])):
                return True

            return False

        for index, word in enumerate(words):
            need[word] = index

            if not words:
                offered[""].append(index)
            else:
                offered["".join(reversed(word))].append(index)
                for i in range(1, len(word)):
                    if judge_palindrome(word[:i]):
                        offered["".join(reversed(word[i:]))].append(index)


        for index, word in enumerate(words):
            if not word:
                if len(offered[""]) > 1:
                    for i in offered[""]:
                        if i != index:
                            ans.append([index, i])
            else:

                if word in offered:
                    for i in offered[word]:
                        if i != index:
                            ans.append([index, i])

                if judge_palindrome(word):
                    for i in offered[""]:
                        ans.append([index, i])
                        ans.append([i, index])

                for i in range(len(word) - 1, 0, -1):
                    judge_str = word[i:]
                    if judge_palindrome(judge_str):
                        before_str = "".join(reversed(word[:i]))
                        if before_str in need:
                            ans.append([index, need[before_str]])
        return ans

```

