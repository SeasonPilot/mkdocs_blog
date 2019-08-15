# D-Cow Line

[TOC]

## 1、题目描述

Farmer John's N cows (conveniently numbered `1..N`) are forming a line. The line begins with no cows and then, as time progresses, one by one, the cows join the line on the left or right side. Every once in a while, some number of cows on the left or right side of the line all leave the line to go graze in their favorite pasture.

FJ has trouble keeping track of all the cows in the line. Please help him.
The cows enter the line in numerical order `1..N`, and once a cow leaves the line she never re-enters it. Your program will be given S (`1 <= S <= 100,000`) input specifications; each appears on a single line and is one of two types:

`* A cow enters the line (a parameter indicates whether on the left or right).`

`* K cows leave the line from the left or right side (supplied parameters define both the number of cows and which side).`

Input lines never request an operation that can not be performed.

After all the input lines have been processed, your program should print the cows in the line in order from left to right. The final line is guaranteed to be non-empty at the end of the input specifications.



[链接](https://ac.nowcoder.com/acm/contest/1071/D)



### 输入描述:

```
* Line 1: A single integer: S
* Lines 2..S+1: Line i+1 contains specification i in one of four formats:
* A L -- a cow arrives on the Left of the line
* A R -- a cow arrives on the Right of the line
* D L K -- K cows depart the Left side of the line
* D R K -- K cows depart the Right side of the line
```

### 输出描述:

```
* Lines 1..??: Print the numbers of the cows in the line in order from left to right, one number per line.
```

### 示例1

#### 输入

```
10 
A L 
A L 
A R 
A L 
D R 2 
A R 
A R 
D L 1 
A L 
A R 
```

#### 输出

```
7
2
5
6
8
```

### 说明

```
Input    Resulting Cow Line
A L      1
A L      2 1
A R      2 1 3
A L      4 2 1 3
D R 2    4 2
A R      4 2 5
A R      4 2 5 6
D L 1    2 5 6
A L      7 2 5 6
A R      7 2 5 6 8
```



## 2、解题思路

- 直接根据题意进行判断即可



```python
from collections import deque

res = deque([])
total = int(input().strip())
cur_cow = 1
for _ in range(total):
    instruction = input().strip().split()
    if instruction[0] == "A":
        if instruction[1] == "L":
            res.appendleft(cur_cow)
        else:
            res.append(cur_cow)
        cur_cow += 1
    elif instruction[0] == "D":
        if instruction[1] == "L":
            for i in range(int(instruction[2])):
                res.popleft()
        else:
            for i in range(int(instruction[2])):
                res.pop()

for i in res:
    print(i)

```

