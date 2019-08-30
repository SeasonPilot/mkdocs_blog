# LeetCode: 739. 每日温度

[TOC]

## 1、题目描述

根据每日 气温 列表，请重新生成一个列表，对应位置的输入是你需要再等待多久温度才会升高超过该日的天数。如果之后都不会升高，请在该位置用 `0` 来代替。

例如，给定一个列表 `temperatures = [73, 74, 75, 71, 69, 72, 76, 73]`，你的输出应该是 `[1, 1, 4, 2, 1, 1, 0, 0]`。

提示：气温 列表长度的范围是 `[1, 30000]`。每个气温的值的均为华氏度，都是在 `[30, 100]` 范围内的整数。



## 2、解题思路

- 使用栈保存过去的状态，遇到更高温度将小于该温度的都出栈



```python
class Solution:
    def dailyTemperatures(self, T: List[int]) -> List[int]:
        from collections import namedtuple
        Node = namedtuple("Node", ["temperature", "index"])
        stack = []

        ans = [0] * len(T)
        for index, temp in enumerate(T):
            if not stack:
                stack.append(Node(temp, index))
            else:

                while stack and temp > stack[-1].temperature:
                    ans[stack[-1].index] = index - stack[-1].index
                    stack.pop()
                stack.append(Node(temp, index))
        return ans
```

