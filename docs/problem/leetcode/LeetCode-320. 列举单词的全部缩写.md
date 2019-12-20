# LeetCode: 320. 列举单词的全部缩写

[TOC]

## 1、题目描述

请你写出一个能够举单词全部缩写的函数。

注意：输出的顺序并不重要。

**示例：**

```
输入: "word"
输出:
["word", "1ord", "w1rd", "wo1d", "wor1", "2rd", "w2d", "wo2", "1o1d", "1or1", "w1r1", "1o2", "2r1", "3d", "w3", "4"]


```



## 2、解题思路

-   DFS生成
-   每个字符都有两种情况
    -   直接放字符
    -   放数字，数字的情况需要考虑能够与前面数字合并

```python
class Solution:
    def generateAbbreviations(self, word: str) -> List[str]:
        length = len(word)

        ans = []

        def dfs(current, pos):
            if pos >= length:
                ans.append(current)
                return
            dfs(current + word[pos], pos + 1)

            last_num_pos = len(current)
            while last_num_pos > 0 and current[last_num_pos - 1].isdigit():
                last_num_pos -= 1
            if last_num_pos < len(current):
                dfs(current[:last_num_pos] + str(int(current[last_num_pos:]) + 1), pos + 1)
            else:
                dfs(current + "1", pos + 1)

        dfs("", 0)

        return ans
```

