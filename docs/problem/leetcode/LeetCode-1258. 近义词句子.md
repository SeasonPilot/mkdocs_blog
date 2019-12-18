# LeetCode: 1258. 近义词句子

[TOC]

## 1、题目描述

给你一个近义词表 `synonyms` 和一个句子 `text` ， `synonyms` 表中是一些近义词对 ，你可以将句子 `text` 中每个单词用它的近义词来替换。

请你找出所有用近义词替换后的句子，按 字典序排序 后返回。

 

**示例 1：**

```
输入：
synonyms = [["happy","joy"],["sad","sorrow"],["joy","cheerful"]],
text = "I am happy today but was sad yesterday"
输出：
["I am cheerful today but was sad yesterday",
"I am cheerful today but was sorrow yesterday",
"I am happy today but was sad yesterday",
"I am happy today but was sorrow yesterday",
"I am joy today but was sad yesterday",
"I am joy today but was sorrow yesterday"]
```

**提示：**

-   $0 <= synonyms.length <= 10$
-   $synonyms[i].length == 2$
-   $synonyms[0] != synonyms[1]$
-   所有单词仅包含英文字母，且长度最多为 `10` 。
-   `text` 最多包含 `10` 个单词，且单词间用单个空格分隔开。



## 2、解题思路

-   DFS

首先将所有近似的词语集合放在一起

然后使用深度优先遍历



```python
class Solution:
    def generateSentences(self, synonyms: List[List[str]], text: str) -> List[str]:
        origin = text.split()
        length = len(origin)
        mapping = {}

        for w1, w2 in synonyms:
            mapping.setdefault(w1, set())
            mapping.setdefault(w2, set())
            mapping[w1].add(w1)
            mapping[w1].add(w2)
            mapping[w1].update(mapping[w2])
            for synonym in mapping[w1]:
                mapping[synonym] = mapping[w1]

        ans = []

        def dfs(current, pos):
            if pos >= length:
                ans.append(" ".join(current))
                return
            cur = origin[pos]
            if cur not in mapping:
                dfs(current + [cur], pos + 1)
            else:
                for syn in mapping[cur]:
                    dfs(current + [syn], pos + 1)

        dfs([], 0)
        return sorted(ans)
```

