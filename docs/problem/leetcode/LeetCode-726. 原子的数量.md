# LeetCode: 726. 原子的数量

[TOC]

## 1、题目描述

给定一个化学式`formula`（作为字符串），返回每种原子的数量。

原子总是以一个大写字母开始，接着跟随`0`个或任意个小写字母，表示原子的名字。

如果数量大于 `1`，原子后会跟着数字表示原子的数量。如果数量等于 `1` 则不会跟数字。例如，`H2O` 和 `H2O2` 是可行的，但 `H1O2` 这个表达是不可行的。

两个化学式连在一起是新的化学式。例如 `H2O2He3Mg4` 也是化学式。

一个括号中的化学式和数字（可选择性添加）也是化学式。例如 (`H2O2`) 和 `(H2O2)3` 是化学式。

给定一个化学式，输出所有原子的数量。格式为：第一个（按字典序）原子的名子，跟着它的数量（如果数量大于 `1`），然后是第二个原子的名字（按字典序），跟着它的数量（如果数量大于 `1`），以此类推。

**示例 1:**

```
输入: 
formula = "H2O"
输出: "H2O"
解释: 
原子的数量是 {'H': 2, 'O': 1}。
```


**示例 2:**

```
输入: 
formula = "Mg(OH)2"
输出: "H2MgO2"
解释: 
原子的数量是 {'H': 2, 'Mg': 1, 'O': 2}。
```


**示例 3:**

```
输入: 
formula = "K4(ON(SO3)2)2"
输出: "K4N2O14S4"
解释: 
原子的数量是 {'K': 4, 'N': 2, 'O': 14, 'S': 4}。
```


**注意:**

- `所有原子的第一个字母为大写，剩余字母都是小写。`
- `formula的长度在[1, 1000]之间。`
- `formula只包含字母、数字和圆括号，并且题目中给定的是合法的化学式。`



## 2、解题思路

- 首先进行预处理

首先将它们分成不同的部分

```
"Mg(OH)2"  => ['Mg', '(OH)2']
"((N42)24(OB40Li30CHe3O48LiNN26)33(C12Li48N30H13HBe31)21(BHN30Li26BCBe47N40)15(H5)16)14"
=>
['((N42)24(OB40Li30CHe3O48LiNN26)33(C12Li48N30H13HBe31)21(BHN30Li26BCBe47N40)15(H5)16)14']

'((N42)24(OB40Li30CHe3O48LiNN26)33(C12Li48N30H13HBe31)21(BHN30Li26BCBe47N40)15(H5)16)14'
=>
['(N42)24', '(OB40Li30CHe3O48LiNN26)33', '(C12Li48N30H13HBe31)21', '(BHN30Li26BCBe47N40)15', '(H5)16']
```



如上，将不同的部分进行拆分，然后针对括号中的进行递归处理

最后返回的结果为字典，按字典序排序后生成结果值

```python
from string import ascii_lowercase, ascii_uppercase, digits
from collections import defaultdict


class Solution:
    def countOfAtoms(self, formula: str) -> str:
        if not formula:
            return ""

        lower = set(ascii_lowercase)
        upper = set(ascii_uppercase)
        nums = set(digits)

        def get_atom(form):
            pass

            pre_processing = []

            length = len(form)
            pos = 0

            temp = []

            while pos < length:
                current = form[pos]
                if current in upper and not temp:
                    temp.append(current)
                elif current in lower or current in nums:
                    temp.append(current)
                elif current in upper and temp:
                    pre_processing.append("".join(temp))
                    temp = [current]
                elif current == "(":
                    if temp:
                        pre_processing.append("".join(temp))
                    start = pos
                    stack = ["("]
                    pos += 1
                    while pos < length:
                        if form[pos] == ")":
                            stack.pop()
                            if not stack:
                                break
                        elif form[pos] == "(":
                            stack.append("(")

                        pos += 1
                    temp = [form[start:pos+1]]
                pos += 1
            if temp:
                pre_processing.append("".join(temp))

            result = defaultdict(int)
            for s in pre_processing:
                if s[0] == "(":
                    count = 1
                    if s[-1] in nums:
                        count = int(s[s.rindex(")") + 1:])

                    for atom, n in get_atom(s[1:s.rindex(")")]).items():
                        result[atom] += n * count

                else:
                    if s[-1] in nums:
                        for index, char in enumerate(s):
                            if char in nums:
                                result[s[:index]] += int(s[index:])
                                break
                    else:
                        result[s] += 1
            return result

        res = get_atom(formula)
        ans = []
        for atom_name in sorted(res.keys()):
            if res[atom_name] == 1:
                ans.append(atom_name)

            elif res[atom_name] > 1:
                ans.append(atom_name + str(res[atom_name]))

        return "".join(ans)
```

