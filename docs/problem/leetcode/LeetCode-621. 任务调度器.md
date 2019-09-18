# LeetCode: 621. 任务调度器

[TOC]

## 1、题目描述

给定一个用字符数组表示的 `CPU` 需要执行的任务列表。其中包含使用大写的 `A - Z` 字母表示的`26` 种不同种类的任务。任务可以以任意顺序执行，并且每个任务都可以在 `1` 个单位时间内执行完。`CPU` 在任何一个单位时间内都可以执行一个任务，或者在待命状态。

然而，两个相同种类的任务之间必须有长度为 `n` 的冷却时间，因此至少有连续 `n` 个单位时间内 `CPU` 在执行不同的任务，或者在待命状态。

你需要计算完成所有任务所需要的最短时间。

**示例 1：**

```
输入: tasks = ["A","A","A","B","B","B"], n = 2
输出: 8
执行顺序: A -> B -> (待命) -> A -> B -> (待命) -> A -> B.
```

**注：**

- `任务的总个数为 [1, 10000]。`
- `n 的取值范围为 [0, 100]。`



## 2、解题思路

- 首先统计出各个任务出现的次数
- 然后找出任务数最多的，因为同一个任务必须要间隔，因此首先判断可能形成的最小的长度
- 由于最长的长度可能由多个任务，因此这些任务的最后一个任务都放到前一个任务之后
- 如果这些任务中间还留有空隙，也就是说比任务长度要长，那么这个就是最短的时间，其他任务放到中间的空隙中即可
- 如果判断小于任务长度，表示任务数量多于间隔，这种情况可以通过调整任务顺序满足条件，因此直接返回任务长度即可



```python
from collections import Counter

class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        length = len(tasks)
        if length <= 1:
            return length

        task_count = Counter(tasks)
        max_count_task = task_count.most_common(1)[0][1]

        task_sort = sorted(task_count.items(), key=lambda x: x[1], reverse=True)

        res = (max_count_task - 1) * (n + 1)

        for sort in task_sort:
            if sort[1] == max_count_task:
                res += 1
            else:
                break

        return res if res >= length else length
```

