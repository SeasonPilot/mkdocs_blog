# LeetCode: 820. 单词的压缩编码

[TOC]

## 1、题目描述

给定一个单词列表，我们将这个列表编码成一个索引字符串 `S` 与一个索引列表 `A`。

例如，如果这个列表是 `["time", "me", "bell"]`，我们就可以将其表示为 `S = "time#bell#"` 和 `indexes = [0, 2, 5]`。

对于每一个索引，我们可以通过从字符串 `S` 中索引的位置开始读取字符串，直到 `"#"` 结束，来恢复我们之前的单词列表。

那么成功对给定单词列表进行编码的最小字符串长度是多少呢？

 

**示例：**

```
输入: words = ["time", "me", "bell"]
输出: 10
说明: S = "time#bell#" ， indexes = [0, 2, 5] 。
```

**提示：**

-   `1 <= words.length <= 2000`
-   `1 <= words[i].length <= 7`
-   `每个单词都是小写字母 。`



## 2、解题思路

-   使用字典树，单词的倒序建立字典树

-   统计所有不能作为其他单词后缀的单词的长度和



```python
class Solution:
    def minimumLengthEncoding(self, words: List[str]) -> int:
        head = {}

        for word in words:
            reverse_word = reversed(word)
            temp = head
            for ch in reverse_word:
                temp = temp.setdefault(ch, {})
                if "value" in temp:
                    temp["value"] = word
            if not temp:
                temp["value"] = word

        ans_set = set()

        for word in words:
            reverse_word = reversed(word)
            temp = head
            for ch in reverse_word:
                temp = temp[ch]
            if "value" in temp:
                ans_set.add(temp["value"])

        ans = 0
        for word in ans_set:
            ans += len(word) + 1

        return ans
```

