# LeetCode: 577. 员工奖金

[TOC]

## 1、题目描述

选出所有 bonus < 1000 的员工的 name 及其 bonus。

Employee 表单



```
+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
empId 是这张表单的主关键字
```

Bonus 表单

```
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
empId 是这张表单的主关键字
```


输出示例：

```
+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+
```



## 2、解题思路

```sql
# Write your MySQL query statement below


select 
    name, bonus 
from 
    Employee as e left join Bonus as b on ( e.empId = b.empId )
    
where b.bonus <1000 or b.bonus is null;
```

