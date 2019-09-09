# LeetCode: 1023. 驼峰式匹配

[TOC]

## 1、题目描述

如果我们可以将小写字母插入模式串 `pattern` 得到待查询项 `query`，那么待查询项与给定模式串匹配。（我们可以在任何位置插入每个字符，也可以插入 `0` 个字符。）

给定待查询列表 `queries`，和模式串 `pattern`，返回由布尔值组成的答案列表 `answer`。只有在待查项 `queries[i]` 与模式串 `pattern` 匹配时， `answer[i]` 才为 `true`，否则为 `false`。

 

**示例 1：**

```
输入：queries = ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FB"
输出：[true,false,true,true,false]
示例：
"FooBar" 可以这样生成："F" + "oo" + "B" + "ar"。
"FootBall" 可以这样生成："F" + "oot" + "B" + "all".
"FrameBuffer" 可以这样生成："F" + "rame" + "B" + "uffer".
```


**示例 2：**

```
输入：queries = ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FoBa"
输出：[true,false,true,false,false]
解释：
"FooBar" 可以这样生成："Fo" + "o" + "Ba" + "r".
"FootBall" 可以这样生成："Fo" + "ot" + "Ba" + "ll".
```


**示例 3：**

```
输出：queries = ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FoBaT"
输入：[false,true,false,false,false]
解释： 
"FooBarTest" 可以这样生成："Fo" + "o" + "Ba" + "r" + "T" + "est".
```

**提示：**

- `1 <= queries.length <= 100`
- `1 <= queries[i].length <= 100`
- `1 <= pattern.length <= 100`
- `所有字符串都仅由大写和小写英文字母组成。`



## 2、解题思路

- 直接匹配出所有的`Partten`，判断不能匹配的字符中是否有大写字母

```python
from string import ascii_uppercase

class Solution:
    def camelMatch(self, queries: List[str], pattern: str) -> List[bool]:
        upper = set(ascii_uppercase)

        def judge(word, part):
            w_pos = 0
            p_pos = 0
            not_equal = set()
            while p_pos < len(part) and w_pos < len(word):
                if word[w_pos] == part[p_pos]:
                    p_pos += 1
                else:
                    not_equal.add(word[w_pos])
                w_pos += 1
            if p_pos < len(part):
                return False
            not_equal.update(word[w_pos:])
            if not not_equal & upper:
                return True
            return False

        return [judge(w, pattern) for w in queries]
```

