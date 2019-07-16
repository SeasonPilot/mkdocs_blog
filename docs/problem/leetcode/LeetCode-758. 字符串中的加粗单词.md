# LeetCode: 758. 字符串中的加粗单词

[TOC]

## 1、题目描述

给定一个关键词集合 words 和一个字符串 S，将所有 S 中出现的关键词加粗。所有在标签 <b> 和 </b> 中的字母都会加粗。

返回的字符串需要使用尽可能少的标签，当然标签应形成有效的组合。

例如，给定 words = ["ab", "bc"] 和 S = `"aabcd"` ，需要返回 `"a<b>abc</b>d"` 。注意返回` "a<b>a<b>b</b>c</b>d"`  会使用更多的标签，因此是错误的。

 

**注：**

1. words 长度的范围为 [0, 50]。
2. words[i] 长度的范围为 [1, 10]。
3. S 长度的范围为 [0, 500]。
4. 所有 words[i] 和 S 中的字符都为小写字母。

## 2、解题思路

- 设置一个辅助数组，用来存储当前位置是否满足条件
- 遍历辅助数组，满足条件添加相应的加粗字符



```python
class Solution:
    def boldWords(self, words: List[str], S: str) -> str:
        
        buff = [False] * len(S)
        min_length = len(min(words, key=len))
        max_length = len(max(words, key=len))
        if len(S) < min_length:
            return S

        words.sort(key=len,reverse=True)
        for index in range(len(S)):
            for w in words:
                if S[index:].startswith(w):
                    buff[index:index + len(w)] = [True] * len(w)
                    break
        print(buff)
        res = ""
        for index, i in enumerate(buff):
            if i:
                if index == 0 or not buff[index - 1]:
                    res += "<b>" + S[index]

                elif buff[index - 1]:
                    res += S[index]
            else:
                if index == 0 or not buff[index - 1]:
                    res += S[index]
                elif buff[index - 1]:
                    res += "</b>" + S[index]

        if buff[-1]:
            res += "</b>"
        return res
```



- 下面针对生成辅助数组做了一点优化
- 按照不同的关键词进行查找，找到则更新对应的位置

```python
class Solution:
    def boldWords(self, words: List[str], S: str) -> str:
        
        
        buff = [False] * len(S)
        min_length = len(min(words, key=len))
        max_length = len(max(words, key=len))
        if len(S) < min_length:
            return S

        left = 0
        for w in words:
            left = 0
            while left < len(S):
                pos = S[left:].find(w)
                if pos != -1:
                    buff[left + pos:left + pos + len(w)] = [True] * len(w)
                    left += pos + 1
                else:
                    break

        res = ""
        for index, i in enumerate(buff):
            if i:
                if index == 0 or not buff[index - 1]:
                    res += "<b>" + S[index]

                elif buff[index - 1]:
                    res += S[index]
            else:
                if index == 0 or not buff[index - 1]:
                    res += S[index]
                elif buff[index - 1]:
                    res += "</b>" + S[index]

        if buff[-1]:
            res += "</b>"
        return res
```

