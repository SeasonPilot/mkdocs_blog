# LeetCode: 161. 相隔为 1 的编辑距离

[TOC]

## 1、题目描述

给定两个字符串 s 和 t，判断他们的编辑距离是否为 1。

注意：

满足编辑距离等于 1 有三种可能的情形：

- 往 s 中插入一个字符得到 t
- 从 s 中删除一个字符得到 t
- 在 s 中替换一个字符得到 t

```
示例 1：

输入: s = "ab", t = "acb"
输出: true
解释: 可以将 'c' 插入字符串 s 来得到 t。
示例 2:

输入: s = "cab", t = "ad"
输出: false
解释: 无法通过 1 步操作使 s 变为 t。
示例 3:

输入: s = "1203", t = "1213"
输出: true
解释: 可以将字符串 s 中的 '0' 替换为 '1' 来得到 t。
```



## 2、解题思路

- 编辑距离为1，那么第二个字符串就会经过一步操作由第一个字符串得到
- 如果字符串长度差距大于1，表示至少插入两个字符，不满足要求
- 从头开始判断，如果遇到一个不相等的字符：
  - 如果两个字符串长度相同，表示我们可以选择替换这个字符，因此判断跳过这个字符串剩余部分是否相等即可
  - 如果长度不同，表示可以删除这个字符，因此长度更长的字符串跳过这个字符进行判断
- 如果长度较短的字符串s全部相同，要确认t是否是比s多一个字符，如果不多，编辑距离就为0了



```python
class Solution:
    def isOneEditDistance(self, s: str, t: str) -> bool:
        ls, lt = len(s), len(t)
        if ls > lt:
            return self.isOneEditDistance(t, s)

        if lt - ls > 1:
            return False

        for i in range(ls):
            if s[i] != t[i]:
                if ls == lt:
                    return s[i + 1:] == t[i + 1:]
                else:
                    return s[i:] == t[i + 1:]

        return ls + 1 == lt
```

