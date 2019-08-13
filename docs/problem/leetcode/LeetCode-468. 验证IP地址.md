# LeetCode: 468. 验证IP地址

[TOC]

## 1、题目描述

编写一个函数来验证输入的字符串是否是有效的 `IPv4` 或 `IPv6` 地址。

`IPv4` 地址由十进制数和点来表示，每个地址包含`4`个十进制数，其范围为 `0 - 255`， 用`(".")`分割。比如，`172.16.254.1`；

同时，`IPv4` 地址内的数不会以` 0` 开头。比如，地址 `172.16.254.01` 是不合法的。

`IPv6` 地址由`8`组`16`进制的数字来表示，每组表示 `16` 比特。这些组数字通过 `(":")`分割。比如,  `2001:0db8:85a3:0000:0000:8a2e:0370:7334` 是一个有效的地址。而且，我们可以加入一些以 `0` 开头的数字，字母可以使用大写，也可以是小写。所以， `2001:db8:85a3:0:0:8A2E:0370:7334` 也是一个有效的` IPv6` address地址 (即，忽略 `0` 开头，忽略大小写)。

然而，我们不能因为某个组的值为 `0`，而使用一个空的组，以至于出现` (::)` 的情况。 比如， `2001:0db8:85a3::8A2E:0370:7334` 是无效的 `IPv6` 地址。

同时，在 `IPv6` 地址中，多余的 `0`  也是不被允许的。比如， `02001:0db8:85a3:0000:0000:8a2e:0370:7334` 是无效的。

说明: 你可以认为给定的字符串里没有空格或者其他特殊字符。



**示例 1:**

```
输入: "172.16.254.1"

输出: "IPv4"

解释: 这是一个有效的 IPv4 地址, 所以返回 "IPv4"。

```



**示例 2:**

```
输入: "2001:0db8:85a3:0:0:8A2E:0370:7334"

输出: "IPv6"

解释: 这是一个有效的 IPv6 地址, 所以返回 "IPv6"。

```



**示例 3:**

```
输入: "256.256.256.256"

输出: "Neither"

解释: 这个地址既不是 IPv4 也不是 IPv6 地址。

```



## 2、解题思路

- 直接判断法

```python
import string


class Solution:
    def validIPAddress(self, IP: str) -> str:
        if "." in IP:
            return self.judge_ipv4(IP)
        else:
            return self.judge_ipv6(IP)

    def judge_ipv4(self, ip):
        temp = ip.split(".")
        if len(temp) != 4:
            return "Neither"
        for i in temp:

            if not i or not all(c in string.digits for c in i) or (int(i) >= 256 or int(i) < 0):
                return "Neither"
            if len(i) > 3 or (len(i) > 1 and i.startswith("0")):
                return "Neither"

        return "IPv4"

    def judge_ipv6(self, ip):

        temp = ip.split(":")
        if len(temp) != 8:
            return "Neither"
        for i in temp:
            if not i or not all(c in string.hexdigits for c in i) or len(i) not in range(5):
                return "Neither"
            if len(i) == 0 and int(i, 16) != 0:
                return "Neither"

            if int(i, 16) < 0 or int(i, 16) >= 2 ** 16:
                return "Neither"
        return "IPv6"

```



- 正则表达式

```python
import re


class Solution:
    def validIPAddress(self, IP: str) -> str:

        reg1 = r"(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)"
        reg_ipv4 = r"^(?:" + reg1 + r"\.){3}" + reg1 + r"$"

        reg2 = r"([\da-fA-F]{1,4})"
        reg_ipv6 = r"^(?:" + reg2 + r":){7}" + reg2 + r"$"

        if re.match(reg_ipv4, IP):
            for i in re.match(reg_ipv4, IP).groups():
                print(i)
            return "IPv4"
        if re.match(reg_ipv6, IP):
            return "IPv6"

        return "Neither"
```

