# LeetCode: 244. 最短单词距离 II

[TOC]

## 1、题目描述

请设计一个类，使该类的构造函数能够接收一个单词列表。然后再实现一个方法，该方法能够分别接收两个单词 word1 和 word2，并返回列表中这两个单词之间的最短距离。您的方法将被以不同的参数调用 多次。

```
示例:
假设 words = ["practice", "makes", "perfect", "coding", "makes"]

输入: word1 = “coding”, word2 = “practice”
输出: 3
输入: word1 = "makes", word2 = "coding"
输出: 1
```



**注意:**

- 你可以假设 word1 不等于 word2, 并且 word1 和 word2 都在列表里。

## 2、解题思路

- 保存单词出现的位置列表
- 使用双指针，遍历两个列表
- 如果第一个索引大于第二个，第二个指针向后移动，反之第一个指针移动

```python
class WordDistance:
    
    def __init__(self, words: List[str]):
        from collections import defaultdict
        self.buff = defaultdict(list)

        for index, w in enumerate(words):
            self.buff[w].append(index)

    def shortest(self, word1: str, word2: str) -> int:
        res = float('inf')
        pos_w1 = 0
        pos_w2 = 0
        temp1 = self.buff[word1]
        temp2 = self.buff[word2]

        while pos_w1 < len(temp1) and pos_w2 < len(temp2):
            res = min(res, abs(temp1[pos_w1] - temp2[pos_w2]))
            if temp1[pos_w1] >= temp2[pos_w2]:
                pos_w2 += 1
            else:
                pos_w1 += 1
        return res


# Your WordDistance object will be instantiated and called as such:
# obj = WordDistance(words)
# param_1 = obj.shortest(word1,word2)
```



