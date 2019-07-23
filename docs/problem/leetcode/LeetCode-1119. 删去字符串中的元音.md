# LeetCode: 1119. 删去字符串中的元音

[TOC]

## 1、题目描述

给你一个字符串 S，请你删去其中的所有元音字母`（ 'a'，'e'，'i'，'o'，'u'）`，并返回这个新字符串。

 ```
示例 1：
输入："leetcodeisacommunityforcoders"
输出："ltcdscmmntyfrcdrs"

示例 2：
输入："aeiou"
输出：""
 ```



**提示：**

- S 仅由小写英文字母组成。
-  $1 <= S.length <= 1000$ 

## 2、解题思路



```python
class Solution:
    def removeVowels(self, S: str) -> str:
        t = set(['a', 'e', 'i', 'o', 'u'])
        res = []
        for i in S:
            if i not in t:
                res.append(i)

        return "".join(res)
```

