# LeetCode: 1234. 替换子串得到平衡字符串

[TOC]

## 1、题目描述

有一个只含有 `'Q', 'W', 'E', 'R'` 四种字符，且长度为 `n` 的字符串。

假如在该字符串中，这四个字符都恰好出现 `n/4` 次，那么它就是一个「平衡字符串」。

 

给你一个这样的字符串 `s`，请通过「替换子串」的方式，使原字符串 `s` 变成一个「平衡字符串」。

你可以用和「待替换子串」长度相同的 任何 其他字符串来完成替换。

请返回待替换子串的最小可能长度。

如果原字符串自身就是一个平衡字符串，则返回 `0`。

 

**示例 1：**

```
输入：s = "QWER"
输出：0
解释：s 已经是平衡的了。
```


**示例 2：**

```
输入：s = "QQWE"
输出：1
解释：我们需要把一个 'Q' 替换成 'R'，这样得到的 "RQWE" (或 "QRWE") 是平衡的。
```


**示例 3：**

```
输入：s = "QQQW"
输出：2
解释：我们可以把前面的 "QQ" 替换成 "ER"。 
```


**示例 4：**

```
输入：s = "QQQQ"
输出：3
解释：我们可以替换后 3 个 'Q'，使 s = "QWER"。
```

**提示：**

-   $1 <= s.length <= 10^5$
-   `s.length 是 4 的倍数`
-   `s 中只含有 'Q', 'W', 'E', 'R' 四种字符`



## 2、解题思路

-   贪心法

-   哪个区间能够通过替换子串得到平衡串呢？只要出了当前区域的字符串，`QWER`的数量都少于总长度的四分之一

```
设置两个指针，left和right，闭区间，分别指能够替换的左右位置
首先更新left的值，找到left能够向右找到的最远的值
然后更新right的值

-》然后left减到0，不断的更新right
```



```python
class Solution:
    def balancedString(self, s: str) -> int:
        length = len(s)
        average = length // 4

        count = [0] * 4
        mapping_index = {"Q": 0, "W": 1, "E": 2, "R": 3, }

        left = 0
        right = length - 1
        while left < length:
            if count[mapping_index[s[left]]] + 1 <= average:
                count[mapping_index[s[left]]] += 1
                left += 1
            else:
                break

        while right >= 0 and right >= left:
            if count[mapping_index[s[right]]] + 1 <= average:
                count[mapping_index[s[right]]] += 1
                right -= 1
            else:
                break

        ans = right - left + 1

        while left >= 0:
            left -= 1
            count[mapping_index[s[left]]] -= 1
            while right >= 0 and right >= left:
                if count[mapping_index[s[right]]] + 1 <= average:
                    count[mapping_index[s[right]]] += 1
                    right -= 1
                else:
                    break
            ans = min(ans, right - left + 1)

        return ans
```

