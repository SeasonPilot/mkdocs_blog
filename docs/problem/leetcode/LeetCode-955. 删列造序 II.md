# LeetCode: 955. 删列造序 II

[TOC]

## 1、题目描述

给定由 `N` 个小写字母字符串组成的数组 `A`，其中每个字符串长度相等。

选取一个删除索引序列，对于 `A` 中的每个字符串，删除对应每个索引处的字符。

比如，有 `A = ["abcdef", "uvwxyz"]`，删除索引序列 `{0, 2, 3}`，删除后 A 为`["bef", "vyz"]`。

假设，我们选择了一组删除索引 D，那么在执行删除操作之后，最终得到的数组的元素是按 字典序`（A[0] <= A[1] <= A[2] ... <= A[A.length - 1]）`排列的，然后请你返回 `D.length` 的最小可能值。

 

**示例 1：**

```
输入：["ca","bb","ac"]
输出：1
解释： 
删除第一列后，A = ["a", "b", "c"]。
现在 A 中元素是按字典排列的 (即，A[0] <= A[1] <= A[2])。
我们至少需要进行 1 次删除，因为最初 A 不是按字典序排列的，所以答案是 1。
```


**示例 2：**

```
输入：["xc","yb","za"]
输出：0
解释：
A 的列已经是按字典序排列了，所以我们不需要删除任何东西。
注意 A 的行不需要按字典序排列。
也就是说，A[0][0] <= A[0][1] <= ... 不一定成立。
```


**示例 3：**

```
输入：["zyx","wvu","tsr"]
输出：3
解释：
我们必须删掉每一列。
```

**提示：**

-   $1 <= A.length <= 100$
-   $1 <= A[i].length <= 100$



## 2、解题思路

-   设置一个列表，保存当前列需要判断的位置
-   每一次判断一列，如果当前列中在判断列表中的位置存在逆序的，当前列需要删掉，不需要更新判断列表
-   如果当前列都满足条件，就将所有`==`的添加到判断列中，下一轮继续判断，直到没有相等的或者判断了所有的列为止



```python
class Solution:
    def minDeletionSize(self, A: List[str]) -> int:
        length = len(A)
        col = len(A[0])

        ans = 0
        pos = 0
        judge = list(range(1, length))

        while judge and pos < col:
            flag = False
            next_judge = set()
            for i in judge:
                if A[i][pos] < A[i - 1][pos]:
                    flag = True
                    break
                elif A[i][pos] == A[i - 1][pos]:
                    next_judge.add(i)
            if flag:
                ans += 1
            else:
                judge = sorted(next_judge)
            pos += 1

        return ans
```

