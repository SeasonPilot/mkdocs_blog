# LeetCode: 282. 给表达式添加运算符

[TOC]

## 1、题目描述

给定一个仅包含数字 `0-9` 的字符串和一个目标值，在数字之间添加二元运算符（不是一元）`+`、`-` 或 `*` ，返回所有能够得到目标值的表达式。

**示例 1:**

```
输入: num = "123", target = 6
输出: ["1+2+3", "1*2*3"] 
```


**示例 2:**

```
输入: num = "232", target = 8
输出: ["2*3+2", "2+3*2"]
```


**示例 3:**

```
输入: num = "105", target = 5
输出: ["1*0+5","10-5"]
```


**示例 4:**

```
输入: num = "00", target = 0
输出: ["0+0", "0-0", "0*0"]
```


**示例 5:**

```
输入: num = "3456237490", target = 9191
输出: []
```



## 2、解题思路

-   回溯法
-   从前向后找出所有可能的排列并计算表达式的值
-   需要针对`0`进行处理，`0`不能最为多位数字的开头
-   针对乘法`*`做特殊处理，需要记住前面的那个值，这样才能够计算正确的表达式的值



```python
class Solution:
    def addOperators(self, num: str, target: int) -> List[str]:
        length = len(num)
        ans = []

        def calculate(pos, expressions, pre_sum, pre_num):
            if pos == length:
                if pre_sum == target:
                    ans.append(expressions)
            else:
                for i in range(pos, pos + 1 if num[pos] == "0" else len(num)):

                    current = num[pos:i + 1]
                    current_val = int(current)

                    if expressions:
                        calculate(i + 1, expressions + "+" + current, pre_sum + current_val, current_val)
                        calculate(i + 1, expressions + "-" + current, pre_sum - current_val, -current_val)
                        calculate(i + 1, expressions + "*" + current, pre_sum - pre_num + pre_num * current_val,
                                  pre_num * current_val)
                    else:
                        calculate(i + 1, current, current_val, current_val)

        calculate(0, "", 0, 0)
        return ans
```

