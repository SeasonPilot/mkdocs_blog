# LeetCode: 170. 两数之和 III - 数据结构设计

[TOC]

## 1、题目描述

设计并实现一个 TwoSum 的类，使该类需要支持 add 和 find 的操作。

add 操作 -  对内部数据结构增加一个数。
find 操作 - 寻找内部数据结构中是否存在一对整数，使得两数之和与给定的数相等。

示例 1:

add(1); add(3); add(5);
find(4) -> true
find(7) -> false
示例 2:

add(3); add(1); add(2);
find(3) -> true
find(6) -> false



## 2、解题思路

这个题目与leetcode-1没什么区别，可自行参考



```python
class TwoSum:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.data = list()

    def add(self, number: int) -> None:
        """
        Add the number to an internal data structure..
        """
        self.data.append(number)

    def find(self, value: int) -> bool:
        """
        Find if there exists any pair of numbers which sum is equal to the value.
        """
        buff_dict = {}
        for i in range(len(self.data)):
            if self.data[i] in buff_dict:
                return True
            else:
                buff_dict[value - self.data[i]] = i
        return False


# Your TwoSum object will be instantiated and called as such:
# obj = TwoSum()
# obj.add(number)
# param_2 = obj.find(value)
```
