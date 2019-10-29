# LeetCode: 1239. 串联字符串的最大长度

[TOC]

## 1、题目描述

给定一个字符串数组 `arr`，字符串 `s` 是将 `arr` 某一子序列字符串连接所得的字符串，如果 `s` 中的每一个字符都只出现过一次，那么它就是一个可行解。

请返回所有可行解 `s` 中最长长度。

 

**示例 1：**

```
输入：arr = ["un","iq","ue"]
输出：4
解释：所有可能的串联组合是 "","un","iq","ue","uniq" 和 "ique"，最大长度为 4。
```


**示例 2：**

```
输入：arr = ["cha","r","act","ers"]
输出：6
解释：可能的解答有 "chaers" 和 "acters"。
```


**示例 3：**

```
输入：arr = ["abcdefghijklmnopqrstuvwxyz"]
输出：26
```

**提示：**

-   $1 <= arr.length <= 16$
-   $1 <= arr[i].length <= 26$
-   `arr[i] 中只含有小写英文字母`



## 2、解题思路

-   首先过滤有重复字符的字符串
-   用整数的位保存每个字符是否出现
-   用每一个字符串更新结果集中的元素，判断相交的没有重复元素



```python
class Solution:
    def maxLength(self, arr: List[str]) -> int:
        arr = [a for a in arr if len(a) == len(set(a))]

        ans = [[0, 0]]

        def calculate(a):
            cur = 0
            for c in a:
                cur += 1 << (ord(c) - 97)
            return len(a), cur

        for cur_a in arr:
            length, num = calculate(cur_a)
            for length_r, num_r in ans:
                if not num_r & num:
                    ans.append([length + length_r, num ^ num_r])
        return max(ans)[0]
```

