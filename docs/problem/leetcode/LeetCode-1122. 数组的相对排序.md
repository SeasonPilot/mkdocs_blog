# LeetCode: 1122. 数组的相对排序

[TOC]

## 1、题目描述

给你两个数组，`arr1` 和 `arr2`，

`arr2` 中的元素各不相同
`arr2` 中的每个元素都出现在 `arr1` 中
对 `arr1` 中的元素进行排序，使 `arr1` 中项的相对顺序和 `arr2` 中的相对顺序相同。未在 `arr2` 中出现过的元素需要按照升序放在 `arr1` 的末尾。

 

**示例：**

```
输入：arr1 = [2,3,1,3,2,4,6,7,9,2,19], arr2 = [2,1,4,3,9,6]
输出：[2,2,2,1,4,3,3,9,6,7,19]
```



**提示：**

-  $arr1.length, arr2.length <= 1000$

-  $0 <= arr1[i], arr2[i] <= 1000$ 

- `arr2` 中的元素` arr2[i]` 各不相同

- `arr2` 中的每个元素 `arr2[i]` 都出现在 `arr1` 中



## 2、解题思路

- 分成两部分，同时出现在两个数组和只出现在第一个数组中的数字分别保存
- 数字按照出现在第二个数组中的顺序排序
- 考虑重复的情况，将结果进行组合



```python
class Solution:
    def relativeSortArray(self, arr1: List[int], arr2: List[int]) -> List[int]:
        from collections import Counter
        c = Counter(arr1)
        a1 = set(arr1) - set(arr2)
        a1_a2 = set(arr1) - a1

        temp = sorted(a1_a2, key=arr2.index) + sorted(a1)

        res = []
        for i in temp:
            res += [i] * c[i]
        return res
```

