# LeetCode: 1156. 单字符重复子串的最大长度

[TOC]

## 1、题目描述

如果字符串中的所有字符都相同，那么这个字符串是单字符重复的字符串。

给你一个字符串 `text`，你只能交换其中两个字符一次或者什么都不做，然后得到一些单字符重复的子串。返回其中最长的子串的长度。

 

**示例 1：**

```
输入：text = "ababa"
输出：3
```


**示例 2：**

```
输入：text = "aaabaaa"
输出：6
```


**示例 3：**

```
输入：text = "aaabbaaa"
输出：4
```


**示例 4：**

```
输入：text = "aaaaa"
输出：5
```


**示例 5：**

```
输入：text = "abcdef"
输出：1
```

**提示：**

-   `1 <= text.length <= 20000`
-   `text 仅由小写英文字母组成。`



## 2、解题思路

-   分段法
-   首先统计所有的字母出现的次数
-   然后对连续出现的进行分段，判断能否通过一次替换得到连续的更长的单字符重复子串



```python
from collections import Counter


class Solution:
    def maxRepOpt1(self, text: str) -> int:
        length = len(text)
        count = Counter(text)
        segment = [[text[0], 1]]
        ans = 1
        for i in range(1, length):
            if text[i] == segment[-1][0]:
                segment[-1][1] += 1
            else:
                ans = max(ans, min(segment[-1][1] + 1, count[segment[-1][0]]))
                segment.append([text[i], 1])

        ans = max(ans, segment[-1][1])

        for i in range(2, len(segment)):
            left, left_num = segment[i - 2]
            mid, mid_num = segment[i - 1]
            right, right_num = segment[i]

            if left == right and mid_num == 1:
                if left_num + right_num < count[left]:
                    ans = max(ans, left_num + right_num + 1)
                else:
                    ans = max(ans, left_num + right_num)

        return ans
```

