# LeetCode: 273. 整数转换英文表示

[TOC]

## 1、题目描述

将非负整数转换为其对应的英文表示。可以保证给定输入小于 $2^{31} - 1$ 。

**示例 1:**

```
输入: 123
输出: "One Hundred Twenty Three"
```

**示例 2:**

```
输入: 12345
输出: "Twelve Thousand Three Hundred Forty Five"
```


**示例 3:**

```
输入: 1234567
输出: "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"
```


**示例 4:**

```
输入: 1234567891
输出: "One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One"
```



## 2、解题思路

-   按照每三位为一部分，进行转换，不足三位补零



```python
import re


class Solution:
    def numberToWords(self, num: int) -> str:
        if num == 0:
            return "Zero"
        numbers = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
                   "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen",
                   "Eighteen", "Nineteen", "Twenty"]
        decade = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]
        mapping = {
            0: "",
            1: "Thousand",
            2: "Million",
            3: "Billion",
        }

        def get_hundred(cur: str):
            cur = cur.zfill(3)
            cur_ans = list()
            if int(cur[0]):
                cur_ans.append(numbers[int(cur[0])] + " Hundred")
            if int(cur[1:]) <= 20:
                cur_ans.append(numbers[int(cur[1:])])
            else:
                cur_ans.append(decade[int(cur[1])])
                cur_ans.append(numbers[int(cur[2])])
            return " ".join(filter(None, cur_ans))

        current = str(num)
        length = len(current)
        quotient = length // 3
        if length % 3:
            quotient += 1
            current = current.zfill(quotient * 3)
        quotient -= 1
        sep = re.findall(r".{3}", current)

        ans = []
        while quotient >= 0:
            temp = get_hundred(sep[-quotient - 1])
            if temp and quotient:
                ans.append(temp + " " + mapping[quotient])
            elif temp:
                ans.append(temp)
            quotient -= 1
        return " ".join(ans)

```

