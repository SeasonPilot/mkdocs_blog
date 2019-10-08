# LeetCode: 816. 模糊坐标

[TOC]

## 1、题目描述

我们有一些二维坐标，如 `"(1, 3)"` 或 `"(2, 0.5)"`，然后我们移除所有逗号，小数点和空格，得到一个字符串`S`。返回所有可能的原始字符串到一个列表中。

原始的坐标表示法不会存在多余的零，所以不会出现类似于`"00", "0.0", "0.00", "1.0", "001", "00.01"`或一些其他更小的数来表示坐标。此外，一个小数点前至少存在一个数，所以也不会出现`“.1”`形式的数字。

最后返回的列表可以是任意顺序的。而且注意返回的两个数字中间（逗号之后）都有一个空格。

 

**示例 1:**

```
输入: "(123)"
输出: ["(1, 23)", "(12, 3)", "(1.2, 3)", "(1, 2.3)"]
```

**示例 2:**

```
输入: "(00011)"
输出:  ["(0.001, 1)", "(0, 0.011)"]
解释: 
0.0, 00, 0001 或 00.01 是不被允许的。
```

**示例 3:**

```
输入: "(0123)"
输出: ["(0, 123)", "(0, 12.3)", "(0, 1.23)", "(0.1, 23)", "(0.1, 2.3)", "(0.12, 3)"]
```

**示例 4:**

```
输入: "(100)"
输出: [(10, 0)]
解释: 
1.0 是不被允许的。
```

**提示:**

-   `4 <= S.length <= 12.`
-   `S[0] = "(", S[S.length - 1] = ")", 且字符串 S 中的其他元素都是数字。`



## 2、解题思路

-   首先进行左右分割，然后对左右两部分判断有几个整数和小数
-   然后对左右两个数组进行笛卡尔积得到所有的情况
-   对每一个分割情况都进行上述操作

注意：`', '`后面有一个空格



```python
from itertools import product

class Solution:
    def ambiguousCoordinates(self, S: str) -> List[str]:
        ans = []

        source = S[1:-1]
        length = len(source)

        for i in range(1, length):
            left = []
            right = []
            if i == 1:
                left.append(source[:i])
            else:
                if source[0] != "0":
                    left.append(source[:i])
                if source[i - 1] != "0":
                    left.append(source[0] + "." + source[1:i])

                    if source[0] != "0":
                        for pos in range(2, i):
                            left.append(source[:pos] + "." + source[pos:i])
            if i == length - 1:
                right.append(source[i:])
            else:
                if source[i] != "0":
                    right.append(source[i:])
                if source[-1] != "0":
                    right.append(source[i] + "." + source[i + 1:])
                    if source[i] != "0":
                        for pos in range(i + 2, length):
                            right.append(source[i:pos] + "." + source[pos:])

            if left and right:
                for l, r in product(left, right):
                    ans.append("(" + l + ", " + r + ")")
        return ans
```

