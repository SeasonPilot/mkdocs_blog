# LeetCode: 691. 贴纸拼词

[TOC]

## 1、题目描述

我们给出了 `N` 种不同类型的贴纸。每个贴纸上都有一个小写的英文单词。

你希望从自己的贴纸集合中裁剪单个字母并重新排列它们，从而拼写出给定的目标字符串 `target`。

如果你愿意的话，你可以不止一次地使用每一张贴纸，而且每一张贴纸的数量都是无限的。

拼出目标 `target` 所需的最小贴纸数量是多少？如果任务不可能，则返回 `-1`。

 

**示例 1：**

```
输入：

["with", "example", "science"], "thehat"
输出：

3
解释：

我们可以使用 2 个 "with" 贴纸，和 1 个 "example" 贴纸。
把贴纸上的字母剪下来并重新排列后，就可以形成目标 “thehat“ 了。
此外，这是形成目标字符串所需的最小贴纸数量。
```


**示例 2：**

```
输入：

["notice", "possible"], "basicbasic"
输出：

-1
解释：

我们不能通过剪切给定贴纸的字母来形成目标“basicbasic”。
```

**提示：**

- `stickers 长度范围是 [1, 50]。`
- `stickers 由小写英文单词组成（不带撇号）。`
- `target 的长度在 [1, 15] 范围内，由小写字母组成。`
- `在所有的测试案例中，所有的单词都是从 1000 个最常见的美国英语单词中随机选取的，目标是两个随机单词的串联。`
- `时间限制可能比平时更具挑战性。预计 50 个贴纸的测试案例平均可在35ms内解决。`




## 2、解题思路

- 使用DFS加缓存
- 每一次构造新的字符串，进行递归

使用`lru_cache`

```python
class Solution:
    def minStickers(self, stickers: List[str], target: str) -> int:
        from collections import Counter
        from functools import lru_cache

        count = [Counter(x) for x in stickers]

        @lru_cache(None)
        def dfs(s):
            nonlocal count
            if not s:
                return 0

            c = Counter(s)
            ans = float('inf')

            for t in count:
                if s[-1] not in t:
                    continue
                new_tar = ""

                for k, v in c.items():
                    new_tar += k * (max(0, v - t[k]))
                ans = min(ans, dfs(new_tar) + 1)
            return ans

        res = dfs(target)

        return res if res != float('inf') else -1
```



- DFS加记忆化

```python
class Solution:
    def minStickers(self, stickers: List[str], target: str) -> int:
        from collections import Counter

        count = [Counter(x) for x in stickers]
        memo = {"": 0}

        def dfs(s):
            nonlocal count
            if s in memo:
                return memo[s]

            c = Counter(s)
            ans = float('inf')

            for t in count:
                if s[-1] not in t:
                    continue
                new_tar = ""
                for k, v in c.items():
                    new_tar += k * (max(0, v - t[k]))
                if new_tar == "":
                    ans = 1
                    break
                ans = min(ans, dfs(new_tar) + 1)
            memo[s] = ans
            return ans

        res = dfs(target)

        return res if res != float('inf') else -1
```

