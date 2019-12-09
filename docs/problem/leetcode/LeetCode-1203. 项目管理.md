# LeetCode: 1203. 项目管理

[TOC]

## 1、题目描述

公司共有 `n` 个项目和  `m` 个小组，每个项目要不没有归属，要不就由其中的一个小组负责。

我们用 `group[i]` 代表第 `i` 个项目所属的小组，如果这个项目目前无人接手，那么 `group[i]` 就等于 `-1`。（项目和小组都是从零开始编号的）

请你帮忙按要求安排这些项目的进度，并返回排序后的项目列表：

-   同一小组的项目，排序后在列表中彼此相邻。
-   项目之间存在一定的依赖关系，我们用一个列表 `beforeItems` 来表示，其中 `beforeItems[i]` 表示在进行第 `i` 个项目前（位于第 `i` 个项目左侧）应该完成的所有项目。

**结果要求：**

如果存在多个解决方案，只需要返回其中任意一个即可。

如果没有合适的解决方案，就请返回一个 **空列表**。

 

**示例 1：**

![img](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-12-09-011448.png)

```
输入：n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3,6],[],[],[]]
输出：[6,3,4,1,5,2,0,7]
```


**示例 2：**

```
输入：n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3],[],[4],[]]
输出：[]
解释：与示例 1 大致相同，但是在排序后的列表中，4 必须放在 6 的前面。
```

**提示：**

-   `1 <= m <= n <= 3*10^4`
-   `group.length == beforeItems.length == n`
-   `-1 <= group[i] <= m-1`
-   `0 <= beforeItems[i].length <= n-1`
-   `0 <= beforeItems[i][j] <= n-1`
-   `i != beforeItems[i][j]`



## 2、解题思路

-   二维的拓扑排序
-   首先建立所有组之间的关系，找出小组能够输出的顺序，如果存在小组间依赖，肯定不能输出，返回空
-   然后按照小组的输出顺序，对组内项目进行拓扑排序，针对每个小组都进行下面的操作
    -   首先将没有小组的项目，并且没有依赖的（入度为0）的加入结果集中，并更新它后续项目的入度
    -   然后处理所有当前小组中的所有的项目，对当前小组中的项目进行拓扑排序，并加入到结果集中，如果小组中依旧有项目的入度依赖其他项目，表示当前小组的项目没办法连续，无法完成排序



```python
from collections import defaultdict


class Solution:
    def sortItems(self, n: int, m: int, group: List[int], beforeItems: List[List[int]]) -> List[int]:
        # 表示项目的依赖关系
        graph = defaultdict(list)
        # 依赖（入度）为0的项目
        zero_in_degree = set()
        # 项目的入度
        project_in_degree = defaultdict(int)
        # 小组中的项目
        group_project = defaultdict(set)
        # 小组的项目依赖
        group_graph = defaultdict(set)
        # 小组的入度
        group_in_degree = defaultdict(int)

        ans = []

        for index, (g, before) in enumerate(zip(group, beforeItems)):
            group_project[g].add(index)
            for before_project in before:
                graph[before_project].append(index)
                project_in_degree[index] += 1
                if g != -1 and group[before_project] != -1 and g != group[before_project]:
                    group_graph[group[before_project]].add(g)
        for i in range(n):
            if project_in_degree[i] == 0:
                zero_in_degree.add(i)
        sorted_group = []
        zero_group = set()
        for pre_group, next_groups in group_graph.items():
            for ng in next_groups:
                group_in_degree[ng] += 1
        for i in range(m):
            if group_in_degree[i] == 0:
                zero_group.add(i)
        while zero_group:
            current_group = zero_group.pop()
            sorted_group.append(current_group)
            for next_group in group_graph[current_group]:
                group_in_degree[next_group] -= 1
                if group_in_degree[next_group] == 0:
                    zero_group.add(next_group)

        # 小组之间存在循环依赖
        if len(sorted_group) != m:
            return []

        def update_in_degree(project):
            """
            更新节点的度
            :param project:
            :return:
            """
            for next_project in graph[project]:
                project_in_degree[next_project] -= 1
                if project_in_degree[next_project] == 0:
                    zero_in_degree.add(next_project)

        def process_with_no_group_project():
            """
            处理没有分组并且度为0的节点
            :return:
            """
            while group_project[-1].intersection(zero_in_degree):
                for no_group_project in group_project[-1].intersection(zero_in_degree):
                    ans.append(no_group_project)
                    zero_in_degree.remove(no_group_project)
                    update_in_degree(no_group_project)
                    group_project[-1].remove(no_group_project)

        for current_group in sorted_group:
            process_with_no_group_project()
            while zero_in_degree.intersection(group_project[current_group]):
                for current_group_project in zero_in_degree.intersection(group_project[current_group]):
                    ans.append(current_group_project)
                    zero_in_degree.remove(current_group_project)
                    group_project[current_group].remove(current_group_project)
                    update_in_degree(current_group_project)
            if group_project[current_group]:
                return []
        process_with_no_group_project()

        if len(ans) == n:
            return ans
        return []
```

