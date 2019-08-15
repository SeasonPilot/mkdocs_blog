# L-回文数

[TOC]

## 1、题目描述

若一个数（首位不为零）从左向右读与从右向左读都一样，我们就将其称之为回文数。

例如：给定一个10进制数56，将56加56（即把56从右向左读），得到121是一个回文数。

又如：对于10进制数87：

`STEP1：87+78  = 165                  STEP2：165+561 = 726`

`STEP3：726+627 = 1353                STEP4：1353+3531 = 4884`

在这里的一步是指进行了一次N进制的加法，上例最少用了4步得到回文数4884。

写一个程序，给定一个N（2<=N<=10，N=16）进制数M，求最少经过几步可以得到回文数。如果在30步以内（包含30步）不可能得到回文数，则输出“Impossible！”

[链接](https://ac.nowcoder.com/acm/contest/1071/L)

### 输入描述:

```
两行，分别是N，M。
```

### 输出描述:

```
STEP=ans(ans表示答案)
```

### 示例1

#### 输入

```
9
87
```

#### 输出

```
STEP=6
```

## 2、解题思路

- 不断叠加判断回文即可



```
python 3.5.2
```

```python
def num_to_n_scale(n, x):

    buff = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 'A', 'B', 'C', 'D', 'E', 'F']
    b = []
    x = int(x)
    while True:
        s = n // x
        y = n % x
        b.append(buff[y])
        if s == 0:
            break
        n = s
    return "".join(reversed(b))


def judge_palindrome(num):
    temp = str(num)
    N = len(temp)
    center = 0
    half = N // 2
    if N % 2:
        center = temp[half]

    if center:
        return temp[:half] == "".join(reversed(temp[(half + 1):]))
    else:
        return temp[:half] == "".join(reversed(temp[half:]))


def solve(num, scale):
    flag = False

    if judge_palindrome(num):
        flag = True
        print("STEP=" + str(0))
    else:
        temp = num
        for i in range(1, 31):
            temp = int(temp, scale) + int("".join(reversed(temp)), scale)
            temp = num_to_n_scale(temp, scale)
            if judge_palindrome(temp):
                flag = True
                print("STEP=" + str(i))
                break

    if not flag:
        print("Impossible!")


import sys

s = int(sys.stdin.readline().strip())
n = sys.stdin.readline().strip().upper()
solve(n,s)
```



```
python 2.7.3
```

```python
def num_to_n_scale(n, x):

    buff = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 'A', 'B', 'C', 'D', 'E', 'F']
    b = []
    x = int(x)
    while True:
        s = n // x
        y = n % x
        b.append(buff[y])
        if s == 0:
            break
        n = s
    b.reverse()
    return "".join(b)


def judge_palindrome(num):
    temp = str(num)
    N = len(temp)
    center = 0
    half = N // 2
    if N % 2:
        center = temp[half]

    if center:
        return num[:half] == "".join(reversed(temp[half + 1:]))
    else:
        return temp[:half] == "".join(reversed(temp[half:]))

    
import sys

scale = int(sys.stdin.readline().strip())
num = sys.stdin.readline().strip().upper()


flag = False

if judge_palindrome(num):
    flag = True
    print("STEP=" + str(0))
else:
    temp = num
    for i in range(1, 31):
        temp = int(temp, scale) + int("".join(reversed(temp)), scale)
        temp = num_to_n_scale(temp, scale)
        if judge_palindrome(temp):
            flag = True
            print("STEP=" + str(i))
            break

if not flag:
    print("Impossible!")

```

