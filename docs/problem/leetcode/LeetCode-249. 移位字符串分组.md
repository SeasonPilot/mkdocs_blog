# LeetCode: 249. 移位字符串分组

[TOC]

## 1、题目描述

给定一个字符串，对该字符串可以进行 “移位” 的操作，也就是将字符串中每个字母都变为其在字母表中后续的字母，比如：`"abc" -> "bcd"`。这样，我们可以持续进行 “移位” 操作，从而生成如下移位序列：

`"abc" -> "bcd" -> ... -> "xyz"`
给定一个包含仅小写字母字符串的列表，将该列表中所有满足 “移位” 操作规律的组合进行分组并返回。

**示例：**

```
输入: ["abc", "bcd", "acef", "xyz", "az", "ba", "a", "z"]
输出: 
[
  ["abc","bcd","xyz"],
  ["az","ba"],
  ["acef"],
  ["a","z"]
]
```



## 2、解题思路

- 如果是单独的字符，放到同一个分组中
- 将每个字符串设计他的规则，将字符串后面字符与前面字符之差连起来作为key，key相同的字符串放到同一个分组中



```python
from collections import defaultdict


class Solution:
    def groupStrings(self, strings: [str]) -> [[str]]:
        if not strings:
            return []

        buff = defaultdict(list)
        res = []
        length_1 = []

        for i in strings:
            if len(i) == 1:
                length_1.append(i)
            else:
                sign = ""
                count = 1
                while count < len(i):
                    sign += str(((ord(i[count]) - ord(i[count - 1])) + 26) % 26)
                    count += 1
                buff[sign].append(i)
        if length_1:
            res.append(length_1)
        res.extend(list(buff.values()))
        return res
```

