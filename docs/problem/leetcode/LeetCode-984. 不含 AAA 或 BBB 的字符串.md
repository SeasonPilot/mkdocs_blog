# LeetCode: 984. 不含 AAA 或 BBB 的字符串

[TOC]

## 1、题目描述

给定两个整数 `A` 和 `B`，返回任意字符串 `S`，要求满足：

`S` 的长度为 `A + B`，且正好包含 `A` 个 `'a'` 字母与 `B` 个 `'b'` 字母；
子串 `'aaa'` 没有出现在 `S` 中；
子串 `'bbb'` 没有出现在 `S` 中。

**示例 1：**

```
输入：A = 1, B = 2
输出："abb"
解释："abb", "bab" 和 "bba" 都是正确答案。
```


**示例 2：**

```
输入：A = 4, B = 1
输出："aabaa"
```

**提示：**

-   $0 <= A <= 100$
-   $0 <= B <= 100$
-   对于给定的 `A` 和 `B`，保证存在满足要求的 `S`。



## 2、解题思路

-   快慢步法

```
我们的目的是让剩余的字符数量一致，这样就能相互间各取值，只需要让长的每次走两步，短的走一步，最后短的就有可能追上长的，根据这个来构造
```

-   如果两个长度一致，直接每个字符相互间隔，返回结果
-   长度不一致
    -   长的前进步伐为2
    -   短的前进步伐为1
    -   如果两个步伐相同，更新结果，剩余字符每个字符相互间隔
-   剩余的字符更新到结果中即可



```python
class Solution:
    def strWithout3a3b(self, A: int, B: int) -> str:
        if A == B:
            return "ab" * A

        ans = ""

        la = A
        lb = B

        while la > 0 and lb > 0:
            if la > lb:
                ans += "aab"
                la -= 2
                lb -= 1
            elif la < lb:
                ans += "bba"
                la -= 1
                lb -= 2
            else:
                if A > B:
                    ans += "ab" * la
                else:
                    ans += "ba" * la
                la = 0
                lb = 0
        if A > B:
            ans += "a" * la + "b" * lb
        else:
            ans += "b" * lb + "a" * la

        return ans
```

