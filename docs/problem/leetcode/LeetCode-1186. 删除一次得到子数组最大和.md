# LeetCode: 1186. 删除一次得到子数组最大和

[TOC]

## 1、题目描述

给你一个整数数组，返回它的某个 非空 子数组（连续元素）在执行一次可选的删除操作后，所能得到的最大元素总和。

换句话说，你可以从原数组中选出一个子数组，并可以决定要不要从中删除一个元素（只能删一次哦），（删除后）子数组中至少应当有一个元素，然后该子数组（剩下）的元素总和是所有子数组之中最大的。

注意，删除一个元素后，子数组 不能为空。

请看示例：

**示例 1：**

```
输入：arr = [1,-2,0,3]
输出：4
解释：我们可以选出 [1, -2, 0, 3]，然后删掉 -2，这样得到 [1, 0, 3]，和最大。
```


**示例 2：**

```
输入：arr = [1,-2,-2,3]
输出：3
解释：我们直接选出 [3]，这就是最大和。
```


**示例 3：**

```
输入：arr = [-1,-1,-1,-1]
输出：-1
解释：最后得到的子数组不能为空，所以我们不能选择 [-1] 并从中删去 -1 来得到 0。
     我们应该直接选择 [-1]，或者选择 [-1, -1] 再从中删去一个 -1。
```

**提示：**

- `1 <= arr.length <= 10^5`
- `-10^4 <= arr[i] <= 10^4`



## 2、解题思路

- 思路较为简单
- 设计两个数组，left和right，
  - left 统计从0到当前位置最大的和值
  - right统计从最后位置到当前位置的最大和值
- 结果值从下面的情况中寻找：
  - 左面最大，不含当前值
  - 右面最大，不含当前值
  - 左面最大，含当前值
  - 右面最大，含当前值
  - 左面最大加右面最大，不含当前值
  - 左面最大加右面最大，含当前值

```python
class Solution:
    def maximumSum(self, arr: List[int]) -> int:
        length = len(arr)

        left = [0] * length
        right = [0] * length

        left[0] = arr[0]
        right[-1] = arr[-1]

        for i in range(1, length):
            left[i] = max(left[i - 1] + arr[i], arr[i])
            right[length - i - 1] = max(right[length - i] + arr[length - i - 1], arr[length - i - 1])

        n_inf = float('-inf')
        res = n_inf
        for i in range(length):
            left_val = left[i - 1] if i > 0 else n_inf
            right_val = right[i + 1] if i < length - 1 else n_inf

            res = max(res, left_val, right_val, left_val + right_val, left[i], right[i], left[i] + right[i] - arr[i])
        return res
```

