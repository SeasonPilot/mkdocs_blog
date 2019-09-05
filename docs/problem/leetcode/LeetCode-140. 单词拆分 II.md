# LeetCode: 140. 单词拆分 II

[TOC]

## 1、题目描述

给定一个非空字符串 `s` 和一个包含非空单词列表的字典 `wordDict`，在字符串中增加空格来构建一个句子，使得句子中所有的单词都在词典中。返回所有这些可能的句子。

**说明：**

- 分隔时可以重复使用字典中的单词。
- 你可以假设字典中没有重复的单词。

**示例 1：**

```
输入:
s = "catsanddog"
wordDict = ["cat", "cats", "and", "sand", "dog"]
输出:
[
  "cats and dog",
  "cat sand dog"
]
```


**示例 2：**

```
输入:
s = "pineapplepenapple"
wordDict = ["apple", "pen", "applepen", "pine", "pineapple"]
输出:
[
  "pine apple pen apple",
  "pineapple pen apple",
  "pine applepen apple"
]
解释: 注意你可以重复使用字典中的单词。
```


**示例 3：**

```
输入:
s = "catsandog"
wordDict = ["cats", "dog", "sand", "and", "cat"]
输出:
[]
```



## 2、解题思路

- 动态规划加上回溯
- 首先借助动态规划进行划分，判断当前字符串能否被分割，并且获得了相应可分隔位置的标记

```python
dp = [False] * (N + 1)
dp[0] = True

for i in range(1, N + 1):
    for j in range(i):
        if dp[j] and s[j:i] in word_mapping:
            dp[i] = True
            break
```



- 然后我们判断最后一个是否是`True`，如果是，就表示能够被分割
- 因此，从后面向前找单词进行回溯
- 如果找到的单词落到的点是`False`，就表示不可分割点，回溯，重新新寻找

代码如下：

```python
class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
        from collections import deque

        N = len(s)
        word_mapping = set(wordDict)
        dp = [False] * (N + 1)
        dp[0] = True

        for i in range(1, N + 1):
            for j in range(i):
                if dp[j] and s[j:i] in word_mapping:
                    dp[i] = True
                    break

        if not dp[N]:
            return []
        res = []

        temp = deque()

        def dfs(pos):
            if pos == 0:
                res.append(list(temp))
                return

            if not dp[pos]:
                return

            for p in range(pos - 1, -1, -1):
                if s[p:pos] in word_mapping:
                    temp.appendleft(s[p:pos])
                    dfs(p)
                    temp.popleft()

        dfs(N)
        return [" ".join(x) for x in res]
```

