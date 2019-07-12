# LeetCode: 408. 有效单词缩写

[TOC]

## 1、题目描述

给一个 非空 字符串 s 和一个单词缩写 abbr ，判断这个缩写是否可以是给定单词的缩写。

字符串 "word" 的所有有效缩写为：

["word", "1ord", "w1rd", "wo1d", "wor1", "2rd", "w2d", "wo2", "1o1d", "1or1", "w1r1", "1o2", "2r1", "3d", "w3", "4"]
注意单词 "word" 的所有有效缩写仅包含以上这些。任何其他的字符串都不是 "word" 的有效缩写。

注意:
假设字符串 s 仅包含小写字母且 abbr 只包含小写字母和数字。

```
示例 1:

给定 s = "internationalization", abbr = "i12iz4n":

函数返回 true.
 

示例 2:

给定 s = "apple", abbr = "a2e":

函数返回 false.
```





## 2、解题思路

思路很简单，主要是根据缩写进行判断，需要注意的就是以0开头的数字是不可以的





```python
class Solution:
    def validWordAbbreviation(self, word: str, abbr: str) -> bool:
        
        pos = 0
        abbr_pos = 0
        num = ''
        while abbr_pos < len(abbr):
            if abbr[abbr_pos].isdigit():
                num += abbr[abbr_pos]
                if num.startswith('0'):
                    return False
            if abbr[abbr_pos].isalpha():
                if num:
                    pos += int(num)
                    num = ''
                if pos >= len(word) or abbr[abbr_pos] != word[pos]:
                    return False
                pos += 1

            abbr_pos += 1

        if num:
            pos += int(num)

        if pos == len(word):
            return True

        return False
        
```

