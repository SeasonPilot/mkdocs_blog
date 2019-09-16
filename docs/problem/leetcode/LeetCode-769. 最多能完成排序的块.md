# LeetCode: 769. 最多能完成排序的块

[TOC]

## 1、题目描述

数组`arr`是`[0, 1, ..., arr.length - 1]`的一种排列，我们将这个数组分割成几个“块”，并将这些块分别进行排序。之后再连接起来，使得连接的结果和按升序排序后的原数组相同。

我们最多能将数组分成多少块？

**示例 1:**

```
输入: arr = [4,3,2,1,0]
输出: 1
解释:
将数组分成2块或者更多块，都无法得到所需的结果。
例如，分成 [4, 3], [2, 1, 0] 的结果是 [3, 4, 0, 1, 2]，这不是有序的数组。
```


**示例 2:**

```
输入: arr = [1,0,2,3,4]
输出: 4
解释:
我们可以把它分成两块，例如 [1, 0], [2, 3, 4]。
然而，分成 [1, 0], [2], [3], [4] 可以得到最多的块数。
```


**注意:**

- `arr 的长度在 [1, 10] 之间。`
- `arr[i]是 [0, 1, ..., arr.length - 1]的一种排列。`



## 2、解题思路

- 如果当前分组的数字中，一段索引对应的都在当前段中，这几部分为一段

```
0 1 2 3 4
```

如上，上面是已经排好序的，数字正好对应其索引，因此为5段

```
0 2 1 3 4
```

如上，上面的可以分为4段

```
[0] [2 1] [3] [4]
```

只要判断下标索引段对应的数字都出现即为一段



```python
class Solution:
    def maxChunksToSorted(self, arr: List[int]) -> int:
        
        temp_set = set()

        res = 0
        for index, i in enumerate(arr):
            if index in temp_set:
                temp_set.remove(index)
            else:
                temp_set.add(index)

            if i in temp_set:
                temp_set.remove(i)
            else:
                temp_set.add(i)
                
            if not temp_set:
                res += 1
        return res
```

