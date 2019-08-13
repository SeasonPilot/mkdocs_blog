# LeetCode: 470. 用 Rand7() 实现 Rand10()

[TOC]

## 1、题目描述

已有方法 rand7 可生成 1 到 7 范围内的均匀随机整数，试写一个方法 rand10 生成 1 到 10 范围内的均匀随机整数。

不要使用系统的 Math.random() 方法。

```
示例 1:
输入: 1
输出: [7]

示例 2:
输入: 2
输出: [8,4]

示例 3:
输入: 3
输出: [8,1,10]
```

 

**提示:**

rand7 已定义。
传入参数: n 表示 rand10 的调用次数。



**进阶:**

- rand7()调用次数的 期望值 是多少 ?

- 你能否尽量少调用 rand7() ?

## 2、解题思路

- 概率题

- 首先得到概率0.5，

  ```
  数字1-6，奇偶数出现次数能够得到0.5的概率，如果出现的是7，重新获取数字
  ```

  如果出现的是奇数，base的值为0

  如果出现的是偶数，base的值为5

- 然后用得到0.2的概率

  ```
  数字1-5，只需要这几个数，出现6和7，重新获取
  ```

  用当前值加上base的值

```python
# The rand7() API is already defined for you.
# def rand7():
# @return a random integer in the range 1 to 7

class Solution:
    def rand10(self):
        """
        :rtype: int
        """
        x = rand7()
        y = rand7()
        while x==7:
            x=rand7()
        while y>5:
            y=rand7()
        res = 0 if x&1 else 5
        return res+y

```

