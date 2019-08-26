# LeetCode: 677. 键值映射

[TOC]

## 1、题目描述

实现一个 `MapSum` 类里的两个方法，`insert` 和 `sum`。

对于方法 `insert`，你将得到一对（字符串，整数）的键值对。字符串表示键，整数表示值。如果键已经存在，那么原来的键值对将被替代成新的键值对。

对于方法 `sum`，你将得到一个表示前缀的字符串，你需要返回所有以该前缀开头的键的值的总和。

**示例 1:**

```
输入: insert("apple", 3), 输出: Null
输入: sum("ap"), 输出: 3
输入: insert("app", 2), 输出: Null
输入: sum("ap"), 输出: 5
```



## 2、解题思路

- 使用字典树Trie树 



```python
class MapSum:
    
    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.data = [None, {}]

    def insert(self, key: str, val: int) -> None:
        current = self.data
        for c in key:
            if c not in current[1]:
                current[1][c] = [None, {}]
            current = current[1][c]
        current[0] = val

    def sum(self, prefix: str) -> int:
        current = self.data
        for c in prefix:
            if c not in current[1]:
                return 0
            current = current[1][c]

        def dfs(node):
            temp = 0
            if node[0]:
                temp += node[0]
            for k, v in node[1].items():
                temp += dfs(v)
            return temp

        return dfs(current)

# Your MapSum object will be instantiated and called as such:
# obj = MapSum()
# obj.insert(key,val)
# param_2 = obj.sum(prefix)
```

