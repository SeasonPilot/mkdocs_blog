# LeetCode: 1073. 负二进制数相加

[TOC]

## 1、题目描述

给出基数为 `-2` 的两个数 `arr1` 和 `arr2`，返回两数相加的结果。

数字以 数组形式 给出：数组由若干 `0` 和 `1` 组成，按最高有效位到最低有效位的顺序排列。例如，`arr = [1,1,0,1]` 表示数字 `(-2)^3 + (-2)^2 + (-2)^0 = -3`。数组形式 的数字也同样不含前导零：以 `arr` 为例，这意味着要么 `arr == [0]`，要么 `arr[0] == 1`。

返回相同表示形式的 `arr1` 和 `arr2` 相加的结果。两数的表示形式为：不含前导零、由若干 `0` 和 `1` 组成的数组。

 

**示例：**

```
输入：arr1 = [1,1,1,1,1], arr2 = [1,0,1]
输出：[1,0,0,0,0]
解释：arr1 表示 11，arr2 表示 5，输出表示 16 。
```

**提示：**

-   `1 <= arr1.length <= 1000`
-   `1 <= arr2.length <= 1000`
-   `arr1 和 arr2 都不含前导零`
-   `arr1[i] 为 0 或 1`
-   `arr2[i] 为 0 或 1`



## 2、解题思路

-   记住前面的两个进位
-   如果当前位加和为`-1`，并且下一个进位是`1`，那么进位清零，如果下一个进位是0，那么产生的当前位为1，进位为1
-   如果当前位加和是0，进位就为0，下一个进位左移，本位为0
-   如果当前位加和是1，进位就为0，下一个进位左移，本位为1
-   如果当前位加和是2，进位就为next_carry - 1，本位为0
-   如果当前位加和是3，进位就为next_carry - 1，本位为1



```python
from itertools import zip_longest


class Solution:
    def addNegabinary(self, arr1: List[int], arr2: List[int]) -> List[int]:
        ans = []

        carry = [0, 0]

        for x, y in zip_longest(reversed(arr1), reversed(arr2), fillvalue=0):
            next_carry = carry[1]
            cur = carry[0] + x + y
            if cur == -1:

                if next_carry == 1:
                    carry = [0, 0]
                    ans.append(0)
                else:
                    carry = [1, 0]
                    ans.append(1)

            elif cur == 0:
                ans.append(0)
                carry = [next_carry, 0]
            elif cur == 1:
                ans.append(1)
                carry = [next_carry, 0]
            elif cur == 2:
                ans.append(0)
                carry = [next_carry - 1, 0]
            elif cur == 3:
                ans.append(1)
                carry = [next_carry - 1, 0]

        if carry[1]:
            ans.extend(carry)
        elif carry[0] == -1:
            ans.extend([1, 1])

        pos = len(ans) - 1
        while pos > 0 and ans[pos] == 0:
            pos -= 1

        return list(reversed(ans[:pos + 1]))
```

