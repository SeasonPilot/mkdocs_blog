# LeetCode: 76. 最小覆盖子串

[TOC]

## 1、题目描述

给你一个字符串 S、一个字符串 T，请在字符串 S 里面找出：包含 T 所有字母的最小子串。

**示例：**

```
输入: S = "ADOBECODEBANC", T = "ABC"
输出: "BANC"
```



**说明：**

- 如果 S 中不存这样的子串，则返回空字符串 ""。
- 如果 S 中存在这样的子串，我们保证它是唯一的答案。



## 2、解题思路

- 滑动串口法

- 如果`s`和`t`有一个是空，返回空
- 统计`t`中各个字符出现的次数
- 记录结果大小，左指针，右指针
- 设置左指针，右指针
- 记录匹配字符数量（等于t中字符数量）
- 每一次，首先将right所对应的字符添加进去，然后判断是否能够满足条件
  - 如果满足条件，更新结果值，并且将left右移，直到不满足条件为止
  - 如果不满足条件，继续右移



```python
from collections import Counter, defaultdict


class Solution:
    def minWindow(self, s: str, t: str) -> str:

        if not s or not t:
            return ""

        target_count = Counter(t)

        ans = float('inf'), 0, 0

        formed = 0
        required = len(target_count)
        windows_count = defaultdict(int)

        left, right = 0, 0

        while right < len(s):
            ch = s[right]

            if ch in target_count:
                windows_count[ch] += 1
                if windows_count[ch] == target_count[ch]:
                    formed += 1

            while left <= right and formed == required:
                left_ch = s[left]
                if right - left + 1 < ans[0]:
                    ans = right - left + 1, left, right

                if left_ch in target_count:
                    windows_count[left_ch] -= 1
                    if windows_count[left_ch] < target_count[left_ch]:
                        formed -= 1
                left += 1
            right += 1

        return "" if ans[0] == float('inf') else s[ans[1]:ans[2] + 1]
```



- 右指针可以直接采用`enumerate`获取

```python
from collections import Counter, defaultdict


class Solution:
    def minWindow(self, s: str, t: str) -> str:

        if not s or not t:
            return ""

        target_count = Counter(t)

        ans = float('inf'), 0, 0

        formed = 0
        required = len(target_count)
        windows_count = defaultdict(int)

        left, right = 0, 0

        while right < len(s):
            ch = s[right]

            if ch in target_count:
                windows_count[ch] += 1
                if windows_count[ch] == target_count[ch]:
                    formed += 1

            while left <= right and formed == required:
                left_ch = s[left]
                if right - left + 1 < ans[0]:
                    ans = right - left + 1, left, right

                if left_ch in target_count:
                    windows_count[left_ch] -= 1
                    if windows_count[left_ch] < target_count[left_ch]:
                        formed -= 1
                left += 1
            right += 1

        return "" if ans[0] == float('inf') else s[ans[1]:ans[2] + 1]
```

