# C-单词接龙

[TOC]

```
牛客假日团队赛9
```

## 1、题目描述

单词接龙是一个与我们经常玩的成语接龙相类似的游戏，现在我们已知一组单词，且给定一个开头的字母，要求出以这个字母开头的最长的“龙”（每个单词都最多在“龙”中出现两次），在两个单词相连时，其重合部分合为一部分，例如beast和astonish，如果接成一条龙则变为beastonish，另外相邻的两部分不能存在包含关系，例如at和atide间不能相连。

[链接](https://ac.nowcoder.com/acm/contest/1071/C)

### 输入描述:

```
输入的第一行为一个单独的整数n(n ≤ 20)表示单词数，以下n行每行有一个单词，输入的最后一行为一个单个字符，表示“龙”开头的字母。你可以假定以此字母开头的“龙”一定存在.
```

### 输出描述:

```
只需输出以此字母开头的最长的“龙”的长度
```

### 示例1

#### 输入

```
5
at
touch
cheat
choose
tact
a
```

#### 输出

```
23
```

### 说明

```
连成的“龙”为atoucheatactactouchoose
```



## 2、解题思路

- 先将所有单词可能出现的前缀放入字典中
- 采用dfs+回溯，同时考虑单词出现的次数



```python
from collections import defaultdict

# init
res = 1
appear_nums = defaultdict(int)
words = []


def solve(first, length):
    global res
    res = max(res, length)
    if first in head_mapping:
        for w in head_mapping[first]:
            if appear_nums[w] < 2:
                appear_nums[w] += 1
                for i in range(len(w) - 1, 0, -1):
                    solve(w[i:], len(w) + length - len(first))
                appear_nums[w] -= 1


total = int(input().strip())

for i in range(total):
    words.append(input().strip())

head_mapping = defaultdict(set)

for word in words:
    for i in range(1, len(word)):
        head_mapping[word[:i]].add(word)
head_char = input().strip()

solve(head_char, 1)
print(res)

```

