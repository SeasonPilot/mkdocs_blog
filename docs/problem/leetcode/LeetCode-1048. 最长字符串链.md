# LeetCode: 1048. 最长字符串链

[TOC]

## 1、题目描述

给出一个单词列表，其中每个单词都由小写英文字母组成。

如果我们可以在 `word1` 的任何地方添加一个字母使其变成 `word2`，那么我们认为 `word1` 是 `word2` 的前身。例如，`"abc"` 是 `"abac"` 的前身。

词链是单词 `[word_1, word_2, ..., word_k]` 组成的序列，`k >= 1`，其中 `word_1` 是 `word_2` 的前身，`word_2` 是 `word_3` 的前身，依此类推。

从给定单词列表 words 中选择单词组成词链，返回词链的最长可能长度。

**示例：**

```
输入：["a","b","ba","bca","bda","bdca"]
输出：4
解释：最长单词链之一为 "a","ba","bda","bdca"。
```

**提示：**

-   $1 <= words.length <= 1000$
-   $1 <= words[i].length <= 16$
-   `words[i]` 仅由小写英文字母组成。



## 2、解题思路

-   找出以当前字符为结束点的最长的字符串链式多长
-   使用字典保存中间值



```python
class Solution:
    def longestStrChain(self, words: List[str]) -> int:
        words.append("")
        words.sort(key=len)
        ans = 1

        mapping = {"": 0}

        def check(word, next_word):
            if len(word) != len(next_word) - 1:
                return False

            for i in range(len(word)):
                if word[i] != next_word[i]:
                    return word[i:] == next_word[i + 1:]
            return True

        for p in range(1, len(words)):
            for j in range(p):
                if check(words[j], words[p]):
                    mapping.setdefault(words[p], mapping[words[j]] + 1)
                    mapping[words[p]] = max(mapping[words[p]], mapping[words[j]] + 1)
                    ans = max(ans, mapping[words[p]])
                else:
                    mapping.setdefault(words[p], 1)
        return ans
```

