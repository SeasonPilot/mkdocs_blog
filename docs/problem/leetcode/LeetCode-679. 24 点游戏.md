# LeetCode: 679. 24 点游戏

[TOC]

## 1、题目描述

你有 `4 `张写有` 1 `到` 9` 数字的牌。你需要判断是否能通过 `*，/，+，-，(，)` 的运算得到 24。

```
示例 1:
输入: [4, 1, 8, 7]
输出: True
解释: (8-4) * (7-1) = 24


示例 2:
输入: [1, 2, 1, 2]
输出: False

```



**注意:**

- 除法运算符` / `表示实数除法，而不是整数除法。例如 `4 / (1 - 2/3) = 12 `。

- 每个运算符对两个数进行运算。特别是我们不能用 - 作为一元运算符。例如，`[1, 1, 1, 1] `作为输入时，表达式 `-1 - 1 - 1 - 1 `是不允许的。

- 你不能将数字连接在一起。例如，输入为` [1, 2, 1, 2]` 时，不能写成 `12 + 12 `。

## 2、解题思路

- 基本思路
- 一共4个数字，我们进行分步操作，首先选取其中两个数字，进行加减乘除操作，然后放到结果数组中，这样就剩下3个数字，继续选择两个数字，进行加减乘除操作，就剩下两个数字，然后最后两个数字进行操作

```
输入：[4, 1, 8, 7]
第一步：
	选出4，1进行加操作
	得到[5, 8, 7]
第二步：
	选出5，8进行加操作
	得到[13, 7]
第三步：
	最后两个数进行加操作
	得到20
第四步：
	判断能否得到24
	能得到则返回True，不能则返回False

```



```python
from operator import add, sub, mul, truediv


class Solution:
    def judgePoint24(self, nums: [int]) -> bool:
        if not nums:
            return False

        if len(nums) == 1 and abs(nums[-1] - 24) < 1e-5:
            return True

        for i in range(len(nums)):
            for j in range(len(nums)):
                if i != j:
                    temp = [nums[x] for x in range(len(nums)) if x != i and x != j]
                    for op in (add, sub, mul, truediv):
                        # 加法和乘法满足交换律，只需要计算一次即可
                        if op in (add, mul) and j > i:
                            continue

                        if op is not truediv or nums[j]:
                            temp.append(op(nums[i], nums[j]))
                            if self.judgePoint24(temp):
                                return True
                            temp.pop()

        return False
```

