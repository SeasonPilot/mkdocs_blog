# LeetCode: 1300. 转变数组后最接近目标值的数组和

[TOC]

## 1、题目描述

给你一个整数数组 `arr` 和一个目标值 `target` ，请你返回一个整数 `value` ，使得将数组中所有大于 `value` 的值变成 `value` 后，数组的和最接近  `target` （最接近表示两者之差的绝对值最小）。

如果有多种使得和最接近 `target` 的方案，请你返回这些整数中的最小值。

请注意，答案不一定是 `arr` 中的数字。

 

**示例 1：**

```
输入：arr = [4,9,3], target = 10
输出：3
解释：当选择 value 为 3 时，数组会变成 [3, 3, 3]，和为 9 ，这是最接近 target 的方案。
```


**示例 2：**

```
输入：arr = [2,3,5], target = 10
输出：5
```


**示例 3：**

```
输入：arr = [60864,25176,27249,21296,20204], target = 56803
输出：11361
```

**提示：**

-   $1 <= arr.length <= 10^4$
-   $1 <= arr[i], target <= 10^5$



## 2、解题思路

- 首先判断和值是否小于等于`target`，如果是，直接返回最大值即可
- 如何才能最接近目标值呢？
- 假设数组中的元素都是一样的，最近接的就是
    - `target//length`
    - `target//length +1`
- 考虑到小于`value`的数不能转化，找出所有小于`target/length`的值，令`target`减去，剩余的数字等分`target`的剩余部分，此时只需要考虑是否整除，不能整除考虑前后两个值的距离绝对值即可



```python
import bisect
from itertools import accumulate


class Solution:
    def findBestValue(self, arr: List[int], target: int) -> int:
        total = sum(arr)
        if total <= target:
            return max(arr)
        arr_sort = sorted(arr)
        length = len(arr)
        acc = [0] + list(accumulate(arr_sort))

        index = bisect.bisect_left(arr_sort, target / length)
        temp = target - acc[index]

        res1 = temp // (length - index)
        res2 = res1 + 1
        diff1 = abs(target - acc[index] - res1 * (length - index))
        diff2 = abs(target - acc[index] - res2 * (length - index))
        return res1 if diff1 <= diff2 else res2
```

