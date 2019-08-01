# LeetCode: 245. 最短单词距离 III

[TOC]

## 1、题目描述

给定一个单词列表和两个单词 word1 和 word2，返回列表中这两个单词之间的最短距离。

word1 和 word2 是有可能相同的，并且它们将分别表示为列表中两个独立的单词。

**示例:**

```
假设 words = ["practice", "makes", "perfect", "coding", "makes"].

输入: word1 = “makes”, word2 = “coding”
输出: 1
输入: word1 = "makes", word2 = "makes"
输出: 3
```



**注意:**

- 你可以假设 word1 和 word2 都在列表里。

## 2、解题思路

- 将单词的索引放在字典的列表中
- 两个单词相同的话，所以同步前进

```python
from collections import defaultdict


class Solution:
    def shortestWordDistance(self, words: List[str], word1: str, word2: str) -> int:
        
        buff = defaultdict(list)
        for index, w in enumerate(words):
            buff[w].append(index)

        pos1 = 0
        pos2 = 0
        if word1 == word2:
            pos2 += 1

        N1 = len(buff[word1])
        N2 = len(buff[word2])

        res = float('inf')

        while pos1 < N1 and pos2 < N2:
            
            res = min(res, abs(buff[word1][pos1] - buff[word2][pos2]))
            if buff[word1][pos1] >= buff[word2][pos2]:
                pos2 += 1
                if word1 == word2:
                    pos1 += 1

            else:
                pos1 += 1
                if word1 == word2:
                    pos2 += 1
        return res

```

