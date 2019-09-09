# LeetCode: 854. 相似度为 K 的字符串

[TOC]

## 1、题目描述

如果可以通过将 `A` 中的两个小写字母精确地交换位置 `K` 次得到与 `B` 相等的字符串，我们称字符串 `A` 和 `B` 的相似度为 `K`（`K` 为非负整数）。

给定两个字母异位词 `A` 和 `B` ，返回 `A` 和 `B` 的相似度 `K` 的最小值。

 

**示例 1：**

```
输入：A = "ab", B = "ba"
输出：1
```

**示例 2：**

```
输入：A = "abc", B = "bca"
输出：2
```


**示例 3：**

```
输入：A = "abac", B = "baca"
输出：2
```


**示例 4：**

```
输入：A = "aabc", B = "abca"
输出：2
```

**提示：**

- `1 <= A.length == B.length <= 20`
- `A 和 B 只包含集合 {'a', 'b', 'c', 'd', 'e', 'f'} 中的小写字母。`



## 2、解题思路

- 回溯法

- 从前面开始寻找第一个不同的位置，然后找到可能与这个位置交换并将字符进行匹配的位置

- 找到所有可能的位置以后，首先交换，然后继续查找
- 每一次更新结果以后，回溯，按照新的交换方式重新查找



```python
class Solution:
    def kSimilarity(self, A: str, B: str) -> int:
        length = len(A)
        temp_b = list(B)
        inf = float("inf")

        res = inf

        def backtrace(step, pos):
            nonlocal res

            if step >= res:
                return

            while pos < length and A[pos] == temp_b[pos]:
                pos += 1

            if pos == length:
                res = min(step, res)

            next_pos = []

            for x in range(pos + 1, length):
                if temp_b[x] == A[pos]:
                    if A[x] == B[pos]:
                        # 交换一次得到结果,直接优化处理
                        next_pos = [x]
                        break
                    elif A[x] != B[x]:
                        # 将其他可能交换的结果放进来
                        next_pos.append(x)

            for nex in next_pos:
                temp_b[pos], temp_b[nex] = temp_b[nex], temp_b[pos]
                backtrace(step + 1, pos)
                temp_b[pos], temp_b[nex] = temp_b[nex], temp_b[pos]

        backtrace(0, 0)
        return res
```

