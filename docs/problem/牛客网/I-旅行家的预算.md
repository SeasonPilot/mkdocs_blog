# I-旅行家的预算

[TOC]

```
牛客假日团队赛9
```

## 1、题目描述

一个旅行家想驾驶汽车以最少的费用从一个城市到另一个城市（假设出发时油箱是空的）。给定两个城市之间的距离D1、汽车油箱的容量C（以升为单位）、每升汽油能行驶的距离D2、出发点每升汽油价格P和沿途油站数N（N可以为零），油站i离出发点的距离Di、每升汽油价格Pi（i=1，2，…，N）。

计算结果四舍五入至小数点后两位。如果无法到达目的地，则输出“No Solution”。

[链接](https://ac.nowcoder.com/acm/contest/1071/I)

### 输入描述:

```
第一行：D1，C，D2，P，N。接下来有N行。第i+1行，两个数字，油站i离出发点的距离Di和每升汽油价格Pi。
```

### 输出描述:

```
所需最小费用，计算结果四舍五入至小数点后两位。如果无法到达目的地，则输出“No Solution”。
```

### 示例1

#### 输入

```
275.6 11.9 27.4 2.8 2
102.0 2.9
220.0 2.2
```

#### 输出

```
26.95
```

### 备注:

```
N≤6,其余数字≤500
```

## 2、解题思路

- 使用贪心法，每次都从当前位置找下一个汽油价格小的加油站，如果找不到，就继续走
- 在当前加油站判断，是否需要加油，判断是否需要加油才能够行驶到下一个加油站或者价格更低的加油站



```python
def solve(total_distance, capacity, gasoline_distance, gasoline_prices):
    cost = 0.0
    oil = 0.0
    last_pos = 0
    for index, (distance, price) in enumerate(gasoline_prices):
        oil -= (distance - last_pos) / gasoline_distance
        if oil < 0:
            cost = -1
            break
        if price < 0:
            break
        next_tank = index + 1
        for pointer in range(next_tank, len(gasoline_prices)):
            if gasoline_prices[pointer][1] < price:
                next_tank = pointer
                break
        oil_need = (gasoline_prices[next_tank][0] - distance) / gasoline_distance
        oil_need = min(capacity, oil_need)
        add_oil = oil_need - oil

        if add_oil > 0:
            cost += add_oil * price
            oil += add_oil
        last_pos = distance
    if cost == -1:
        print("No Solution")
    else:
        print("{:.2f}".format(cost))


prices = []
t, c, d, p, tanks = input().strip().split()

prices.append([0.0, float(p)])
for i in range(int(tanks)):
    dis, tank_price = input().strip().split()
    prices.append([float(dis), float(tank_price)])

prices.append([float(t), -1])

prices.sort()

solve(float(t), float(c), float(d), prices)

```

