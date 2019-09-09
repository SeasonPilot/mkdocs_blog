# LeetCode: 638. 大礼包

[TOC]

## 1、题目描述

在`LeetCode`商店中， 有许多在售的物品。

然而，也有一些大礼包，每个大礼包以优惠的价格捆绑销售一组物品。

现给定每个物品的价格，每个大礼包包含物品的清单，以及待购物品清单。请输出确切完成待购清单的最低花费。

每个大礼包的由一个数组中的一组数据描述，最后一个数字代表大礼包的价格，其他数字分别表示内含的其他种类物品的数量。

任意大礼包可无限次购买。

**示例 1:**

```
输入: [2,5], [[3,0,5],[1,2,10]], [3,2]
输出: 14
解释: 
有A和B两种物品，价格分别为¥2和¥5。
大礼包1，你可以以¥5的价格购买3A和0B。
大礼包2， 你可以以¥10的价格购买1A和2B。
你需要购买3个A和2个B， 所以你付了¥10购买了1A和2B（大礼包2），以及¥4购买2A。
```


**示例 2:**

```
输入: [2,3,4], [[1,1,0,4],[2,2,1,9]], [1,2,1]
输出: 11
解释: 
A，B，C的价格分别为¥2，¥3，¥4.
你可以用¥4购买1A和1B，也可以用¥9购买2A，2B和1C。
你需要买1A，2B和1C，所以你付了¥4买了1A和1B（大礼包1），以及¥3购买1B， ¥4购买1C。
你不可以购买超出待购清单的物品，尽管购买大礼包2更加便宜。
```


**说明:**

- `最多6种物品， 100种大礼包。`
- `每种物品，你最多只需要购买6个。`
- `你不可以购买超出待购清单的物品，即使更便宜。`



## 2、解题思路

- 使用回溯法

- 首先过滤掉比直接买更贵的大礼包

```
- 判断需要购买的是否已经买齐，买完了返回0
- 过滤掉比需要购买的数量更多的大礼包
- 如果找不到合适的礼包，直接购买并返回
- 如果有礼包，递归查找，在里面找出最便宜的方案返回
```



```python
class Solution:
    def shoppingOffers(self, price: List[int], special: List[List[int]], needs: List[int]) -> int:
        def shop(spec, need):
            """

            :param spec: 大礼包
            :param need: 需要买的东西数量
            :return:
            """
            if sum(need) == 0:
                return 0

            current_spec = list(filter(lambda x: all(x[i] <= need[i] for i in range(length)), spec))

            if not current_spec:
                return sum(need[i] * price[i] for i in range(length))
            res = []
            for sp in current_spec:
                res.append(sp[-1] + shop(current_spec, [need[i] - sp[i] for i in range(length)]))
            return min(res)

        length = len(price)

        special = list(filter(lambda x: x[-1] < sum(x[i] * price[i] for i in range(length)), special))

        return shop(special, needs)
```

