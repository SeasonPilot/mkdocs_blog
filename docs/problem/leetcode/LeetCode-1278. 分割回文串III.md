# LeetCode: 1278. 分割回文串III

[TOC]

## 1、题目描述

给你一个由小写字母组成的字符串 `s`，和一个整数 `k`。

请你按下面的要求分割字符串：

-   首先，你可以将 `s` 中的部分字符修改为其他的小写英文字母。
-   接着，你需要把 `s` 分割成 `k` 个非空且不相交的子串，并且每个子串都是回文串。

请返回以这种方式分割字符串所需修改的最少字符数。

 

**示例 1：**

```
输入：s = "abc", k = 2
输出：1
解释：你可以把字符串分割成 "ab" 和 "c"，并修改 "ab" 中的 1 个字符，将它变成回文串。
```


**示例 2：**

```
输入：s = "aabbc", k = 3
输出：0
解释：你可以把字符串分割成 "aa"、"bb" 和 "c"，它们都是回文串。
```


**示例 3：**

```
输入：s = "leetcode", k = 8
输出：0
```

**提示：**

-   $1 <= k <= s.length <= 100$
-   `s` 中只含有小写英文字母。



## 2、解题思路

-   首先使用dp计算任意两段变成回文串需要改变的字符数量
-   然后使用dfs加记忆化，找出哪一种分段能够找出最小的字符变化



```python
from functools import lru_cache


class Solution:
    def palindromePartition(self, s: str, k: int) -> int:
        length = len(s)
        if length <= 1:
            return 0

        dp = [[0 for _ in range(length)] for _ in range(length)]

        for sep in range(0, length):
            for i in range(length):
                j = i + sep
                if i + sep < length:
                    if i == j:
                        dp[i][j] = 0
                    elif j == i + 1:
                        if s[i] == s[j]:
                            dp[i][j] = 0
                        else:
                            dp[i][j] = 1
                    else:
                        if s[i] == s[j]:
                            dp[i][j] = dp[i + 1][j - 1]
                        else:
                            dp[i][j] = dp[i + 1][j - 1] + 1

        @lru_cache(None)
        def dfs(start, end, k):
            if end - start + 1 == k:
                return 0
            if k == 1:
                return dp[start][end]

            ans = float('inf')
            for index in range(start, end - k + 2):
                ans = min(ans, dp[start][index] + dfs(index + 1, end, k - 1))
            return ans

        return dfs(0, length - 1, k)

```

