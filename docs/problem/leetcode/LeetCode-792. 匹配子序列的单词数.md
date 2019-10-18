# LeetCode: 792. 匹配子序列的单词数

[TOC]

## 1、题目描述

给定字符串 `S` 和单词字典 `words`, 求 `words[i]` 中是 `S` 的子序列的单词个数。

**示例:**

```
输入: 
S = "abcde"
words = ["a", "bb", "acd", "ace"]
输出: 3
解释: 有三个是 S 的子序列的单词: "a", "acd", "ace"。
```


**注意:**

-   `所有在words和 S 里的单词都只由小写字母组成。`
-   `S 的长度在 [1, 50000]。`
-   `words 的长度在 [1, 5000]。`
-   `words[i]的长度在[1, 50]。`



## 2、解题思路

-   不断地在字符串中查找当前单词所对应的字符



```python
class Solution:
    def numMatchingSubseq(self, S: str, words: List[str]) -> int:
        ans = 0
        for word in words:
            index = 0
            flag = True
            for ch in word:
                next_pos = S.find(ch, index)
                if next_pos != -1:
                    index = next_pos + 1
                else:
                    flag = False
                    break
            if flag:
                ans += 1

        return ans
```

