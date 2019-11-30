# LeetCode: 188. 买卖股票的最佳时机 IV

[TOC]

## 1、题目描述

给定一个数组，它的第 `i` 个元素是一支给定的股票在第 `i` 天的价格。

设计一个算法来计算你所能获取的最大利润。你最多可以完成 `k` 笔交易。

注意: 你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。

**示例 1:**

```
输入: [2,4,1], k = 2
输出: 2
解释: 在第 1 天 (股票价格 = 2) 的时候买入，在第 2 天 (股票价格 = 4) 的时候卖出，这笔交易所能获得利润 = 4-2 = 2 。
```



**示例 2:**

```
输入: [3,2,6,5,0,3], k = 2
输出: 7
解释: 在第 2 天 (股票价格 = 2) 的时候买入，在第 3 天 (股票价格 = 6) 的时候卖出, 这笔交易所能获得利润 = 6-2 = 4 。
     随后，在第 5 天 (股票价格 = 0) 的时候买入，在第 6 天 (股票价格 = 3) 的时候卖出, 这笔交易所能获得利润 = 3-0 = 3 。
```



## 2、解题思路

-   如果交易次数大于数组长度的一半，也就是说所有的涨的情况都能涵盖在内，利用贪心法将所有上涨的股票差价计算出来
-   当交易次数不到一半的时候，有可能有些交易是需要略过以达到最大收益
    -   设置两个数组
    -   `buy[i]`表示小于等于`i`次交易所耗费的金钱，为正表示钱花出去了，为负表示之前手里的钱买了这个股票还有剩余
    -   `sell[i]`表示小于等于`i`次交易手里剩的金钱，为正表示手机剩的钱多，为负表示卖了股票依然赔本
-   因此，我们就需要对上面的两个数组进行更新，对每次交易，都希望花的少，赚得多

```python
buy[index] = min((price - sell[index - 1]), buy[index])
sell[index] = max((price - buy[index]), sell[index])
```

用每天的价格去更新交易值



```python
class Solution:
    def maxProfit(self, k: int, prices: List[int]) -> int:
        length = len(prices)
        if length <= 1:
            return 0

        if k >= length // 2:
            ans = 0
            for i in range(1, length):
                if prices[i] > prices[i - 1]:
                    ans += prices[i] - prices[i - 1]
            return ans

        inf = float('inf')
        buy = [inf] * (k + 1)
        sell = [0] * (k + 1)

        # 每天的价格更新每次交易的钱数，使得花出去的钱最少，赚到的钱最多
        for price in prices:
            for index in range(1, k + 1):
                buy[index] = min((price - sell[index - 1]), buy[index])
                sell[index] = max((price - buy[index]), sell[index])

        return sell[k]
```

