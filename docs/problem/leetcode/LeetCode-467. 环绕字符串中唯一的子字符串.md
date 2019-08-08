# LeetCode: 467. 环绕字符串中唯一的子字符串

[TOC]

## 1、题目描述

把字符串 s 看作是`“abcdefghijklmnopqrstuvwxyz”`的无限环绕字符串，所以` s` 看起来是这样的：`"...zabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcd....".` 

现在我们有了另一个字符串 p 。你需要的是找出 s 中有多少个唯一的 p 的非空子串，尤其是当你的输入是字符串 p ，你需要输出字符串 s 中 p 的不同的非空子串的数目。 

注意: p 仅由小写的英文字母组成，p 的大小可能超过 10000。

 ```
示例 1:

输入: "a"
输出: 1
解释: 字符串 S 中只有一个"a"子字符。

示例 2:

输入: "cac"
输出: 2
解释: 字符串 S 中的字符串“cac”只有两个子串“a”、“c”。.

示例 3:

输入: "zab"
输出: 6
解释: 在字符串 S 中有六个子串“z”、“a”、“b”、“za”、“ab”、“zab”。.
 ```



## 2、解题思路

- 使用dp

- 保存以每个字母结尾的最长的连续串的长度

  ```
  例如：
  abcd
  长度为4
  能够表示4个串：
  abcd
  bcd
  cd
  d
  并且都是单独的串
  将所有的扫描一遍，更新响应的串的长度并加起来即可
  ```

  

```python
class Solution:
    def findSubstringInWraproundString(self, p: str) -> int:
        if not p:
            return 0
        dp = [0] * 26
        base = ord('a')
        dp[ord(p[0]) - base] = 1

        pre = 1
        for i in range(1, len(p)):
            diff = (ord(p[i]) - ord(p[i - 1]) + 26) % 26
            if diff == 1:
                pre += 1
                dp[ord(p[i]) - base] = max(pre, dp[ord(p[i]) - base])

            else:
                dp[ord(p[i]) - base] = max(1, dp[ord(p[i]) - base])
                pre = 1
        return sum(dp)
```

