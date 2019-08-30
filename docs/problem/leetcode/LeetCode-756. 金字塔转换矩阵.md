# LeetCode: 756. 金字塔转换矩阵

[TOC]

## 1、题目描述

现在，我们用一些方块来堆砌一个金字塔。 每个方块用仅包含一个字母的字符串表示，例如 `“Z”`。

使用三元组表示金字塔的堆砌规则如下：

`(A, B, C)` 表示，`“C”`为顶层方块，方块`“A”、“B”`分别作为方块`“C”`下一层的的左、右子块。当且仅当`(A, B, C)`是被允许的三元组，我们才可以将其堆砌上。

初始时，给定金字塔的基层 `bottom`，用一个字符串表示。一个允许的三元组列表 `allowed`，每个三元组用一个长度为 `3` 的字符串表示。

如果可以由基层一直堆到塔尖返回`true`，否则返回`false`。

**示例 1:**

```
输入: bottom = "XYZ", allowed = ["XYD", "YZE", "DEA", "FFF"]
输出: true
解析:
可以堆砌成这样的金字塔:
    A
   / \
  D   E
 / \ / \
X   Y   Z

因为符合('X', 'Y', 'D'), ('Y', 'Z', 'E') 和 ('D', 'E', 'A') 三种规则。
```


**示例 2:**

```
输入: bottom = "XXYX", allowed = ["XXX", "XXY", "XYX", "XYY", "YXZ"]
输出: false
解析:
无法一直堆到塔尖。
注意, 允许存在三元组(A, B, C)和 (A, B, D) ，其中 C != D.
```


**注意：**

- `bottom 的长度范围在 [2, 8]。`
- `allowed 的长度范围在[0, 200]。`
- `方块的标记字母范围为{'A', 'B', 'C', 'D', 'E', 'F', 'G'}。`



## 2、解题思路

- 使用递归的思路，分层构造
- 首先构造上面一层，将所有可能都尝试一遍
- 如果已经构造到顶层，返回True
- 如果当前层已经构造完毕，重新构造下一层，当前层和上层的长度差1
- 对当前所有可能出现的组合进行遍历



```python
from collections import defaultdict


class Solution:
    def pyramidTransition(self, bottom: str, allowed: List[str]) -> bool:
        mapping = defaultdict(list)
        for a in allowed:
            mapping[a[:2]].append(a[-1])

        def dfs(current, above):
            if len(current) == 2 and len(above) == 1:
                return True

            if len(current) == len(above) + 1:
                return dfs(above, "")

            pos = len(above)

            for c in mapping[current[pos:pos + 2]]:
                if dfs(current, above + c):
                    return True
            return False

        return dfs(bottom, "")

```

