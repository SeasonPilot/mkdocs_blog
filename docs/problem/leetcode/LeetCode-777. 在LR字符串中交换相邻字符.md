# LeetCode: 777. 在LR字符串中交换相邻字符

[TOC]

## 1、题目描述

在一个由 `'L'` , `'R'` 和 `'X'` 三个字符组成的字符串（例如`"RXXLRXRXL"`）中进行移动操作。一次移动操作指用一个`"LX"`替换一个`"XL"`，或者用一个`"XR"`替换一个`"RX"`。现给定起始字符串`start`和结束字符串`end`，请编写代码，当且仅当存在一系列移动操作使得`start`可以转换成`end`时， 返回`True`。

**示例 :**

```
输入: start = "RXXLRXRXL", end = "XRLXXRRLX"
输出: True
解释:
我们可以通过以下几步将start转换成end:
RXXLRXRXL ->
XRXLRXRXL ->
XRLXRXRXL ->
XRLXXRRXL ->
XRLXXRRLX
```


**注意:**

-   $1 <= len(start) = len(end) <= 10000。$
-   `start和end中的字符串仅限于'L', 'R'和'X'。`



## 2、解题思路

-   将`"X"`看成是通路，`"L"`只能向左走，`"R"`只能向右走

因此，同样的情况，start中的`"L"`不能在`end`中的`"L"`左面

因此，同样的情况，start中的`"R"`不能在`end`中的`"R"`右面

```python
class Solution:
    def canTransform(self, start: str, end: str) -> bool:
        if len(start) != len(end):
            return False
        start_pos, end_pos = 0, 0

        while start_pos < len(start) and end_pos < len(end):
            while start_pos < len(start) and start[start_pos] == "X":
                start_pos += 1
            while end_pos < len(end) and end[end_pos] == "X":
                end_pos += 1

            if start_pos >= len(start) and end_pos >= len(end):
                break
            elif start_pos >= len(start) and end_pos < len(end):
                return False
            elif start_pos < len(start) and end_pos >= len(end):
                return False

            if start[start_pos] != end[end_pos]:
                return False

            if start[start_pos] == "R":
                if start_pos > end_pos:
                    return False
            if start[start_pos] == "L":
                if start_pos < end_pos:
                    return False
            start_pos += 1
            end_pos += 1
        return True

```

