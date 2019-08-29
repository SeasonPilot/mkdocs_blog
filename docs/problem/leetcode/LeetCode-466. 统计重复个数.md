# LeetCode: 466. 统计重复个数

[TOC]

## 1、题目描述

定义由 `n` 个连接的字符串 `s` 组成字符串 `S`，即 `S = [s,n]`。例如，`["abc", 3]=“abcabcabc”`。

另一方面，如果我们可以从 `s2` 中删除某些字符使其变为 `s1`，我们称字符串 `s1` 可以从字符串 `s2` 获得。例如，`“abc”` 可以根据我们的定义从 `“abdbec”` 获得，但不能从 `“acbbe”` 获得。

现在给出两个非空字符串 `S1` 和 `S2`（每个最多 `100` 个字符长）和两个整数 `0 ≤ N1 ≤ 106` 和 `1 ≤ N2 ≤ 106`。现在考虑字符串 `S1` 和 `S2`，其中`S1=[s1,n1]`和`S2=[s2,n2]`。找出可以使`[S2,M]`从 `S1` 获得的最大整数 `M`。

**示例：**

```
输入：
s1 ="acb",n1 = 4
s2 ="ab",n2 = 2

返回：
2
```



## 2、解题思路

- 寻找重复规则

首先从前面开始向后匹配，这时候可能遇到重复规则，如下

```
s1:   abcd
s2:   dc

     abcd abcd abcd abcd abcd abcd
        d   cd   cd   cd   cd   cd
        3   23   23   23   23   23               s1下标
        0   10   10   10   10   10               s2下标
```

我们发现，同样的下标开始重复出现的时候，这时候我们可以利用你这个规则直接匹配到最后一个重复的位置

然后从这个位置继续计算



```python
class Solution:
    def getMaxRepetitions(self, s1: str, n1: int, s2: str, n2: int) -> int:
        
        if not set(s2).issubset(set(s1)):
            return 0

        mapping = {}

        length_s1 = len(s1)
        length_s2 = len(s2)

        pos_s1 = 0
        pos_s2 = 0

        while pos_s1 < length_s1 * n1:
            while s1[pos_s1 % length_s1] != s2[pos_s2 % length_s2]:
                pos_s1 += 1

            if pos_s1 >= length_s1 * n1:
                break
            if (pos_s1 % length_s1, pos_s2 % length_s2) not in mapping:
                mapping[(pos_s1 % length_s1, pos_s2 % length_s2)] = [pos_s1, pos_s2]
            else:
                pos1, pos2 = mapping[(pos_s1 % length_s1, pos_s2 % length_s2)]
                circle = (length_s1 * n1 - pos1) // (pos_s1 - pos1)
                pos_s1 = pos1 + circle * (pos_s1 - pos1)
                pos_s2 = pos2 + circle * (pos_s2 - pos2)
            if pos_s1 < length_s1 * n1:
                pos_s1 += 1
                pos_s2 += 1

        return pos_s2 // (length_s2 * n2)
```

