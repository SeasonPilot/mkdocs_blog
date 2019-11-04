# LeetCode: 1202. 交换字符串中的元素

[TOC]

## 1、题目描述

给你一个字符串 `s`，以及该字符串中的一些「索引对」数组 `pairs`，其中 `pairs[i] = [a, b]` 表示字符串中的两个索引（编号从 `0` 开始）。

你可以 任意多次交换 在 `pairs` 中任意一对索引处的字符。

返回在经过若干次交换后，`s` 可以变成的按字典序最小的字符串。

 

**示例 1:**

```
输入：s = "dcab", pairs = [[0,3],[1,2]]
输出："bacd"
解释： 
交换 s[0] 和 s[3], s = "bcad"
交换 s[1] 和 s[2], s = "bacd"
```


**示例 2：**

```
输入：s = "dcab", pairs = [[0,3],[1,2],[0,2]]
输出："abcd"
解释：
交换 s[0] 和 s[3], s = "bcad"
交换 s[0] 和 s[2], s = "acbd"
交换 s[1] 和 s[2], s = "abcd"
```


**示例 3：**

```
输入：s = "cba", pairs = [[0,1],[1,2]]
输出："abc"
解释：
交换 s[0] 和 s[1], s = "bca"
交换 s[1] 和 s[2], s = "bac"
交换 s[0] 和 s[1], s = "abc"
```

**提示：**

-   $1 <= s.length <= 10^5$
-   $0 <= pairs.length <= 10^5$
-   $0 <= pairs[i][0], pairs[i][1] < s.length$
-   `s 中只含有小写英文字母`



## 2、解题思路

-   基本思路为将所有能够相关交换的位置的字母按照字典序排序，一次放入对应的位置中
-   使用并查集，将所有的能够联通的位置放到一个集合中，进行排序



```python
from collections import defaultdict
from collections import deque


class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            self.data[xp] = yp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: List[List[int]]) -> str:
        length = len(s)
        ans = [""] * length

        d = DFU(length)
        for x, y in pairs:
            d.union(x, y)
        change_pairs = defaultdict(list)

        for i in range(length):
            change_pairs[d.find(i)].append(s[i])

        for key in change_pairs.keys():
            change_pairs[key].sort(reverse=True)

        for i in range(length):
            ans[i] = change_pairs[d.find(i)].pop()
        return "".join(ans)

```

