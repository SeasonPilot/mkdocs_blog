# LeetCode: 676. 实现一个魔法字典

[TOC]

## 1、题目描述

实现一个带有`buildDict`, 以及 `search`方法的魔法字典。

对于`buildDict`方法，你将被给定一串不重复的单词来构建一个字典。

对于`search`方法，你将被给定一个单词，并且判定能否只将这个单词中一个字母换成另一个字母，使得所形成的新单词存在于你构建的字典中。

**示例 1:**

```
Input: buildDict(["hello", "leetcode"]), Output: Null
Input: search("hello"), Output: False
Input: search("hhllo"), Output: True
Input: search("hell"), Output: False
Input: search("leetcoded"), Output: False
```


**注意:**

- `你可以假设所有输入都是小写字母 a-z。`
- `为了便于竞赛，测试所用的数据量很小。你可以在竞赛结束后，考虑更高效的算法。`
- `请记住重置MagicDictionary类中声明的类变量，因为静态/类变量会在多个测试用例中保留。 请参阅这里了解更多详情。`



## 2、解题思路

- 使用字典树

- 需要注意的是，要保证有一个字母不同，就从第一个开始判断，判断第一个字母不同的情况下，能否找到一个单词，找不到则判断第二个字母不同，以此类推



```python
class MagicDictionary:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.trie = {}

    def buildDict(self, dict: List[str]) -> None:
        """
        Build a dictionary through a list of words
        """
        for word in dict:
            temp = self.trie
            for ch in word:
                temp = temp.setdefault(ch, {})
            temp["end"] = 1

    def search(self, word: str) -> bool:
        """
        Returns if there is any word in the trie that equals to the given word after modifying exactly one character
        """

        def judge(trie, w):
            cur = trie
            for i in w:
                if i not in cur:
                    return False
                cur = cur[i]

            if cur.get("end") is not None:
                return True
            else:
                return False

        def start_with(trie, w):
            if not w:
                return trie

            cur = trie

            for i in w:
                if i not in cur:
                    return None
                cur = cur[i]
            return cur

        pre = self.trie
        for index, c in enumerate(word):
            temp = start_with(self.trie, word[:index])
            if temp:
                for k, next_trie in temp.items():
                    if k != c and next_trie != 1 and judge(next_trie, word[index + 1:]):
                        return True

            else:
                return False
        return False


# Your MagicDictionary object will be instantiated and called as such:
# obj = MagicDictionary()
# obj.buildDict(dict)
# param_2 = obj.search(word)
```

