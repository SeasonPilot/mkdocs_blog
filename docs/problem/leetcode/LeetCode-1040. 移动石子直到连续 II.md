# LeetCode: 1040. 移动石子直到连续 II

[TOC]

## 1、题目描述

在一个长度**无限**的数轴上，第 `i` 颗石子的位置为 `stones[i]`。如果一颗石子的位置最小/最大，那么该石子被称作**端点石子**。

每个回合，你可以将一颗端点石子拿起并移动到一个未占用的位置，使得该石子不再是一颗端点石子。

值得注意的是，如果石子像 `stones = [1,2,5]` 这样，你将无法移动位于位置 `5` 的端点石子，因为无论将它移动到任何位置（例如 `0` 或 `3`），该石子都仍然会是端点石子。

当你无法进行任何移动时，即，这些石子的位置连续时，游戏结束。

要使游戏结束，你可以执行的最小和最大移动次数分别是多少？ 以长度为 `2` 的数组形式返回答案：`answer = [minimum_moves, maximum_moves]` 。

 

**示例 1：**

```
输入：[7,4,9]
输出：[1,2]
解释：
我们可以移动一次，4 -> 8，游戏结束。
或者，我们可以移动两次 9 -> 5，4 -> 6，游戏结束。
```


**示例 2：**

```
输入：[6,5,4,3,10]
输出：[2,3]
解释：
我们可以移动 3 -> 8，接着是 10 -> 7，游戏结束。
或者，我们可以移动 3 -> 7, 4 -> 8, 5 -> 9，游戏结束。
注意，我们无法进行 10 -> 2 这样的移动来结束游戏，因为这是不合要求的移动。
```


**示例 3：**

```
输入：[100,101,104,102,103]
输出：[0,0]
```

**提示：**

-   `3 <= stones.length <= 10^4`
-   `1 <= stones[i] <= 10^9`
-   `stones[i] 的值各不相同。`



## 2、解题思路

-   最大值

最大值相当于尽量的将中间的空位占满，但是由于每次只能选择端点，因此第一个元素和第二个元素之间空位，一位最后两个元素之间的空位只能选择一个



-   最小值

最终得到的排列好的值肯定是连续的，因此按照每一个元素向后推进数组长度的空位，假设这个就是最终结果，判断需要移动几次得到

```
例如：
1 2 5

首先判断按照1 开始的空位

1 2 3
（这里表示下标）
也就是最终结果是这样排列的话，需要如何移动

这里的一种特殊情况，也就是以当前元素开头的，总的数量为length-1，并且最后一个元素不在集合中，这时候最小的移动次数是2
```



```python
class Solution:
    def numMovesStonesII(self, stones: List[int]) -> List[int]:
        stone_set = set(stones)
        stones.sort()
        length = len(stones)
        if stones[-1] - stones[0] + 1 == len(stones):
            return [0, 0]

        max_moves = max(stones[1] - stones[0], stones[-1] - stones[-2]) - 1

        for i in range(2, length - 1):
            max_moves += stones[i] - stones[i - 1] - 1

        min_moves = stones[-1] - stones[0]

        for i in range(length - 1):
            count = 0
            j = i
            while j < length and stones[j] < stones[i] + length:
                j += 1
                count += 1

            if stones[i] + length - 1 not in stone_set and length - count == 1:
                min_moves = min(min_moves, 2)

            else:
                min_moves = min(min_moves, length - count)

        return [min_moves, max_moves]
```

