# LeetCode: 288. 单词的唯一缩写

[TOC]

## 1、题目描述

一个单词的缩写需要遵循 <起始字母><中间字母数><结尾字母> 这样的格式。

以下是一些单词缩写的范例：
```
a) it                      --> it    (没有缩写)

     1
     ↓
b) d|o|g                   --> d1g

              1    1  1
     1---5----0----5--8
     ↓   ↓    ↓    ↓  ↓    
c) i|nternationalizatio|n  --> i18n

              1
     1---5----0
     ↓   ↓    ↓
d) l|ocalizatio|n          --> l10n
```
假设你有一个字典和一个单词，请你判断该单词的缩写在这本字典中是否唯一。若单词的缩写在字典中没有任何 其他 单词与其缩写相同，则被称为单词的唯一缩写。

**示例：**

```
给定 dictionary = [ "deer", "door", "cake", "card" ]

isUnique("dear") -> false
isUnique("cart") -> true
isUnique("cane") -> false
isUnique("make") -> true


```



## 2、解题思路

-   题目很简单，说明不够明确
-   实际要求为：
    -   判断一个单词的缩写是否在词典中，不在返回`True`
    -   如果在，判断这个缩写的是否还有其他单词，有的话，返回`False`

```python
from collections import defaultdict


class ValidWordAbbr:

    def __init__(self, dictionary: List[str]):
        self.d = defaultdict(set)
        for w in dictionary:
            if len(w) > 2:
                self.d[w[0] + str(len(w) - 2) + w[-1]].add(w)

    def isUnique(self, word: str) -> bool:
        length = len(word)
        if length <= 2:
            return True
        k = word[0] + str(length - 2) + word[-1]
        if k in self.d and word in self.d[k] and len(self.d[k]) > 1:
            return False
        if k in self.d and word not in self.d[k] and len(self.d[k]) >= 1:
            return False

        return True
        
# Your ValidWordAbbr object will be instantiated and called as such:
# obj = ValidWordAbbr(dictionary)
# param_1 = obj.isUnique(word)
```

