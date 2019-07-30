# LeetCode: 163. 缺失的区间

[TOC]

## 1、题目描述

给定一个排序的整数数组 nums ，其中元素的范围在 闭区间 [lower, upper] 当中，返回不包含在数组中的缺失区间。

**示例：**

```
输入: nums = [0, 1, 3, 50, 75], lower = 0 和 upper = 99,
输出: ["2", "4->49", "51->74", "76->99"]
```



## 2、解题思路

- 首先判断是否为空
  - 为空返回区间
- lower与upper要单独判断，因为是闭区间
- 中间的数字则是判断是否是差值大于等于2
  - 等于2则添加数字
  - 大于2则添加区间



```python
class Solution:
    def findMissingRanges(self, nums: List[int], lower: int, upper: int) -> List[str]:
        if not nums:
            if lower == upper:
                return [str(lower)]
            else:
                return [str(lower) + "->" + str(upper)]
        pre = nums[0]
        res = []
        if pre - lower >= 1:
            if pre - lower == 1:
                res.append(str(lower))
            else:
                res.append(str(lower) + "->" + str(pre - 1))

        for i in range(1,len(nums)):
            if nums[i] - pre > 1:
                if nums[i] - pre == 2:
                    res.append(str(nums[i] - 1))
                else:
                    res.append(str(pre + 1) + "->" + str(nums[i] - 1))
            pre = nums[i]

        if upper - pre >= 1:
            if upper - pre == 1:
                res.append(str(upper))
            else:
                res.append(str(pre + 1) + "->" + str(upper))
        return res
```



