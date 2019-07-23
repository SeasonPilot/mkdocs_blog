# LeetCode: 1041. 困于环中的机器人

[TOC]

## 1、题目描述

在无限的平面上，机器人最初位于 (0, 0) 处，面朝北方。机器人可以接受下列三条指令之一：

"G"：直走 1 个单位
"L"：左转 90 度
"R"：右转 90 度
机器人按顺序执行指令 instructions，并一直重复它们。

只有在平面中存在环使得机器人永远无法离开时，返回 true。否则，返回 false。

 ```
示例 1：
输入："GGLLGG"
输出：true
解释：
机器人从 (0,0) 移动到 (0,2)，转 180 度，然后回到 (0,0)。
重复这些指令，机器人将保持在以原点为中心，2 为半径的环中进行移动。

示例 2：
输入："GG"
输出：false
解释：
机器人无限向北移动。

示例 3：
输入："GL"
输出：true
解释：
机器人按 (0, 0) -> (0, 1) -> (-1, 1) -> (-1, 0) -> (0, 0) -> ... 进行移动。
 ```



**提示：**

-  $1 <= instructions.length <= 100$ 

-  `instructions[i] 在 {'G', 'L', 'R'}` 中

## 2、解题思路

- 如果机器人困于环中，那么机器人经过几轮指令就能够回到原点
- 执行完指令，与当前机器人方向的差别可能是0，90，180，那么最多4轮就能确定机器人是否能够回到原点（90度需要4轮）
- 为何经过4轮，机器人方向相同就能判断能否形成环呢？因为当方向相同还不能回到原点，那么机器人后续就会渐行渐远



因此，记录当前的方向，以及每个方向走的距离，进行判断

```python
class Solution:
    def isRobotBounded(self, instructions: str) -> bool:
        # 四个方向走的距离
        axis = [0, 0, 0, 0]
        # 0: 北
        # 1: 东
        # 2: 南
        # 3: 西
        direction = 0

        count = 0
        while count < 4:
            for i in instructions:
                if i == "G":
                    axis[direction] += 1
                elif i == "R":
                    direction = (direction + 1) % 4
                elif i == "L":
                    direction = (direction - 1 + 4) % 4
            count += 1

        if axis[0] == axis[2] and axis[1] == axis[3]:
            return True
        return False
```

