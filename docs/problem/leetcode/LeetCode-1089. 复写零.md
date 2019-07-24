# LeetCode: 1089. 复写零

[TOC]

## 1、题目描述

给你一个长度固定的整数数组 arr，请你将该数组中出现的每个零都复写一遍，并将其余的元素向右平移。

注意：请不要在超过该数组长度的位置写入元素。

要求：请对输入的数组 就地 进行上述修改，不要从函数返回任何东西。

 

**示例 1：**

```
输入：[1,0,2,3,0,4,5,0]
输出：null
解释：调用函数后，输入的数组将被修改为：[1,0,0,2,3,0,0,4]
```



**示例 2：**

```
输入：[1,2,3]
输出：null
解释：调用函数后，输入的数组将被修改为：[1,2,3]
```



**提示：**

-  $1 <= arr.length <= 10000$

-  $0 <= arr[i] <= 9$ 



## 2、解题思路

- 设置一个缓冲数组
- 遇到0则重复并且加入数组

```python
class Solution:
    def duplicateZeros(self, arr: List[int]) -> None:
        """
        Do not return anything, modify arr in-place instead.
        """
        
        temp = []
        for i in arr:
            if i != 0:
                temp.append(i)
            else:
                temp.extend([0,0])

            if len(temp)>= len(arr):
                break

        for index,i in enumerate(arr):
            arr[index] = temp[index]
```

