# LeetCode: 870. 优势洗牌

[TOC]

## 1、题目描述

给定两个大小相等的数组 `A` 和 `B`，`A` 相对于 `B` 的优势可以用满足 `A[i] > B[i]` 的索引 `i` 的数目来描述。

返回 `A` 的任意排列，使其相对于 `B` 的优势最大化。

 

**示例 1：**

```
输入：A = [2,7,11,15], B = [1,10,4,11]
输出：[2,11,7,15]
```

**示例 2：**

```
输入：A = [12,24,8,32], B = [13,25,32,11]
输出：[24,32,8,12]
```

**提示：**

-   $1 <= A.length = B.length <= 10000$
-   $0 <= A[i] <= 10^9$
-   $0 <= B[i] <= 10^9$



## 2、解题思路

-   贪心法
-   用A中比最接近B中的数字并且大于的放在对应的位置上
-   首先对A进行排序
-   对B进行排序，需要记住排序之前的顺序
-   从前向后匹配，对B的中每一个元素，都找离它最近的覆盖
-   最后将没有用到的元素填充到其他位置即可



```python
class Solution:
    def advantageCount(self, A: List[int], B: List[int]) -> List[int]:
        
        length = len(A)
        A.sort()
        visited = [0] * length
        index_b = [[num, index] for index, num in enumerate(B)]
        index_b.sort()
        ans = [-1] * length
        a_pos = 0
        b_pos = 0

        while b_pos < length:
            while a_pos < length:
                if A[a_pos] > index_b[b_pos][0]:
                    visited[a_pos] = 1
                    ans[index_b[b_pos][1]] = A[a_pos]
                    a_pos += 1
                    break
                a_pos += 1

            b_pos += 1
        a_pos = 0
        ans_pos = 0

        while ans_pos < length:
            if ans[ans_pos] == -1:
                while a_pos < length and visited[a_pos] != 0:
                    a_pos += 1
                ans[ans_pos] = A[a_pos]
                a_pos += 1
                ans_pos + +1
            else:
                ans_pos += 1

        return ans
```

