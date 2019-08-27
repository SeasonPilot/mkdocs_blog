# LeetCode: 990. 等式方程的可满足性

[TOC]

## 1、题目描述

给定一个由表示变量之间关系的字符串方程组成的数组，每个字符串方程 `equations[i]` 的长度为 `4`，并采用两种不同的形式之一：`"a==b"` 或 `"a!=b"`。在这里，`a` 和 `b` 是小写字母（不一定不同），表示单字母变量名。

只有当可以将整数分配给变量名，以便满足所有给定的方程时才返回 `true`，否则返回 `false`。 

 

**示例 1：**

```
输入：["a==b","b!=a"]
输出：false
解释：如果我们指定，a = 1 且 b = 1，那么可以满足第一个方程，但无法满足第二个方程。没有办法分配变量同时满足这两个方程。
```

**示例 2：**

```
输出：["b==a","a==b"]
输入：true
解释：我们可以指定 a = 1 且 b = 1 以满足满足这两个方程。
```

**示例 3：**

```
输入：["a==b","b==c","a==c"]
输出：true
```

**示例 4：**

```
输入：["a==b","b!=c","c==a"]
输出：false
```

**示例 5：**

```
输入：["c==c","b==d","x!=z"]
输出：true
```

**提示：**

- `1 <= equations.length <= 500`
- `equations[i].length == 4`
- `equations[i][0] 和 equations[i][3] 是小写字母`
- `equations[i][1] 要么是 '='，要么是 '!'`
- `equations[i][2] 是 '='`



## 2、解题思路

- 并查集

- 将所有相等的变量放到同一个集合中，判断不相等的变量是否在一个集合中



```python
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
    def equationsPossible(self, equations: List[str]) -> bool:
        mapping = {}
        count = 0
        for e in equations:
            if e[0] not in mapping:
                mapping[e[0]] = count
                count += 1
            if e[-1] not in mapping:
                mapping[e[-1]] = count
                count += 1

        d = DFU(len(mapping))

        for e in equations:
            if e[1] == "=":
                d.union(mapping[e[0]], mapping[e[-1]])

        for e in equations:
            if e[1] == "!":
                if d.find(mapping[e[0]]) == d.find(mapping[e[-1]]):
                    return False
        return True

```

