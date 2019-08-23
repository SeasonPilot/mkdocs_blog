# LeetCode: 763. 划分字母区间

[TOC]

## 1、题目描述

字符串 S 由小写字母组成。我们要把这个字符串划分为尽可能多的片段，同一个字母只会出现在其中的一个片段。返回一个表示每个字符串片段的长度的列表。

**示例 1:**

```
输入: S = "ababcbacadefegdehijhklij"
输出: [9,7,8]
解释:
划分结果为 "ababcbaca", "defegde", "hijhklij"。
每个字母最多出现在一个片段中。
像 "ababcbacadefegde", "hijhklij" 的划分是错误的，因为划分的片段数较少。
```

**注意:**

- S的长度在`[1, 500]`之间。

- S只包含小写字母`'a'`到`'z'`。

## 2、解题思路

- 统计字符串中字符出现的次数
- 每一次判断出前面一段字符串中的字符耗尽了这个字符在整个字符串中的次数以后，加入到结果集中



```python
class Solution:
    def partitionLabels(self, S: str) -> List[int]:
        from collections import Counter

        c = Counter(S)
        temp = {}

        pre = 0

        res = []
        for index, i in enumerate(S):
            if not temp and index != pre:
                res.append(index - pre)
                pre = index

            if i in temp:
                temp[i] -= 1
                if temp[i] == 0:
                    temp.pop(i)
            else:
                if c[i] > 1:
                    temp[i] = c[i] - 1
        res.append(len(S) - pre)
        return res
```

