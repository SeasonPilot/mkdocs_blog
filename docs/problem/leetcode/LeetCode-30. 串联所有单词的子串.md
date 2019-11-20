# LeetCode: 30. 串联所有单词的子串

[TOC]

## 1、题目描述

给定一个字符串 `s` 和一些长度相同的单词 `words`。找出 `s` 中恰好可以由 `words` 中所有单词串联形成的子串的起始位置。

注意子串要与 `words` 中的单词完全匹配，中间不能有其他字符，但不需要考虑 `words` 中单词串联的顺序。

 

**示例 1：**

```
输入：
  s = "barfoothefoobarman",
  words = ["foo","bar"]
输出：[0,9]
解释：
从索引 0 和 9 开始的子串分别是 "barfoo" 和 "foobar" 。
输出的顺序不重要, [9,0] 也是有效答案。
```

**示例 2：**

```
输入：
  s = "wordgoodgoodgoodbestword",
  words = ["word","good","best","word"]
输出：[]
```

 

## 2、解题思路

-   首先将所有的索引对应的单词用字典进行标记
-   设单词长度为`word_length`，所有单词长度为`total_length`

```
首先从0开始，0到total_length之间的单词进行统计，使用单个变量进行标记
- negative  表示当前范围中这个单词的待匹配数量为负
- zero      表示当前范围中这个单词的待匹配数量为0
- positive  表示当前范围中这个单词的待匹配数量为正

一开始，positive就等于待匹配数量，匹配一个，zero增加1，positive减少1
判断zero是否等于单词数量即可知道当前范围的字符串是否匹配成功
```

-   然后从`[0,word_length)`作为起点进行遍历即可，不断更新三个变量进行判断



```python
from collections import Counter
import copy


class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not words:
            return []
        if len(set(words)) == 1 and words[0] == "":
            return list(range(len(words) + 1))

        count = Counter(words)
        ans = []
        length = len(s)
        per_word_length = len(words[0])
        total_word_length = per_word_length * len(words)
        mapping = {}

        for i in range(length - per_word_length + 1):
            temp = s[i:i + per_word_length]
            if temp in count:
                mapping[i] = temp

        for start in range(per_word_length):
            cur_count = copy.copy(count)
            if start + total_word_length <= length:
                negative, zero, positive = 0, 0, len(cur_count)
                for i in range(start, total_word_length, per_word_length):
                    if i in mapping:
                        w = mapping[i]
                        pre = cur_count[w]
                        cur_count[w] -= 1
                        if pre == 1:
                            positive -= 1
                            zero += 1
                        elif pre == 0:
                            zero -= 1
                            negative += 1

                if zero == len(cur_count):
                    ans.append(start)

                for i in range(start + per_word_length, length, per_word_length):
                    if i + total_word_length <= length:
                        before = i - per_word_length
                        after = i + total_word_length - per_word_length
                        if before in mapping:
                            pre = cur_count[mapping[before]]
                            cur_count[mapping[before]] += 1
                            if pre == -1:
                                negative -= 1
                                zero += 1
                            elif pre == 0:
                                zero -= 1
                                positive += 1
                        if after in mapping:
                            pre = cur_count[mapping[after]]
                            cur_count[mapping[after]] -= 1
                            if pre == 1:
                                positive -= 1
                                zero += 1
                            elif pre == 0:
                                zero -= 1
                                negative += 1
                        if zero == len(cur_count):
                            ans.append(i)
                    else:
                        break
            else:
                break

        return sorted(ans)
```


