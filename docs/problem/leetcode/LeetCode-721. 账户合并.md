# LeetCode: 721. 账户合并

[TOC]

## 1、题目描述

给定一个列表 `accounts`，每个元素 `accounts[i]` 是一个字符串列表，其中第一个元素 `accounts[i][0]` 是 名称 `(name)`，其余元素是 `emails` 表示该帐户的邮箱地址。

现在，我们想合并这些帐户。如果两个帐户都有一些共同的邮件地址，则两个帐户必定属于同一个人。请注意，即使两个帐户具有相同的名称，它们也可能属于不同的人，因为人们可能具有相同的名称。一个人最初可以拥有任意数量的帐户，但其所有帐户都具有相同的名称。

合并帐户后，按以下格式返回帐户：每个帐户的第一个元素是名称，其余元素是按顺序排列的邮箱地址。`accounts` 本身可以以任意顺序返回。

**例子 1:**

```
Input: 
accounts = [["John", "johnsmith@mail.com", "john00@mail.com"], ["John", "johnnybravo@mail.com"], ["John", "johnsmith@mail.com", "john_newyork@mail.com"], ["Mary", "mary@mail.com"]]
Output: [["John", 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com'],  ["John", "johnnybravo@mail.com"], ["Mary", "mary@mail.com"]]
Explanation: 
  第一个和第三个 John 是同一个人，因为他们有共同的电子邮件 "johnsmith@mail.com"。 
  第二个 John 和 Mary 是不同的人，因为他们的电子邮件地址没有被其他帐户使用。
  我们可以以任何顺序返回这些列表，例如答案[['Mary'，'mary@mail.com']，['John'，'johnnybravo@mail.com']，
  ['John'，'john00@mail.com'，'john_newyork@mail.com'，'johnsmith@mail.com']]仍然会被接受。
```

**注意：**

- `accounts的长度将在[1，1000]的范围内。`
- `accounts[i]的长度将在[1，10]的范围内。`
- `accounts[i][j]的长度将在[1，30]的范围内。`

## 2、解题思路

- 使用并查集
- 设置一个映射，将邮箱映射到一个账户id上面，每次遇到相同的出现过的邮箱，就将其账户进行合并
- 在并查集中，做一点判断，总是将小的时候作为父节点，这样在最后取结果的时候省去一次循环



```python
class DFU:
    def __init__(self, length):
        self.data = list(range(length))

    def find(self, x):
        if self.data[x] != x:
            self.data[x] = self.find(self.data[x])
        return self.data[x]

    def union(self, x, y):
        xp = self.find(x)
        yp = self.find(y)
        if xp != yp:
            if yp < xp:
                self.data[xp] = yp
            else:
                self.data[yp] = xp

    def count(self):
        res = 0
        for index, i in enumerate(self.data):
            if index == i:
                res += 1
        return res


class Solution:
    def accountsMerge(self, accounts: [[str]]) -> [[str]]:

        d = DFU(len(accounts))

        mapping = {}

        for index, emails in enumerate(accounts):
            for i in range(1, len(emails)):
                if emails[i] in mapping:
                    d.union(mapping[emails[i]], index)

            target = d.find(index)
            for i in range(1, len(emails)):
                mapping[emails[i]] = target

        res = {}
        for index, i in enumerate(d.data):
            if index == i:
                res[index] = accounts[index]
            else:
                res[d.find(index)].extend(accounts[index][1:])

        return [[x[0]] + sorted(set(x[1:])) for x in res.values()]

```

