# LeetCode: 730. 统计不同回文子字符串

[TOC]

## 1、题目描述

给定一个字符串 `S`，找出 `S` 中不同的非空回文子序列个数，并返回该数字与 `10^9 + 7` 的模。

通过从 `S` 中删除 `0` 个或多个字符来获得子字符序列。

如果一个字符序列与它反转后的字符序列一致，那么它是回文字符序列。

如果对于某个  `i，A_i != B_i`，那么 `A_1, A_2, ...` 和 B_1, B_2, ... 这两个字符序列是不同的。

 

**示例 1：**

```
输入：
S = 'bccb'
输出：6
解释：
6 个不同的非空回文子字符序列分别为：'b', 'c', 'bb', 'cc', 'bcb', 'bccb'。
注意：'bcb' 虽然出现两次但仅计数一次。
```

**示例 2：**

```
输入：
S = 'abcdabcdabcdabcdabcdabcdabcdabcddcbadcbadcbadcbadcbadcbadcbadcba'
输出：104860361
解释：
共有 3104860382 个不同的非空回文子字符序列，对 10^9 + 7 取模为 104860361。
```

**提示：**

- 字符串 S 的长度将在[1, 1000]范围内。
每个字符 S[i] 将会是集合 {'a', 'b', 'c', 'd'} 中的某一个。



## 2、解题思路

- 使用动态规划

初始状态：

```
dp[i][j] 表示 从i 到j 之间的回文串
```

状态转换方程：

```
如果 S[i] == S[j]
	  首先假设i和j之间没有与当前边界相等的字符，那么
	  dp[i][j] = 2 * dp[i+1][j-1] + 2
	  就是中间所有的回文串是否加上两端的字符，并且加上 （假设字符为c） "c" "cc"
	  如果中间出现了一个"c"， 那么最外围中的这个c就不需要，也就是内部已经出现过"c"这个回文串了
	  如果内部有两个"c"，或者多个，那么被最外围包裹的"c"包裹着的部分就被计算了两次，将这一部分减去
```

​	  

```python
										left = i + 1
                    right = j - 1

                    while left <= right:
                        flag = 0
                        if S[left] != S[i]:
                            left += 1
                        else:
                            flag += 1

                        if S[right] != S[i]:
                            right -= 1
                        else:
                            flag += 1
                        if flag == 2:
                            break
```

```
如果 S[i] != S[j]
    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1]
    减掉重合的部分
```



```python
class Solution:
    def countPalindromicSubsequences(self, S: str) -> int:
        
        length = len(S)
        dp = [[0 for _ in range(length)] for _ in range(length)]

        for i in range(length):
            dp[i][i] = 1

        for i in range(length - 2, -1, -1):
            for j in range(i + 1, length):
                if S[i] == S[j]:
                    dp[i][j] = dp[i + 1][j - 1] * 2
                    left = i + 1
                    right = j - 1

                    while left <= right:
                        flag = 0
                        if S[left] != S[i]:
                            left += 1
                        else:
                            flag += 1

                        if S[right] != S[i]:
                            right -= 1
                        else:
                            flag += 1
                        if flag == 2:
                            break

                    if left > right:
                        dp[i][j] += 2
                    elif left == right:
                        dp[i][j] += 1
                    else:
                        dp[i][j] -= dp[left + 1][right - 1]
                else:
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1]

                dp[i][j] = dp[i][j] + 1000000007 if (dp[i][j] < 0) else dp[i][j] % 1000000007
        return dp[0][length - 1]
```

