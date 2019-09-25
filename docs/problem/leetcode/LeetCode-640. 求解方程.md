# LeetCode: 640. 求解方程

[TOC]

## 1、题目描述

求解一个给定的方程，将x以字符串`"x=#value"`的形式返回。该方程仅包含`'+'`，`' - '`操作，变量 `x` 和其对应系数。

如果方程没有解，请返回`“No solution”`。

如果方程有无限解，则返回`“Infinite solutions”`。

如果方程中只有一个解，要保证返回值 `x` 是一个整数。

**示例 1：**

```
输入: "x+5-3+x=6+x-2"
输出: "x=2"
```


**示例 2:**

```
输入: "x=x"
输出: "Infinite solutions"
```


**示例 3:**

```
输入: "2x=x"
输出: "x=0"
```


**示例 4:**

```
输入: "2x+3x-6x=x+2"
输出: "x=-1"
```


**示例 5:**

```
输入: "x=x+2"
输出: "No solution"


```



## 2、解题思路

- 左右拆分，并且按照序号使用字典保存
- 按照不同情况进行判断即可

```python
class Solution:
    def solveEquation(self, equation: str) -> str:
        left, right = equation.split("=")

        left_atom = left.replace("+", " +").replace("-", " -").split()
        right_atom = right.replace("+", " +").replace("-", " -").split()

        left_mapping = {1: 0, "x": 0}
        right_mapping = {1: 0, "x": 0}
        for st in left_atom:
            if st == "x":
                left_mapping["x"] += 1
            elif st[-1] == "x":
                if st[-2].isdigit():
                    left_mapping["x"] += int(st[:-1])
                else:
                    left_mapping["x"] += int(st[:-1] + "1")
            else:
                left_mapping[1] += int(st)

        for st in right_atom:
            if st == "x":
                right_mapping["x"] += 1
            elif st[-1] == "x":
                if st[-2].isdigit():
                    right_mapping["x"] += int(st[:-1])
                else:
                    right_mapping["x"] += int(st[:-1] + "1")
            else:
                right_mapping[1] += int(st)

        left_mapping["x"] -= right_mapping["x"]
        right_mapping["x"] = 0
        right_mapping[1] -= left_mapping[1]
        left_mapping[1] = 0

        if left_mapping["x"] == 0:
            if right_mapping[1] != 0:
                return "No solution"
            else:
                return "Infinite solutions"

        right_mapping[1] //= left_mapping["x"]

        return "x=" + str(right_mapping[1])
```

