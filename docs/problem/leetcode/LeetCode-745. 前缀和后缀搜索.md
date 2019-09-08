# LeetCode: 745. 前缀和后缀搜索

[TOC]

## 1、题目描述

给定多个 `words，words[i]` 的权重为 `i` 。

设计一个类 `WordFilter` 实现函数`WordFilter.f(String prefix, String suffix)`。这个函数将返回具有前缀 `prefix` 和后缀`suffix` 的词的最大权重。如果没有这样的词，返回 `-1`。

**例子:**

```
输入:
WordFilter(["apple"])
WordFilter.f("a", "e") // 返回 0
WordFilter.f("b", "") // 返回 -1
```


**注意:**

- `words的长度在[1, 15000]之间。`
- `对于每个测试用例，最多会有words.length次对WordFilter.f的调用。`
- `words[i]的长度在[1, 10]之间。`
- `prefix, suffix的长度在[0, 10]之前。`
- `words[i]和prefix, suffix只包含小写字母。`



## 2、解题思路

- 使用两个字典树，分别为前缀字典树和后缀字典树
- 由于每个单词有唯一的权重，因此，直接搜索出前缀和后缀可以得到的所有权重，然后取交集中的最大值即可



```python
class WordFilter:

    def __init__(self, words: List[str]):
        self.pre_trie = {}
        self.suf_trie = {}

        for index, word in enumerate(words):
            temp = self.pre_trie
            suf = self.suf_trie
            for c in word:
                temp.setdefault(c, {})
                temp = temp[c]

            temp["end"] = index

            for c in reversed(word):
                suf.setdefault(c, {})
                suf = suf[c]
            suf["end"] = index

    def f(self, prefix: str, suffix: str) -> int:
        prefix_set = set()
        suffix_set = set()

        def start_with(trie, word):
            temp = trie
            if not word:
                return trie

            for c in word:
                if c not in temp:
                    return None
                temp = temp[c]

            return temp

        def get_weight(trie: dict, res_set: set):

            for key, d in trie.items():
                if key == "end":
                    res_set.add(d)
                else:
                    get_weight(d, res_set)

        pre = start_with(self.pre_trie, prefix)
        suf = start_with(self.suf_trie, "".join(reversed(suffix)))

        if pre and suf:
            get_weight(pre, prefix_set)
            get_weight(suf, suffix_set)
            temp_set = prefix_set & suffix_set
            if temp_set:
                return max(temp_set)

        return -1


# Your WordFilter object will be instantiated and called as such:
# obj = WordFilter(words)
# param_1 = obj.f(prefix,suffix)
```

