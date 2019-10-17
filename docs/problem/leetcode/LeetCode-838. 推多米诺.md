# LeetCode: 838. 推多米诺

[TOC]

## 1、题目描述

一行中有 `N` 张多米诺骨牌，我们将每张多米诺骨牌垂直竖立。

在开始时，我们同时把一些多米诺骨牌向左或向右推。

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-17-120036.png)

每过一秒，倒向左边的多米诺骨牌会推动其左侧相邻的多米诺骨牌。

同样地，倒向右边的多米诺骨牌也会推动竖立在其右侧的相邻多米诺骨牌。

如果同时有多米诺骨牌落在一张垂直竖立的多米诺骨牌的两边，由于受力平衡， 该骨牌仍然保持不变。

就这个问题而言，我们会认为正在下降的多米诺骨牌不会对其它正在下降或已经下降的多米诺骨牌施加额外的力。

给定表示初始状态的字符串 `"S"` 。如果第 i 张多米诺骨牌被推向左边，则 `S[i] = 'L'`；如果第 `i` 张多米诺骨牌被推向右边，则 `S[i] = 'R'`；如果第 `i` 张多米诺骨牌没有被推动，则 `S[i] = '.'`。

返回表示最终状态的字符串。

**示例 1：**

```
输入：".L.R...LR..L.."
输出："LL.RR.LLRRLL.."
```


**示例 2：**

```
输入："RR.L"
输出："RR.L"
说明：第一张多米诺骨牌没有给第二张施加额外的力。
```


**提示：**

-   `0 <= N <= 10^5`
-   `表示多米诺骨牌状态的字符串只含有 'L'，'R'; 以及 '.';`



## 2、解题思路



-   首先在首部添加一个"L"，尾部添加一个"R"
-   "L"和"R"供会产生4种组合：

```
L ... R  => L ... R
R ... R  => R RRR R
R ... L  => R R.L L
L ... L  => L LLL L
```

如上所示，只需要对上面的第三种情况额外判断一下奇偶即可



```python
class Solution:
    def pushDominoes(self, dominoes: str) -> str:
        ans = ""

        temp = "L" + dominoes + "R"
        left = 0
        for i in range(1, len(temp)):
            if temp[i] in ("L", "R"):
                if temp[left] == "L" and temp[i] == "L":
                    ans += "L" * (i - left - 1) + temp[i]
                elif temp[left] == "R" and temp[i] == "L":
                    length = i - left - 1
                    half = length // 2
                    if length % 2:
                        ans += "R" * half + "." + "L" * half
                    else:
                        ans += "R" * half + "L" * half
                    ans += temp[i]
                elif temp[left] == "L" and temp[i] == "R":
                    ans += temp[left + 1:i + 1]
                elif temp[left] == "R" and temp[i] == "R":
                    ans += "R" * (i - left - 1) + "R"

                left = i

        return ans[:-1]
```

