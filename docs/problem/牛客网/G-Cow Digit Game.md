# G-Cow Digit Game

[TOC]

```
牛客假日团队赛9
```

## 1、题目描述

Bessie is playing a number game against Farmer John, and she wants you to help her achieve victory.
Game i starts with an integer Ni (1 <= Ni <= 1,000,000). Bessie goes first, and then the two players alternate turns. On each turn, a player can subtract either the largest digit or the smallest non-zero digit from the current number to obtain a new number. For example, from 3014 we may subtract either 1 or 4 to obtain either 3013 or 3010, respectively. The game continues until the number becomes 0, at which point the last player to have taken a turn is the winner.

Bessie and FJ play G (1 <= G <= 100) games. Determine, for each game, whether Bessie or FJ will win, assuming that both play perfectly (that is, on each turn, if the current player has a move that will guarantee his or her win, he or she will take it).

Consider a sample game where Ni = 13. Bessie goes first and takes 3, leaving 10. FJ is forced to take 1, leaving 9. Bessie takes the remainder and wins the game.



[链接](https://ac.nowcoder.com/acm/contest/1071/G)

### 输入描述:

```
* Line 1: A single integer: G
* Lines 2..G+1: Line i+1 contains the single integer: Ni
```

### 输出描述:

```
* Lines 1..G: Line i contains 'YES' if Bessie can win game i, and 'NO' otherwise.
```

### 示例1

#### 输入

```
2 
9 
10 
```

#### 输出

```
YES
NO
```

### 说明

```
For the first game, Bessie simply takes the number 9 and wins. For the second game, Bessie must take 1 (since she cannot take 0), and then FJ can win by taking 9.
```



## 2、解题思路

- 用python超时，用C重写
- 设置大的缓冲数组
- 首先初始值，1-10的值都是已知的
- 然后从11开始，找出数字中最大与最小，x,y
- 如果当前值减去x，减去y中有一个为0，也就是对方输，当前标记为赢，否则标记为赢



```c
#include <stdio.h>


#define MAX_LEN 1000001

int buff[MAX_LEN];


int main() {


    buff[0] = 0;
    int max_value, min_value;
    int temp;
    int remainder;
    for (int i = 1; i < MAX_LEN; i++) {
        max_value = 1;
        min_value = 9;
        temp = i;
        while (temp > 0) {
            remainder = temp % 10;
            if (remainder) {
                max_value = max_value > remainder ? max_value : remainder;
                min_value = min_value < remainder ? min_value : remainder;
            }
            temp /= 10;
        }
        if (max_value == min_value) {
            buff[i] = !buff[i - max_value];
            continue;
        }
        if (buff[i - max_value] == 0 || buff[i - min_value] == 0) {
            buff[i] = 1;
        } else {
            buff[i] = 0;
        }

    }

    int total, num;
    scanf("%d", &total);

    for (int i = 0; i < total; i++) {
        scanf("%d", &num);
        if (buff[num]) {
            printf("YES\n");
        } else {
            printf("NO\n");
        }

    }
    return 0;

}
```

