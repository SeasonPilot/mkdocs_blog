# LeetCode: 1079. 活字印刷

[TOC]

## 1、题目描述

你有一套活字字模 tiles，其中每个字模上都刻有一个字母 tiles[i]。返回你可以印出的非空字母序列的数目。

 

**示例 1：**

```
输入："AAB"
输出：8
解释：可能的序列为 "A", "B", "AA", "AB", "BA", "AAB", "ABA", "BAA"。
```



**示例 2：**

```
输入："AAABBC"
输出：188
```



**提示：**

- `1 <= tiles.length <= 7`

- `tiles` 由大写英文字母组成

## 2、解题思路

- 回溯法
- 设置一个结果集，由于模板中有重复字符，因此需要去重操作

```python
class Solution:
    def numTilePossibilities(self, tiles: str) -> int:
        length = len(tiles)
        visited = [False] * length

        res = set()
        temp = []

        def dfs():
            nonlocal res, temp
            for i in range(length):
                if not visited[i]:
                    temp.append(tiles[i])
                    visited[i] = True
                    res.add("".join(temp))
                    dfs()
                    visited[i] = False
                    temp.pop()

        dfs()

        return len(res)
```

