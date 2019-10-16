# LeetCode: 1007. 行相等的最少多米诺旋转

[TOC]

## 1、题目描述

在一排多米诺骨牌中，`A[i]` 和 `B[i]` 分别代表第 `i` 个多米诺骨牌的上半部分和下半部分。（一个多米诺是两个从 `1` 到 `6` 的数字同列平铺形成的 —— 该平铺的每一半上都有一个数字。）

我们可以旋转第 `i` 张多米诺，使得 `A[i]` 和 `B[i]` 的值交换。

返回能使 `A` 中所有值或者 `B` 中所有值都相同的最小旋转次数。

如果无法做到，返回 `-1`.

 

**示例 1：**

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-16-134449.png" alt="img" style="zoom:50%;" />

```
输入：A = [2,1,2,4,2,2], B = [5,2,6,2,3,2]
输出：2
解释：
图一表示：在我们旋转之前， A 和 B 给出的多米诺牌。
如果我们旋转第二个和第四个多米诺骨牌，我们可以使上面一行中的每个值都等于 2，如图二所示。
```



**示例 2：**

```
输入：A = [3,5,1,2,3], B = [3,6,3,3,4]
输出：-1
解释：
在这种情况下，不可能旋转多米诺牌使一行的值相等。
```

**提示：**

-   `1 <= A[i], B[i] <= 6`
-   `2 <= A.length == B.length <= 20000`



## 2、解题思路

按照上下数字是否相同的几种情况判断：

-   上下数字相同的数字超过1个，肯定无法变成相同的值
-   上下数字相同的数字为1个：

```
num, count = same.popitem()
    if top[num] + bottom[num] - count == length:
        return min(top[num], bottom[num]) - count
    else:
        return -1
```

判断能否加起来是否等于数组长度，不能得到返回-1

-   上下数字没有相同的，遍历一遍所有的key，判断当前数字数量书否等于数组长度，等于则更新结果



```python
from collections import defaultdict


class Solution:
    def minDominoRotations(self, A: List[int], B: List[int]) -> int:
        length = len(A)
        top = defaultdict(int)
        bottom = defaultdict(int)
        same = defaultdict(int)
        ans = length

        for i in range(length):
            top[A[i]] += 1
            bottom[B[i]] += 1
            if A[i] == B[i]:
                same[A[i]] += 1

        if len(same) >= 2:
            return -1
        elif len(same) == 1:
            num, count = same.popitem()
            if top[num] + bottom[num] - count == length:
                return min(top[num], bottom[num]) - count
            else:
                return -1

        for num, count in top.items():
            if count + bottom[num] == length:
                ans = min(count, bottom[num])

        return ans if ans != length else -1
```

