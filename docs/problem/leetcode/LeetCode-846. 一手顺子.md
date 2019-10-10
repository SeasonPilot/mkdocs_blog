# LeetCode: 846. 一手顺子

[TOC]

## 1、题目描述

爱丽丝有一手（`hand`）由整数数组给定的牌。 

现在她想把牌重新排列成组，使得每个组的大小都是 `W`，且由 `W` 张连续的牌组成。

如果她可以完成分组就返回 `true`，否则返回 `false`。

 

**示例 1：**

```
输入：hand = [1,2,3,6,2,3,4,7,8], W = 3
输出：true
解释：爱丽丝的手牌可以被重新排列为 [1,2,3]，[2,3,4]，[6,7,8]。
```


**示例 2：**

```
输入：hand = [1,2,3,4,5], W = 4
输出：false
解释：爱丽丝的手牌无法被重新排列成几个大小为 4 的组。
```

**提示：**

-   `1 <= hand.length <= 10000`
-   `0 <= hand[i] <= 10^9`
-   `1 <= W <= hand.length`



## 2、解题思路

-   使用字典统计不同数字的次数
-   每次从最小的开始，依次将`W`个递增数字的次数减一，无法减一返回`False`

```python
from collections import Counter


class Solution:
    def isNStraightHand(self, hand: List[int], W: int) -> bool:
        if len(hand) % W:
            return False

        count = Counter(hand)

        sorted_key = list(sorted(count.keys()))

        pos = 0

        while pos < len(sorted_key):
            current_val = sorted_key[pos]
            flag = False
            temp_pos = pos
            for i in range(W):
                if count[current_val] >= 1:
                    count[current_val] -= 1

                    if not flag and count[current_val] >= 1:
                        temp_pos = pos + i
                        flag = True

                    current_val += 1
                else:
                    return False
            if not flag:
                pos += W
            else:
                pos = temp_pos

        return True
```

