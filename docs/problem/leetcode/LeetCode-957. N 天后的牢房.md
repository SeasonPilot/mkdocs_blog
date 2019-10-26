# LeetCode: 957. N 天后的牢房

[TOC]

## 1、题目描述

`8` 间牢房排成一排，每间牢房不是有人住就是空着。

每天，无论牢房是被占用或空置，都会根据以下规则进行更改：

-   如果一间牢房的两个相邻的房间都被占用或都是空的，那么该牢房就会被占用。
-   否则，它就会被空置。

>   （请注意，由于监狱中的牢房排成一行，所以行中的第一个和最后一个房间无法有两个相邻的房间。）

我们用以下方式描述监狱的当前状态：如果第 `i` 间牢房被占用，则 `cell[i]==1`，否则 `cell[i]==0`。

根据监狱的初始状态，在 `N` 天后返回监狱的状况（和上述 `N` 种变化）。

 

**示例 1：**

```
输入：cells = [0,1,0,1,1,0,0,1], N = 7
输出：[0,0,1,1,0,0,0,0]
解释：
下表概述了监狱每天的状况：
Day 0: [0, 1, 0, 1, 1, 0, 0, 1]
Day 1: [0, 1, 1, 0, 0, 0, 0, 0]
Day 2: [0, 0, 0, 0, 1, 1, 1, 0]
Day 3: [0, 1, 1, 0, 0, 1, 0, 0]
Day 4: [0, 0, 0, 0, 0, 1, 0, 0]
Day 5: [0, 1, 1, 1, 0, 1, 0, 0]
Day 6: [0, 0, 1, 0, 1, 1, 0, 0]
Day 7: [0, 0, 1, 1, 0, 0, 0, 0]
```

**示例 2：**

```
输入：cells = [1,0,0,1,0,0,1,0], N = 1000000000
输出：[0,0,1,1,1,1,1,0]
```

**提示：**

-   $cells.length == 8$
-   `cells[i] 的值为 0 或 1` 
-   $1 <= N <= 10^9$



## 2、解题思路

-   因为只有8位，因此肯定会产生循环，最高也不会超过256
-   只需要找出循环的长度与起始点就能直接推算出来



```python
class Solution:
    def prisonAfterNDays(self, cells: List[int], N: int) -> List[int]:
        start = "".join([str(i) for i in cells])
        index = []
        mapping = {}

        def get_next_day(days):
            current = days

            length = len(current)
            current_ans = ["0"] * length

            for i in range(1, length - 1):
                if (current[i - 1] == "1" and current[i + 1] == "1") or (
                        current[i - 1] == "0" and current[i + 1] == "0"):
                    current_ans[i] = "1"

            return "".join(current_ans)

        ans = start
        if N <= 256:
            for _ in range(N):
                ans = get_next_day(ans)
        else:
            count = 1
            cur = start
            cycle = 1
            cycle_start = 1
            for _ in range(256):
                cur = get_next_day(cur)
                if cur not in mapping:
                    mapping[cur] = count
                    index.append(cur)
                else:
                    cycle = count - mapping[cur]
                    cycle_start = mapping[cur]
                    break
                count += 1

            N -= cycle_start
            ans = index[N % cycle]

        return list(map(int, ans))
```

