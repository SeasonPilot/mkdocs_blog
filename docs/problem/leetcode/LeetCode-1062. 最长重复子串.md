# LeetCode: 1062. 最长重复子串

[TOC]

## 1、题目描述

给定字符串 `S`，找出最长重复子串的长度。如果不存在重复子串就返回 `0`。

 

**示例 1：**

```
输入："abcd"
输出：0
解释：没有重复子串。
```


**示例 2：**

```
输入："abbaba"
输出：2
解释：最长的重复子串为 "ab" 和 "ba"，每个出现 2 次。
```


**示例 3：**

```
输入："aabcaabdaab"
输出：3
解释：最长的重复子串为 "aab"，出现 3 次。
```


**示例 4：**

```
输入："aaaaa"
输出：4
解释：最长的重复子串为 "aaaa"，出现 2 次。
```

**提示：**

-   `字符串 S 仅包含从 'a' 到 'z' 的小写英文字母。`
-   `1 <= S.length <= 1500`



## 2、解题思路

-   二分法
-   如果长的元素出现了重复，那么肯定有比它短的元素重复，因此，直接采用二分逼近



```python
class Solution:
    def longestRepeatingSubstring(self, S: str) -> int:
        length = len(S)

        def check(sub_length):
            mapping = set()
            for i in range(length - sub_length + 1):
                if S[i:i + sub_length] in mapping:
                    return True
                else:
                    mapping.add(S[i:i + sub_length])
            return False

        left = 0
        right = length - 1
        while left < right:
            mid = left + (right - left) // 2 + 1
            if check(mid):
                left = mid
            else:
                right = mid - 1
        return left

```

