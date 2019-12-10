# LeetCode: 1187. 使数组严格递增

[TOC]

## 1、题目描述

给你两个整数数组 `arr1` 和 `arr2`，返回使 `arr1` 严格递增所需要的最小「操作」数（可能为 `0`）。

每一步「操作」中，你可以分别从 `arr1` 和 `arr2` 中各选出一个索引，分别为 `i` 和 `j`，`0 <= i < arr1.length` 和 `0 <= j < arr2.length`，然后进行赋值运算 `arr1[i] = arr2[j]`。

如果无法让 `arr1` 严格递增，请返回 `-1`。

 

**示例 1：**

```
输入：arr1 = [1,5,3,6,7], arr2 = [1,3,2,4]
输出：1
解释：用 2 来替换 5，之后 arr1 = [1, 2, 3, 6, 7]。
```


**示例 2：**

```
输入：arr1 = [1,5,3,6,7], arr2 = [4,3,1]
输出：2
解释：用 3 来替换 5，然后用 4 来替换 3，得到 arr1 = [1, 3, 4, 6, 7]。
```


**示例 3：**

```
输入：arr1 = [1,5,3,6,7], arr2 = [1,6,3,3]
输出：-1
解释：无法使 arr1 严格递增。
```

**提示：**

-   $1 <= arr1.length, arr2.length <= 2000$
-   $0 <= arr1[i], arr2[i] <= 10^9$



## 2、解题思路

-   动态规划
-   由于是严格递增，因此每个数字智能出现一次，首先将`arr2`去重并排序
-   针对数组`arr1`中的每个位置，找出当前位置可能出现的数字以及得到这个数字所需要的替换步数



```python
from collections import defaultdict
import bisect


class Solution:
    def makeArrayIncreasing(self, arr1: List[int], arr2: List[int]) -> int:
        arr2 = sorted(set(arr2))
        pre_num_status = {-1: 0}

        for num in arr1:
            current_num_status = defaultdict(lambda: float('inf'))
            for pre_num, count in pre_num_status.items():
                # 当前元素不需要替换
                if num > pre_num:
                    current_num_status[num] = min(current_num_status[num], count)
                # 当前元素替换成仅比前一个元素大的元素
                replace_index = bisect.bisect(arr2, pre_num)
                if replace_index < len(arr2):
                    current_num_status[arr2[replace_index]] = min(current_num_status[arr2[replace_index]], count + 1)
            pre_num_status = current_num_status

        if pre_num_status:
            # 如果判断能够得到严格递增序列，并且得到了所有的可能性需要的替换值，找到最小值
            return min(pre_num_status.values())

        return -1
```

