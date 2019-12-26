# LeetCode: 555. 分割连接字符串

[TOC]

## 1、题目描述

给定一个字符串列表，你可以将这些字符串连接成一个循环字符串，对于每个字符串，你可以选择是否翻转它。在所有可能的循环字符串中，你需要分割循环字符串（这将使循环字符串变成一个常规的字符串），然后找到字典序最大的字符串。

具体来说，要找到字典序最大的字符串，你需要经历两个阶段：

1.  将所有字符串连接成一个循环字符串，你可以选择是否翻转某些字符串，并按照给定的顺序连接它们。
2.  在循环字符串的某个位置分割它，这将使循环字符串从分割点变成一个常规的字符串。

你的工作是在所有可能的常规字符串中找到字典序最大的一个。

**示例:**

```
输入: "abc", "xyz"
输出: "zyxcba"
解释: 你可以得到循环字符串 "-abcxyz-", "-abczyx-", "-cbaxyz-", "-cbazyx-"，
其中 '-' 代表循环状态。 
答案字符串来自第四个循环字符串， 
你可以从中间字符 'a' 分割开然后得到 "zyxcba"。
```

**注意:**

-   输入字符串只包含小写字母。
-   所有字符串的总长度不会超过 `1,000`。



## 2、解题思路

-   首先判断每个字符串反转是不是字典序更大，更大则反转
-   然后从第一个字符串开始，找分界点
-   除了分界点的字符串，其他的字符串皆为上面更大字典序的排列



```python
class Solution:
    def splitLoopedString(self, strs: List[str]) -> str:
        temp = strs[:]
        length = len(strs)
        for index, st in enumerate(strs):
            cur = "".join(reversed(st))
            if cur > st:
                temp[index] = cur
        temp = "".join(temp)
        ans = temp
        pos = 0

        for i in range(length):
            cur_length = len(strs[i])
            current = strs[i]
            reverse_current = "".join(reversed(strs[i]))
            for j in range(cur_length):
                ans = max(ans, current[j:] + temp[pos + cur_length:] + temp[:pos] + current[:j])
                ans = max(ans, reverse_current[j:] + temp[pos + cur_length:] + temp[:pos] + reverse_current[:j])
            pos += cur_length
        return ans
```

