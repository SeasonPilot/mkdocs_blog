# LeetCode: 1087. 字母切换

[TOC]

## 1、题目描述

我们用一个特殊的字符串 `S` 来表示一份单词列表，之所以能展开成为一个列表，是因为这个字符串 `S` 中存在一个叫做「选项」的概念：

单词中的每个字母可能只有一个选项或存在多个备选项。如果只有一个选项，那么该字母按原样表示。

如果存在多个选项，就会以花括号包裹来表示这些选项（使它们与其他字母分隔开），例如 `"{a,b,c}"` 表示 `["a", "b", "c"]`。

**例子：**`"{a,b,c}d{e,f}"` 可以表示单词列表 `["ade", "adf", "bde", "bdf", "cde", "cdf"]`。

请你按字典顺序，返回所有以这种方式形成的单词。

 

**示例 1：**

```
输入："{a,b}c{d,e}f"
输出：["acdf","acef","bcdf","bcef"]
```


**示例 2：**

```
输入："abcd"
输出：["abcd"]
```

**提示：**

-   $1 <= S.length <= 50$
-   你可以假设题目中不存在嵌套的花括号
-   在一对连续的花括号（开花括号与闭花括号）之间的所有字母都不会相同



## 2、解题思路

-   每次查找左右括号，然后与前面的已有结果集连接



```python
class Solution:
    def expand(self, S: str) -> List[str]:
        ans = []
        length = len(S)
        pos = 0
        while pos < length:
            left_index = S.find("{", pos)
            if left_index == -1:
                if not ans:
                    ans.append(S[pos:])
                else:
                    for i in range(len(ans)):
                        ans[i] += S[pos:]
                pos = length
            else:
                temp = []
                right_index = S.find("}", left_index)
                current = S[left_index + 1:right_index].split(',')
                if left_index > pos:
                    if not ans:
                        ans.append(S[pos:left_index])
                    else:
                        for i in range(len(ans)):
                            ans[i] += S[pos:left_index]
                    for cur in current:
                        for cur_ans in ans:
                            temp.append(cur_ans + cur)
                    ans = temp
                else:
                    if not ans:
                        ans.extend(current)
                    else:
                        for cur in current:
                            for cur_ans in ans:
                                temp.append(cur_ans + cur)
                        ans = temp

                pos = right_index + 1

        return sorted(ans)
```

