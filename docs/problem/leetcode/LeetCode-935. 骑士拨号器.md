# LeetCode: 935. 骑士拨号器

[TOC]

## 1、题目描述

国际象棋中的骑士可以按下图所示进行移动：

<img src="http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-19-112501.png" alt="img" style="zoom:50%;" /> ![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-10-19-112515.png)




这一次，我们将 “骑士” 放在电话拨号盘的任意数字键（如上图所示）上，接下来，骑士将会跳 `N-1` 步。每一步必须是从一个数字键跳到另一个数字键。

每当它落在一个键上（包括骑士的初始位置），都会拨出键所对应的数字，总共按下 `N` 位数字。

你能用这种方式拨出多少个不同的号码？

因为答案可能很大，所以输出答案模 $10^9 + 7$。

 

**示例 1：**

```
输入：1
输出：10
```


**示例 2：**

```
输入：2
输出：20
```


**示例 3：**

```
输入：3
输出：46
```

**提示：**

-   $1 <= N <= 5000$



## 2、解题思路

-   简单DFS加记忆化



```python
from functools import lru_cache


class Solution:
    def knightDialer(self, N: int) -> int:
        ans = 0
        mod_num = 1000000007
        mapping_next = {
            0: [4, 6],
            1: [6, 8],
            2: [7, 9],
            3: [4, 8],
            4: [0, 3, 9],
            5: [],
            6: [0, 1, 7],
            7: [2, 6],
            8: [1, 3],
            9: [2, 4],
        }

        @lru_cache(None)
        def dfs(start, steps):
            if steps == 0:
                return 1
            cur_ans = 0

            for n in mapping_next[start]:
                cur_ans += dfs(n, steps - 1)
            return cur_ans % mod_num

        for i in range(10):
            ans += dfs(i, N - 1)
        return ans % mod_num
```

