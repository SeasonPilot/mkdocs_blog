# LeetCode: 1032. 字符流

[TOC]

## 1、题目描述

按下述要求实现 `StreamChecker` 类：

`StreamChecker(words)`：构造函数，用给定的字词初始化数据结构。
`query(letter)`：如果存在某些 `k >= 1`，可以用查询的最后 `k`个字符（按从旧到新顺序，包括刚刚查询的字母）拼写出给定字词表中的某一字词时，返回 `true`。否则，返回 `false`。

**示例：**

```
StreamChecker streamChecker = new StreamChecker(["cd","f","kl"]); // 初始化字典
streamChecker.query('a');          // 返回 false
streamChecker.query('b');          // 返回 false
streamChecker.query('c');          // 返回 false
streamChecker.query('d');          // 返回 true，因为 'cd' 在字词表中
streamChecker.query('e');          // 返回 false
streamChecker.query('f');          // 返回 true，因为 'f' 在字词表中
streamChecker.query('g');          // 返回 false
streamChecker.query('h');          // 返回 false
streamChecker.query('i');          // 返回 false
streamChecker.query('j');          // 返回 false
streamChecker.query('k');          // 返回 false
streamChecker.query('l');          // 返回 true，因为 'kl' 在字词表中。
```

**提示：**

- `1 <= words.length <= 2000`
- `1 <= words[i].length <= 2000`
- `字词只包含小写英文字母。`
- `待查项只包含小写英文字母。`
- `待查项最多 40000 个。`



## 2、解题思路

- 使用字典树
- 字典树倒序设置
- 设置一个双向队列，每次来的字符从左面添加，队列长度最长不超过单词的最大长度



```python
from collections import deque


class StreamChecker:

    def __init__(self, words: List[str]):
        self.trie = {}
        self.max_length = 0
        for word in words:
            self.max_length = max(self.max_length, len(word))
            temp = self.trie
            for c in reversed(word):
                temp.setdefault(c, {})
                temp = temp[c]
            temp["end"] = 1

        self.deq = deque(maxlen=self.max_length)
        # self.mapping = {}

    def query(self, letter: str) -> bool:
        def search(trie: dict, word: str) -> bool:
            temp = trie
            for c in word:
                if c not in temp:
                    return False
                temp = temp[c]
                if "end" in temp:
                    return True
            return False

        self.deq.appendleft(letter)

        return search(self.trie,self.deq)


# Your StreamChecker object will be instantiated and called as such:
# obj = StreamChecker(words)
# param_1 = obj.query(letter)

```

