# LeetCode: 243. 最短单词距离

[TOC]

## 1、题目描述



给定一个单词列表和两个单词 word1 和 word2，返回列表中这两个单词之间的最短距离。

示例:
假设 words = ["practice", "makes", "perfect", "coding", "makes"]

输入: word1 = “coding”, word2 = “practice”
输出: 3
输入: word1 = "makes", word2 = "coding"
输出: 1
注意:
你可以假设 word1 不等于 word2, 并且 word1 和 word2 都在列表里。



## 2、解题思路

每次更新位置都进行距离的更新



```python
class Solution:
    def shortestDistance(self, words: List[str], word1: str, word2: str) -> int:
        pos1 = -1
        pos2 = -1
        res = 10000
        for index, string in enumerate(words):
            if string == word1:
                pos1 = index
            if string == word2:
                pos2 = index

            if pos1 != -1 and pos2 != -1:
                res = min(res, abs(pos1 - pos2))
        return res
```

