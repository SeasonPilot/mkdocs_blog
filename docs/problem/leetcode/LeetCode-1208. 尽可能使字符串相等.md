# LeetCode: 1208. 尽可能使字符串相等

[TOC]

## 1、题目描述

给你两个长度相同的字符串，`s` 和 `t`。

将 `s` 中的第 `i` 个字符变到 `t` 中的第 `i` 个字符需要 `|s[i] - t[i]|` 的开销（开销可能为 `0`），也就是两个字符的 `ASCII` 码值的差的绝对值。

用于变更字符串的最大预算是 `maxCost`。在转化字符串时，总开销应当小于等于该预算，这也意味着字符串的转化可能是不完全的。

如果你可以将 `s` 的子字符串转化为它在 `t` 中对应的子字符串，则返回可以转化的最大长度。

如果 `s` 中没有子字符串可以转化成 `t` 中对应的子字符串，则返回 `0`。

 

**示例 1：**

```
输入：s = "abcd", t = "bcdf", cost = 3
输出：3
解释：s 中的 "abc" 可以变为 "bcd"。开销为 3，所以最大长度为 3。
```


**示例 2：**

```
输入：s = "abcd", t = "cdef", cost = 3
输出：1
解释：s 中的任一字符要想变成 t 中对应的字符，其开销都是 2。因此，最大长度为 1。
```


**示例 3：**

```
输入：s = "abcd", t = "acde", cost = 0
输出：1
解释：你无法作出任何改动，所以最大长度为 1。
```

**提示：**

-   `1 <= s.length, t.length <= 10^5`
-   `0 <= maxCost <= 10^6`
-   `s 和 t 都只含小写英文字母。`



## 2、解题思路

-   双端队列滑动窗口
-   滑动窗口使用双端队列实现
-   保存窗口的损失
    -   如果当前损失大于最大损失，清空窗口
    -   如果当前损失加上窗口损失大于总损失，将窗口左侧损失弹出，直到损失小于等于最大损失为止



```python
from collections import deque


class Solution:
    def equalSubstring(self, s: str, t: str, maxCost: int) -> int:
        windows = deque()
        ans = 0
        cost = 0
        for x, y in zip(s, t):
            diff = abs(ord(x) - ord(y))
            if diff > maxCost:
                cost = 0
                windows.clear()
                continue
            while cost + diff > maxCost:
                cost -= windows.popleft()

            cost += diff
            windows.append(diff)
            ans = max(ans, len(windows))

        return ans
```

