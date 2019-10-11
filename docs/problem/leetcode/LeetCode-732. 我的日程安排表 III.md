# LeetCode: 732. 我的日程安排表 III

[TOC]

## 1、题目描述

实现一个 `MyCalendar` 类来存放你的日程安排，你可以一直添加新的日程安排。

`MyCalendar` 有一个 `book(int start, int end)`方法。它意味着在`start`到`end`时间内增加一个日程安排，注意，这里的时间是半开区间，即 `[start, end)`, 实数 `x` 的范围为，  `start <= x < end`。

当 `K` 个日程安排有一些时间上的交叉时（例如`K`个日程安排都在同一时间内），就会产生 `K` 次预订。

每次调用 `MyCalendar.book`方法时，返回一个整数 `K` ，表示最大的 `K` 次预订。

请按照以下步骤调用`MyCalendar` 类: `MyCalendar cal = new MyCalendar(); MyCalendar.book(start, end)`

**示例 1:**

```
MyCalendarThree();
MyCalendarThree.book(10, 20); // returns 1
MyCalendarThree.book(50, 60); // returns 1
MyCalendarThree.book(10, 40); // returns 2
MyCalendarThree.book(5, 15); // returns 3
MyCalendarThree.book(5, 10); // returns 3
MyCalendarThree.book(25, 55); // returns 3
解释: 
前两个日程安排可以预订并且不相交，所以最大的K次预订是1。
第三个日程安排[10,40]与第一个日程安排相交，最高的K次预订为2。
其余的日程安排的最高K次预订仅为3。
请注意，最后一次日程安排可能会导致局部最高K次预订为2，但答案仍然是3，原因是从开始到最后，时间[10,20]，[10,40]和[5,15]仍然会导致3次预订。
```

**说明:**

-   `每个测试用例，调用 MyCalendar.book 函数最多不超过 400次。`
-   `调用函数 MyCalendar.book(start, end)时， start 和 end 的取值范围为 [0, 10^9]。`



## 2、解题思路

-   有序数组分割法

设置两个数组分别保存区间的起点与终点，这里采用的是闭区间

设置一个对应位置的数组，保存当前区间的覆盖次数



-   当拿到一个新的区间的时候，首先判断一下，是否有重叠区域
    -   不存在，直接插入新的区间，并插入覆盖次数1
    -   存在重叠

重叠区域与前面区间一共有下面几种：

1、重叠区间刚好能够覆盖前面相邻的区间

直接更新区间的覆盖值

```
+----------------------------------------------+
|                                              |
+----------------------------------------------+
|**********************************************|
|**********************************************|
|**********************************************|
|**********************************************|
|**********************************************|
+----------------------------------------------+
|                                              |
+----------------------------------------------+
```

2、重叠部分覆盖前面的左部

-   将原来区域切分成两部分

设原来区间的预订值为`book_num`

左部分的预定值为`book_num+1`

右部分的预定值为`book_num`

```
+----------------------------------------------+
|                                              |
+----------------------------+                 |
|****************************|                 |
|****************************|                 |
|****************************|                 |
|****************************|                 |
|****************************|                 |
+----------------------------+                 |
|                                              |
+----------------------------------------------+
```

3、重叠部分覆盖右部

-   将原来区域切分成两部分

设原来区间的预订值为`book_num`

左部分的预定值为`book_num`

右部分的预定值为`book_num+1`

```
+----------------------------------------------+
|                                              |
|                 +----------------------------+
|                 |****************************|
|                 |****************************|
|                 |****************************|
|                 |****************************|
|                 |****************************|
|                 +----------------------------+
|                                              |
+----------------------------------------------+
```

4、重叠部分覆盖中间一块区域

-   将原来的区间切分成左中右3部分

设原来区间的预订值为`book_num`

左部分的预定值为`book_num`

中部分的预定值为`book_num+1`

右部分的预定值为`book_num`

```
+----------------------------------------------+
|                                              |
|        +--------------------------+          |
|        |**************************|          |
|        |**************************|          |
|        |**************************|          |
|        |**************************|          |
|        |**************************|          |
|        +--------------------------+          |
|                                              |
+----------------------------------------------+
```



除此以外，考虑左右方超出范围的部分：

右方超出范围：

```
+----------------------------------------------+                      
|                                              |                      
|                                              +---------------------+
|                                              |*********************|
|                                              |*********************|
|                                              |*********************|
|                                              |*********************|
|                                              |*********************|
|                                              +---------------------+
|                                              |                      
+----------------------------------------------+                      
```

左方超出范围：

```
                      +----------------------------------------------+
                      |                                              |
+---------------------+                                              |
|*********************|                                              |
|*********************|                                              |
|*********************|                                              |
|*********************|                                              |
|*********************|                                              |
+---------------------+                                              |
                      |                                              |
                      +----------------------------------------------+
```



超出部分递归更新即可



代码实例：

```python
from bisect import bisect_right


class MyCalendarThree:

    def __init__(self):
        self.starts = []
        self.ends = []

        self.book_num = []
        self.max_book_num = 1

    def update(self, start, end):
        index = bisect_right(self.starts, end)
        if index == 0 or self.ends[index - 1] < start:
            self.starts.insert(index, start)
            self.ends.insert(index, end)
            self.book_num.insert(index, 1)
        else:
            pre_left, pre_right = self.starts[index - 1], self.ends[index - 1]
            overlap_left = max(start, pre_left)
            overlap_right = min(end, pre_right)

            current_book_num = self.book_num[index - 1]
            if overlap_left == pre_left and overlap_right == pre_right:
                self.book_num[index - 1] += 1
            elif overlap_left == pre_left and overlap_right < pre_right:
                # 分割两部分
                self.ends[index - 1] = overlap_right
                self.book_num[index - 1] += 1
                self.starts.insert(index, overlap_right + 1)
                self.ends.insert(index, pre_right)
                self.book_num.insert(index, current_book_num)

            elif overlap_right == pre_right and overlap_left > pre_left:
                # 分割两部分
                self.ends[index - 1] = overlap_left - 1
                self.starts.insert(index, overlap_left)
                self.ends.insert(index, pre_right)
                self.book_num.insert(index, current_book_num + 1)

            elif overlap_left > pre_left and overlap_right < pre_right:
                # 修改右侧部分
                self.starts[index - 1] = overlap_right + 1
                # 添加中间覆盖部分
                self.starts.insert(index - 1, overlap_left)
                self.ends.insert(index - 1, overlap_right)
                self.book_num.insert(index - 1, current_book_num + 1)
                # 添加左侧部分
                self.starts.insert(index - 1, pre_left)
                self.ends.insert(index - 1, overlap_left - 1)
                self.book_num.insert(index - 1, current_book_num)

            self.max_book_num = max(self.max_book_num, current_book_num + 1)

            if end > pre_right:
                self.update(pre_right + 1, end)
            if start < pre_left:
                self.update(start, pre_left - 1)

    def book(self, start: int, end: int) -> int:
        self.update(start, end - 1)
        return self.max_book_num

    # Your MyCalendarThree object will be instantiated and called as such:

# obj = MyCalendarThree()
# param_1 = obj.book(start,end)

```

