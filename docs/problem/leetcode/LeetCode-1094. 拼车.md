# LeetCode: 1094. 拼车

[TOC]

## 1、题目描述

假设你是一位顺风车司机，车上最初有 `capacity` 个空座位可以用来载客。由于道路的限制，车 只能 向一个方向行驶（也就是说，不允许掉头或改变方向，你可以将其想象为一个向量）。

这儿有一份行程计划表 `trips`[][]，其中 `trips[i] = [num_passengers, start_location, end_location]` 包含了你的第 `i` 次行程信息：

-   必须接送的乘客数量；
-   乘客的上车地点；
-   以及乘客的下车地点。

这些给出的地点位置是从你的 **初始** 出发位置向前行驶到这些地点所需的距离（它们一定在你的行驶方向上）。

请你根据给出的行程计划表和车子的座位数，来判断你的车是否可以顺利完成接送所用乘客的任务（当且仅当你可以在所有给定的行程中接送所有乘客时，返回 `true`，否则请返回 `false`）。

 

**示例 1：**

```
输入：trips = [[2,1,5],[3,3,7]], capacity = 4
输出：false
```


**示例 2：**

```
输入：trips = [[2,1,5],[3,3,7]], capacity = 5
输出：true
```


**示例 3：**

```
输入：trips = [[2,1,5],[3,5,7]], capacity = 3
输出：true
```


**示例 4：**

```
输入：trips = [[3,2,7],[3,7,9],[8,3,9]], capacity = 11
输出：true
```

**提示：**

-   `你可以假设乘客会自觉遵守 “先下后上” 的良好素质`
-   `trips.length <= 1000`
-   `trips[i].length == 3`
-   `1 <= trips[i][0] <= 100`
-   `0 <= trips[i][1] < trips[i][2] <= 1000`
-   `1 <= capacity <= 100000`



## 2、解题思路

-   按照上车位置排序
-   将下车位置与人数保存到栈中，每次遇到一个上车点，判断是否有人下车，保证最大的空位



```python
import heapq


class Solution:
    def carPooling(self, trips: List[List[int]], capacity: int) -> bool:
        trips.sort(key=lambda x: (x[1], x[2]))

        cur_capacity = capacity
        get_off = []

        for num_passengers, start_location, end_location in trips:

            while get_off and get_off[0][0] <= start_location:
                end_location_temp, nums = heapq.heappop(get_off)
                cur_capacity += nums
            if cur_capacity >= num_passengers:
                cur_capacity -= num_passengers
                heapq.heappush(get_off, [end_location, num_passengers])
            else:
                return False

        return True
```

