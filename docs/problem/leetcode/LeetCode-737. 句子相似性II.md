# LeetCode: 737. 句子相似性II

[TOC]

## 1、题目描述

给定两个句子 `words1, words2` （每个用字符串数组表示），和一个相似单词对的列表 `pairs` ，判断是否两个句子是相似的。

例如，当相似单词对是 `pairs = [["great", "fine"], ["acting","drama"], ["skills","talent"]]`的时候，`words1 = ["great", "acting", "skills"]` 和 `words2 = ["fine", "drama", "talent"]` 是相似的。

注意相似关系是 具有 传递性的。例如，如果 `"great"` 和 `"fine"` 是相似的，`"fine"` 和 `"good"` 是相似的，则 `"great"` 和 `"good"` 是相似的。

而且，相似关系是具有对称性的。例如，`"great"` 和 `"fine"` 是相似的相当于 `"fine"` 和 `"great"` 是相似的。

并且，一个单词总是与其自身相似。例如，句子 `words1 = ["great"], words2 = ["great"], pairs = []` 是相似的，尽管没有输入特定的相似单词对。

最后，句子只会在具有相同单词个数的前提下才会相似。所以一个句子 `words1 = ["great"]` 永远不可能和句子 `words2 = ["doubleplus","good"]` 相似。

**注：**

-   `words1 and words2` 的长度不会超过 `1000`。
-   `pairs` 的长度不会超过 `2000`。
-   每个`pairs[i]` 的长度为 `2`。
-   每个 `words[i]` 和 `pairs[i][j]` 的长度范围为 `[1, 20]`。



## 2、解题思路

-   使用并查集将相似的单词放到同一个集合中



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def areSentencesSimilarTwo(self, words1: List[str], words2: List[str], pairs: List[List[str]]) -> bool:
        if len(words1) != len(words2):
            return False
        mapping = {val: index for index, val in enumerate(set([item for sublist in pairs for item in sublist]))}
        d = DFU(len(mapping))
        for x, y in pairs:
            d.union(mapping[x], mapping[y])

        for w1, w2 in zip(words1, words2):
            if w1 == w2:
                continue
            if (w1 != w2 and (w1 not in mapping or w2 not in mapping)) or (d.find(mapping[w1]) != d.find(mapping[w2])):
                return False
        return True

```

