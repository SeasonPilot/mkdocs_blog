# LeetCode: 914. 卡牌分组

[TOC]

## 1、题目描述



给定一副牌，每张牌上都写着一个整数。

此时，你需要选定一个数字 X，使我们可以将整副牌按下述规则分成 1 组或更多组：

每组都有 X 张牌。
组内所有的牌上都写着相同的整数。
仅当你可选的 X >= 2 时返回 true。

 ```
示例 1：

输入：[1,2,3,4,4,3,2,1]
输出：true
解释：可行的分组是 [1,1]，[2,2]，[3,3]，[4,4]
示例 2：

输入：[1,1,1,2,2,2,3,3]
输出：false
解释：没有满足要求的分组。
示例 3：

输入：[1]
输出：false
解释：没有满足要求的分组。
示例 4：

输入：[1,1]
输出：true
解释：可行的分组是 [1,1]
示例 5：

输入：[1,1,2,2,2,2]
输出：true
解释：可行的分组是 [1,1]，[2,2]，[2,2]
 ```



**提示：**

1. 1 <= deck.length <= 10000
2. 0 <= deck[i] < 10000



## 2、解题思路

因为要求每个分组中的元素都要>=2，因此，

- 如果只有一个元素，那么这个元素数量需要大于等于2
- 如果有多个元素，那么元素的数量的最小公约数要大于等于2



```python
from collections import Counter
from math import gcd


class Solution:
    def hasGroupsSizeX(self, deck: [int]) -> bool:

        if len(deck) <= 1:
            return False

        temp = Counter(deck)
        nums = list(temp.values())
        if len(nums) == 1:
            if nums[0] < 2:
                return False
            else:
                return True

        gcd_val = gcd(nums[0], nums[1])
        for num in nums[2:]:
            gcd_val = gcd(gcd_val, num)
            if gcd_val == 1:
                return False
        if gcd_val == 1:
            return False

        return True
```



