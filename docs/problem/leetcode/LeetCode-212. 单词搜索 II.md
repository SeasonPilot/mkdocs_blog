# LeetCode: 212. 单词搜索 II

[TOC]

## 1、题目描述

给定一个二维网格 `board` 和一个字典中的单词列表 `words`，找出所有同时在二维网格和字典中出现的单词。

单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母在一个单词中不允许被重复使用。

**示例:**

```
输入: 
words = ["oath","pea","eat","rain"] and board =
[
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]

输出: ["eat","oath"]
说明:
你可以假设所有输入都由小写字母 a-z 组成。
```

**提示:**

- 你需要优化回溯算法以通过更大数据量的测试。你能否早点停止回溯？
- 如果当前单词不存在于所有单词的前缀中，则可以立即停止回溯。什么样的数据结构可以有效地执行这样的操作？散列表是否可行？为什么？ 前缀树如何？如果你想学习如何实现一个基本的前缀树，请先查看这个问题： 实现Trie（前缀树）。




## 2、解题思路

- 使用字典树加回溯

在79题目中，搜索单个的单词，直接使用回溯法即可

本题目中，需要搜索多个单词，就需要判断当前字符下一个字符需要搜索什么，因此建立字典树，用来确定搜索范围



```python
class Solution:
    def findWords(self, board: List[List[str]], words: List[str]) -> List[str]:
        res = []
        row, col = len(board), len(board[0])

        trie = {}
        # 上下左右-坐标
        surround = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        # 坐标验证
        def available(m, n):
            return 0 <= m < row and 0 <= n < col

        for word in words:
            temp = trie
            for ch in word:
                temp = temp.setdefault(ch, {})
            temp["end"] = 1

        def backtrace(x, y, t, s):
            c = board[x][y]
            if c not in t:
                return

            t = t[c]
            if "end" in t and t["end"] == 1:
                res.append(s + c)
                t["end"] = 0
            board[x][y] = "#"

            for dx, dy in surround:
                x1, y1 = x + dx, y + dy
                if available(x1, y1) and board[x1][y1] != "#":
                    backtrace(x1, y1, t, s + c)
            board[x][y] = c

        for i in range(row):
            for j in range(col):
                backtrace(i, j, trie, "")
        return res
```

