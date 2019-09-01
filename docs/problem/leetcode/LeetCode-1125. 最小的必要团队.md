# LeetCode: 1125. 最小的必要团队

[TOC]

## 1、题目描述

作为项目经理，你规划了一份需求的技能清单 `req_skills`，并打算从备选人员名单 `people` 中选出些人组成一个「必要团队」（ 编号为 `i` 的备选人员 `people[i]` 含有一份该备选人员掌握的技能列表）。

所谓「必要团队」，就是在这个团队中，对于所需求的技能列表 `req_skills` 中列出的每项技能，团队中至少有一名成员已经掌握。

我们可以用每个人的编号来表示团队中的成员：例如，团队 `team = [0, 1, 3]` 表示掌握技能分别为 `people[0]`，`people[1]`，和 `people[3]` 的备选人员。

请你返回 任一 规模最小的必要团队，团队成员用人员编号表示。你可以按任意顺序返回答案，本题保证答案存在。

 

**示例 1：**

```
输入：req_skills = ["java","nodejs","reactjs"], people = [["java"],["nodejs"],["nodejs","reactjs"]]
输出：[0,2]
```

**示例 2：**

```
输入：req_skills = ["algorithms","math","java","reactjs","csharp","aws"], people = [["algorithms","math","java"],["algorithms","math","reactjs"],["java","csharp","aws"],["reactjs","csharp"],["csharp","math"],["aws","java"]]
输出：[1,2]
```

**提示：**

- `1 <= req_skills.length <= 16`
- `1 <= people.length <= 60`
- `1 <= people[i].length, req_skills[i].length, people[i][j].length <= 16`
- `req_skills 和 people[i] 中的元素分别各不相同`
- `req_skills[i][j], people[i][j][k] 都由小写英文字母组成`
- `本题保证「必要团队」一定存在`

## 2、解题思路

- 使用动态规划
- 因为所有的技术不超过16种，因此按照一位对应一种技能，一共$2^{16}$就能表示所有的技能
- 设置一个dp数组，将所有的技能初始化为所有人
- dp[0]初始化为空
- 通过将当前人所拥有技能转化为位数据，进行判断
- 状态转换方程：
  - `d[x|y] = min(dp[x][y],dp[x]+dp[y])`
- 不断地判断每个人的技能对当前所在技能产生的影响，如果加入这个人令技能增加，并且人数的增加小于1，更新人员列表

最后得到所有技能都覆盖的人员列表

```python
class Solution:
    def smallestSufficientTeam(self, req_skills: List[str], people: List[List[str]]) -> List[int]:
        length = len(req_skills)
        mapping = {}
        for i in range(length):
            mapping[req_skills[i]] = i

        dp = [list(range(len(people))) for _ in range(1 << length)]
        dp[0] = []

        for index, l in enumerate(people):
            skill = 0
            for s in l:
                skill |= (1<<mapping[s])

            for k, v in enumerate(dp):
                n_skill = skill | k
                if n_skill != k and len(dp[n_skill]) > len(v) + 1:
                    dp[n_skill] = v + [index]

        return dp[(1 << length) - 1]
```

