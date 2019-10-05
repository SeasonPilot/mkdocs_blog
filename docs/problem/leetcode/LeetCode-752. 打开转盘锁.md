# LeetCode: 752. 打开转盘锁

[TOC]

## 1、题目描述

你有一个带有四个圆形拨轮的转盘锁。每个拨轮都有`10`个数字： `'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'` 。每个拨轮可以自由旋转：例如把 `'9'` 变为  `'0'`，`'0'` 变为 `'9'` 。每次旋转都只能旋转一个拨轮的一位数字。

锁的初始数字为 `'0000'` ，一个代表四个拨轮的数字的字符串。

列表 `deadends` 包含了一组死亡数字，一旦拨轮的数字和列表里的任何一个元素相同，这个锁将会被永久锁定，无法再被旋转。

字符串 `target` 代表可以解锁的数字，你需要给出最小的旋转次数，如果无论如何不能解锁，返回 `-1`。

 

**示例 1:**

```
输入：deadends = ["0201","0101","0102","1212","2002"], target = "0202"
输出：6
解释：
可能的移动序列为 "0000" -> "1000" -> "1100" -> "1200" -> "1201" -> "1202" -> "0202"。
注意 "0000" -> "0001" -> "0002" -> "0102" -> "0202" 这样的序列是不能解锁的，
因为当拨动到 "0102" 时这个锁就会被锁定。
```


**示例 2:**

```
输入: deadends = ["8888"], target = "0009"
输出：1
解释：
把最后一位反向旋转一次即可 "0000" -> "0009"。
```


**示例 3:**

```
输入: deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"], target = "8888"
输出：-1
解释：
无法旋转到目标数字且不被锁定。
```


**示例 4:**

```
输入: deadends = ["0000"], target = "8888"
输出：-1
```

**提示：**

-   死亡列表 `deadends` 的长度范围为 `[1, 500]`。
-   目标数字 `target` 不会在 `deadends` 之中。
-   每个 `deadends` 和 `target` 中的字符串的数字会在 `10,000` 个可能的情况 `'0000'` 到 `'9999'` 中产生。



## 2、解题思路

-   BFS 广度优先搜索

-   每个状态都有8个状态可选，设置一个记录访问过的集合



```python
class Solution:
    def openLock(self, deadends: List[str], target: str) -> int:
        dead_set = set(deadends)
        if "0000" in dead_set:
            return -1

        appear = {"0000", }

        def next_status(stat):
            temp = list(stat)
            for i in range(4):
                yield "".join(temp[:i] + [str((int(temp[i]) + 9) % 10)] + temp[i + 1:])
                yield "".join(temp[:i] + [str((int(temp[i]) + 11) % 10)] + temp[i + 1:])

        ans = -1
        cur = ["0000"]
        step = 0
        find = False
        while not find and cur:
            temp_next = []
            for n in cur:
                if n == target:
                    ans = step
                    find = True
                    break
                if not find:
                    for nex in next_status(n):
                        if nex not in dead_set and nex not in appear:
                            appear.add(nex)
                            temp_next.append(nex)
            cur = temp_next
            step += 1
        return ans
```

