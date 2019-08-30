# LeetCode: 839. 相似字符串组

[TOC]

## 1、题目描述

如果我们交换字符串 `X` 中的两个不同位置的字母，使得它和字符串 `Y` 相等，那么称 `X` 和 `Y` 两个字符串相似。

例如，`"tars"` 和 `"rats"` 是相似的 (交换 `0` 与 `2` 的位置)； `"rats"` 和 `"arts"` 也是相似的，但是 `"star"` 不与 `"tars"`，`"rats"`，或 `"arts"` 相似。

总之，它们通过相似性形成了两个关联组：`{"tars", "rats", "arts"}` 和 `{"star"}`。注意，`"tars"` 和 `"arts"` 是在同一组中，即使它们并不相似。形式上，对每个组而言，要确定一个单词在组中，只需要这个词和该组中至少一个单词相似。

我们给出了一个不包含重复的字符串列表 A。列表中的每个字符串都是 A 中其它所有字符串的一个字母异位词。请问 A 中有多少个相似字符串组？

**示例：**

`输入：["tars","rats","arts","star"]`
`输出：2`
**提示：**

- `A.length <= 2000`
- `A[i].length <= 1000`
- `A.length * A[i].length <= 20000`
- `A 中的所有单词都只包含小写字母。`
- `A 中的所有单词都具有相同的长度，且是彼此的字母异位词。`
- `此问题的判断限制时间已经延长。`

**备注：**

- 字母异位词`[anagram]`，一种把某个字符串的字母的位置（顺序）加以改换所形成的新词。

## 2、解题思路

- 使用并查集确定组合数

这里有一点坑，判断字符串两两相似，有下面两种方法：

- 每一个字符串都与其他字符串进行相似判断
- 让每个字符串都生成所有的相似字符串



直接用上面的一种方法，都是超时的，

这时候，如果判断字符串的数量比较少，就用第一种

如果字符串比较短，用第二种

```python
from itertools import combinations
from collections import defaultdict


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
    def numSimilarGroups(self, A):

        length = len(A)
        word_length = len(A[0])
        d = DFU(length)

        def judge(s1, s2):
            count = 0
            for c1, c2 in zip(s1, s2):
                if c1 != c2:
                    count += 1
                if count > 2:
                    return False

            return True

        if length < word_length ** 2:
            for (i1, word1), (i2, word2) in combinations(enumerate(A), 2):
                if judge(word1, word2):
                    d.union(i1, i2)
        else:
            bucket = defaultdict(set)
            for index, word in enumerate(A):
                temp = list(word)
                for pos1, pos2 in combinations(range(word_length), 2):
                    temp[pos1], temp[pos2] = temp[pos2], temp[pos1]
                    bucket["".join(temp)].add(index)
                    temp[pos1], temp[pos2] = temp[pos2], temp[pos1]

            for index, word in enumerate(A):
                for j in bucket[word]:
                    d.union(index, j)

        return d.count()

```

