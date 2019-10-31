# LeetCode: 678. 有效的括号字符串

[TOC]

## 1、题目描述

给定一个只包含三种字符的字符串：`（ ，）` 和 `*`，写一个函数来检验这个字符串是否为有效字符串。有效字符串具有如下规则：

1.  任何左括号 ( 必须有相应的右括号 )。
2.  任何右括号 ) 必须有相应的左括号 ( 。
3.  左括号 ( 必须在对应的右括号之前 )。
4.  `*` 可以被视为单个右括号 ) ，或单个左括号 ( ，或一个空字符串。
5.  一个空字符串也被视为有效字符串。

**示例 1:**

```
输入: "()"
输出: True
```


**示例 2:**

```
输入: "(*)"
输出: True
```


**示例 3:**

```
输入: "(*))"
输出: True
```


**注意:**

-   字符串大小将在 [1，100] 范围内。

## 2、解题思路

-   左右扫描法

-   左侧扫描
    -   判断`(左括号+星号) < 右括号数量`，返回`False`
-   右侧扫描
    -   判断`(右括号+星号)< 左括号数量`，返回`False`
-   未出现上述情况，返回`True`

```python
class Solution:
    def checkValidString(self, s: str) -> bool:
        left = 0
        left_star = 0
        left_right = 0
        right = 0
        right_star = 0
        right_left = 0
        length = len(s)
        for i in range(length):
            if s[i] == "(":
                left += 1
            elif s[i] == "*":
                left_star += 1
            elif s[i] == ")":
                left_right += 1
            if s[length - i - 1] == "(":
                right_left += 1
            elif s[length - i - 1] == "*":
                right_star += 1
            elif s[length - i - 1] == ")":
                right += 1

            if left + left_star < left_right:
                return False
            if right + right_star < right_left:
                return False

        return True
```

