# LeetCode: 925. 长按键入

[TOC]

## 1、题目描述

你的朋友正在使用键盘输入他的名字 name。偶尔，在键入字符 c 时，按键可能会被长按，而字符可能被输入 1 次或多次。

你将会检查键盘输入的字符 typed。如果它对应的可能是你的朋友的名字（其中一些字符可能被长按），那么就返回 True。

 

```
示例 1：

输入：name = "alex", typed = "aaleex"
输出：true
解释：'alex' 中的 'a' 和 'e' 被长按。
示例 2：

输入：name = "saeed", typed = "ssaaedd"
输出：false
解释：'e' 一定需要被键入两次，但在 typed 的输出中不是这样。
示例 3：

输入：name = "leelee", typed = "lleeelee"
输出：true
示例 4：

输入：name = "laiden", typed = "laiden"
输出：true
解释：长按名字中的字符并不是必要的。

```



**提示：**

- name.length <= 1000
- typed.length <= 1000
- name 和 typed 的字符都是小写字母。



## 2、解题思路



- 设置两个下标，分别对应name和typed匹配到的位置
- 每次截取name相同的字母进行匹配，匹配多个typed相同字母

```python
class Solution:
    def isLongPressedName(self, name: str, typed: str) -> bool:
        if (not name and typed) or (len(name) > len(typed)):
            return False

        name_pos = 0
        type_pos = 0

        while name_pos < len(name):
            temp_pos = name_pos + 1
            while temp_pos < len(name) and name[temp_pos] == name[name_pos]:
                temp_pos += 1

            if not typed[type_pos:].startswith(name[name_pos:temp_pos]):
                return False
            type_pos += temp_pos - name_pos

            while type_pos < len(typed) and typed[type_pos] == name[name_pos]:
                type_pos += 1

            name_pos = temp_pos
        if type_pos >= len(typed):
            return True
        else:
            return False
```



双指针改写

```python
class Solution:
    def isLongPressedName(self, name: str, typed: str) -> bool:
        
        if (not name and typed) or (len(name) > len(typed)):
            return False

        pos_name = 0
        pos_typed = 0

        while pos_name < len(name) and pos_typed < len(typed):
            if name[pos_name] == typed[pos_typed]:
                pos_name += 1
                pos_typed += 1
            else:
                if typed[pos_typed] == name[pos_name - 1]:
                    pos_typed += 1
                else:
                    return False

        if pos_name == len(name):
            if pos_typed == len(typed):
                return True
            else:
                if len(set(typed[pos_typed:])) == 1 and typed[-1] == name[-1]:
                    return True
                else:
                    return False
        else:
            return False
```



