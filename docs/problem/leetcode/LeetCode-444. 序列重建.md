# LeetCode: 444. 序列重建

[TOC]

## 1、题目描述

验证原始的序列 `org` 是否可以从序列集 `seqs` 中唯一地重建。序列 `org` 是 `1` 到 `n` 整数的排列，其中 $1 ≤ n ≤ 10^4$。重建是指在序列集 `seqs` 中构建最短的公共超序列。（即使得所有  `seqs` 中的序列都是该最短序列的子序列）。确定是否只可以从 `seqs` 重建唯一的序列，且该序列就是 `org` 。

**示例 1：**

```
输入：
org: [1,2,3], seqs: [[1,2],[1,3]]

输出：
false

解释：
[1,2,3] 不是可以被重建的唯一的序列，因为 [1,3,2] 也是一个合法的序列。
```

**示例 2：**

```
输入：
org: [1,2,3], seqs: [[1,2]]

输出：
false

解释：
可以重建的序列只有 [1,2]。
```

**示例 3：**

```
输入：
org: [1,2,3], seqs: [[1,2],[1,3],[2,3]]

输出：
true

解释：
序列 [1,2], [1,3] 和 [2,3] 可以被唯一地重建为原始的序列 [1,2,3]。
```

**示例 4：**

```
输入：
org: [4,1,5,2,6,3], seqs: [[5,2,6,3],[4,1,5,2]]

输出：
true


```



## 2、解题思路

-   使用拓扑排序，需要注意下面的一些条件
    -   序列中不能缺少也不能多元素
    -   唯一序列的条件就是每次只有一个元素入度为0



```python
from collections import defaultdict


class Solution:
    def sequenceReconstruction(self, org: List[int], seqs: List[List[int]]) -> bool:
        graph = defaultdict(set)
        degree = defaultdict(int)
        seq_set = set()
        temp = []
        zero_degree = set()
        for row in seqs:
            seq_set.update(set(row))
            for i in range(len(row) - 1):

                if row[i + 1] not in graph[row[i]]:
                    degree[row[i + 1]] += 1
                    graph[row[i]].add(row[i + 1])
        if len(seq_set) != len(org):
            return False

        for num in org:
            if degree[num] == 0 and num in seq_set:
                zero_degree.add(num)
        pos = 0
        while zero_degree and pos < len(org):
            if len(zero_degree) != 1:
                return False
            cur = zero_degree.pop()
            temp.append(cur)
            if temp[pos] != org[pos]:
                return False
            pos += 1
            for n in graph[cur]:
                degree[n] -= 1
                if degree[n] == 0:
                    zero_degree.add(n)
        return temp == org
```

