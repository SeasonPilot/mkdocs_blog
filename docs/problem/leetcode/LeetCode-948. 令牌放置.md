# LeetCode: 948. 令牌放置

[TOC]

## 1、题目描述

你的初始能量为 `P`，初始分数为 `0`，只有一包令牌。

令牌的值为 `token[i]`，每个令牌最多只能使用一次，可能的两种使用方法如下：

如果你至少有 `token[i]` 点能量，可以将令牌置为正面朝上，失去 `token[i]` 点能量，并得到 `1` 分。
如果我们至少有 `1` 分，可以将令牌置为反面朝上，获得 `token[i]` 点能量，并失去 `1` 分。
在使用任意数量的令牌后，返回我们可以得到的最大分数。

 

**示例 1：**

```
输入：tokens = [100], P = 50
输出：0
```


**示例 2：**

```
输入：tokens = [100,200], P = 150
输出：1
```


**示例 3：**

```
输入：tokens = [100,200,300,400], P = 200
输出：2
```

**提示：**

-   $tokens.length <= 1000$
-   $0 <= tokens[i] < 10000$
-   $0 <= P < 10000$



## 2、解题思路

-   排序+双指针

-   需要注意的就是，不能直接将牌子反过来导致分数为负



```python

class Solution:
    def bagOfTokensScore(self, tokens: List[int], P: int) -> int:
        score = 0
        power = P
        sums = 0
        tokens.sort()
        length = len(tokens)

        left, right = 0, length - 1

        while left < right:
            if power >= sums + tokens[left]:
                score += 1
                sums += tokens[left]
            else:
                if score:
                    sums += tokens[left]
                    power += tokens[right]
                    right -= 1

                else:
                    break
            left += 1
        if left == right and sums + tokens[left] <= power:
            score += 1
        return score
```



下面更简单的改写了判断

-   首先判断能量是否足够翻第一张牌，不够的话，直接返回0
-   然后左右指针逼近即可

```python

class Solution:
    def bagOfTokensScore(self, tokens: List[int], P: int) -> int:
        score = 0
        power = P
        sums = 0
        tokens.sort()
        length = len(tokens)
        if not tokens or power < tokens[0]:
            return score
        left, right = 0, length - 1

        while left < right:
            sums += tokens[left]
            if power < sums:
                power += tokens[right]
                right -= 1
                score -= 1
            score += 1
            left += 1

        if left == right and sums + tokens[left] <= power:
            score += 1
        return score
```

