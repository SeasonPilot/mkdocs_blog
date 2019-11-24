# LeetCode: 1147. 段式回文

[TOC]

## 1、题目描述

段式回文 其实与 一般回文 类似，只不过是最小的单位是 一段字符 而不是 单个字母。

举个例子，对于一般回文 `"abcba"` 是回文，而 `"volvo"` 不是，但如果我们把 `"volvo"` 分为 `"vo"`、`"l"`、`"vo"` 三段，则可以认为 `“(vo)(l)(vo)”` 是段式回文（分为 `3` 段）。

 

给你一个字符串 `text`，在确保它满足段式回文的前提下，请你返回 段 的 最大数量 `k`。

如果段的最大数量为 `k`，那么存在满足以下条件的 `a_1, a_2, ..., a_k`：

每个 `a_i` 都是一个非空字符串；
将这些字符串首位相连的结果 `a_1 + a_2 + ... + a_k` 和原始字符串 `text` 相同；
对于所有`1 <= i <= k`，都有 `a_i = a_{k+1 - i}`。

**示例 1：**

```
输入：text = "ghiabcdefhelloadamhelloabcdefghi"
输出：7
解释：我们可以把字符串拆分成 "(ghi)(abcdef)(hello)(adam)(hello)(abcdef)(ghi)"。
```


**示例 2：**

```
输入：text = "merchant"
输出：1
解释：我们可以把字符串拆分成 "(merchant)"。
```


**示例 3：**

```
输入：text = "antaprezatepzapreanta"
输出：11
解释：我们可以把字符串拆分成 "(a)(nt)(a)(pre)(za)(tpe)(za)(pre)(a)(nt)(a)"。
```


**示例 4：**

```
输入：text = "aaa"
输出：3
解释：我们可以把字符串拆分成 "(a)(a)(a)"。
```

**提示：**

-   `text 仅由小写英文字符组成。`
-   $1 <= text.length <= 1000$



## 2、解题思路

-   分别设计两个数组
    -   保存从前开始各个字母的出现次数
    -   保存从后开始各个字母的出现次数
-   只要次数匹配，则进行分割
-   中间的部分特别处理即可



```python
class Solution:
    def longestDecomposition(self, text: str) -> int:
        if not text:
            return 0

        ans = 0
        length = len(text)
        left = [0] * 26
        right = [0] * 26
        start = 0
        end = length // 2

        if length <= 1:
            return 1
        pos = -1
        for i in range(start, end):
            left[ord(text[i]) - 97] += 1
            right[ord(text[-i - 1]) - 97] += 1
            if left == right:
                ans += 2
                pos = i

        if pos < (end - 1):
            ans += 1
        elif length % 2:
            ans += 1

        return ans
```

