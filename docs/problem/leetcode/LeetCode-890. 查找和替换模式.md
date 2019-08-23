# LeetCode: 890. 查找和替换模式

[TOC]

## 1、题目描述

你有一个单词列表 `words` 和一个模式  `pattern`，你想知道 `words` 中的哪些单词与模式匹配。

如果存在字母的排列 `p` ，使得将模式中的每个字母 `x` 替换为 `p(x)` 之后，我们就得到了所需的单词，那么单词与模式是匹配的。

（回想一下，字母的排列是从字母到字母的双射：每个字母映射到另一个字母，没有两个字母映射到同一个字母。）

返回 `words` 中与给定模式匹配的单词列表。

你可以按任何顺序返回答案。

 

**示例：**

```
输入：words = ["abc","deq","mee","aqq","dkd","ccc"], pattern = "abb"
输出：["mee","aqq"]
解释：
"mee" 与模式匹配，因为存在排列 {a -> m, b -> e, ...}。
"ccc" 与模式不匹配，因为 {a -> c, b -> c, ...} 不是排列。
因为 a 和 b 映射到同一个字母。
```

**提示：**

-  $1 <= words.length <= 50$ 

-  $1 <= pattern.length = words[i].length <= 20$  

## 2、解题思路

- 双向映射
- 保证字符串和模式是唯一的双向映射即可

```python
class Solution:
    def findAndReplacePattern(self, words: List[str], pattern: str) -> List[str]:
        
        if not words:
            return []

        def judge(target, pat):
            if len(target) != len(pat):
                return False
            mapping1 = {}
            mapping2 = {}
            for index, c in enumerate(pattern):
                if c not in mapping1:
                    mapping1[c] = target[index]
                else:
                    if mapping1[c] != target[index]:
                        return False
                if target[index] not in mapping2:
                    mapping2[target[index]] = c
                else:
                    if mapping2[target[index]] != c:
                        return False

            return True

        res = []
        for word in words:
            if judge(word, pattern):
                res.append(word)
        return res
```

