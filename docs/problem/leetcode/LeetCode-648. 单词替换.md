# LeetCode: 648. 单词替换

[TOC]

## 1、题目描述

在英语中，我们有一个叫做 词根(`root`)的概念，它可以跟着其他一些词组成另一个较长的单词——我们称这个词为 继承词(`successor`)。例如，词根`an`，跟随着单词 `other`(其他)，可以形成新的单词 `another`(另一个)。

现在，给定一个由许多词根组成的词典和一个句子。你需要将句子中的所有继承词用词根替换掉。如果继承词有许多可以形成它的词根，则用最短的词根替换它。

你需要输出替换之后的句子。

**示例 1:**

```
输入: dict(词典) = ["cat", "bat", "rat"]
sentence(句子) = "the cattle was rattled by the battery"
输出: "the cat was rat by the bat"
```


**注:**

- `输入只包含小写字母。`
- `1 <= 字典单词数 <=1000`
- `1 <=  句中词语数 <= 1000`
- `1 <= 词根长度 <= 100`
- `1 <= 句中词语长度 <= 1000`



## 2、解题思路

- 字典树

```python
class Trie:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.head = {}

    def insert(self, word):
        """
        Inserts a word into the trie.
        :type word: str
        :rtype: void
        """
        cur = self.head
        for i in word:
            if cur.get(i) is None:
                cur[i] = {}
            cur = cur[i]
        if cur.get("end") is None:
            cur["end"] = 1

    def search(self, word):
        """
        Returns if the word is in the trie.
        :type word: str
        :rtype: bool
        """
        cur = self.head
        for i in word:
            if i not in cur:
                return False
            cur = cur[i]

        if cur.get("end") is not None:
            return True
        else:
            return False

    def startsWith(self, prefix):
        """
        Returns if there is any word in the trie that starts with the given prefix.
        :type prefix: str
        :rtype: bool
        """
        cur = self.head
        for i in prefix:
            if i not in cur:
                return False
            cur = cur[i]

        return True


class Solution:
    def replaceWords(self, dict: List[str], sentence: str) -> str:
        trie = Trie()
        for d in dict:
            trie.insert(d)

        temp = sentence.split()

        for index, word in enumerate(temp):
            for i in range(1, len(word)):
                if trie.search(word[:i]):
                    temp[index] = word[:i]
                    break
        return " ".join(temp)
```

- 哈希表

```python
class Solution:
    def replaceWords(self, dict: List[str], sentence: str) -> str:

        mapping = set(dict)

        temp = sentence.split()

        for index, word in enumerate(temp):
            for i in range(1, len(word)):
                if word[:i] in mapping:
                    temp[index] = word[:i]
                    break
        return " ".join(temp)
```

