# LeetCode: 353. 贪吃蛇

[TOC]

## 1、题目描述

请你设计一个 [贪吃蛇游戏](https://baike.baidu.com/item/%E8%B4%AA%E5%90%83%E8%9B%87/9510203?fr=aladdin)，该游戏将会在一个 屏幕尺寸 = 宽度 x 高度 的屏幕上运行。如果你不熟悉这个游戏，可以 点击这里 [在线试玩](http://patorjk.com/games/snake/)。

起初时，蛇在左上角的 `(0, 0)` 位置，身体长度为 `1` 个单位。

你将会被给出一个 (行, 列) 形式的食物位置序列。当蛇吃到食物时，身子的长度会增加 `1` 个单位，得分也会 `+1`。

食物不会同时出现，会按列表的顺序逐一显示在屏幕上。比方讲，第一个食物被蛇吃掉后，第二个食物才会出现。

当一个食物在屏幕上出现时，它被保证不能出现在被蛇身体占据的格子里。

对于每个 `move()` 操作，你需要返回当前得分或 `-1`（表示蛇与自己身体或墙相撞，意味游戏结束）。

**示例：**

```
给定 width = 3, height = 2, 食物序列为 food = [[1,2],[0,1]]。

Snake snake = new Snake(width, height, food);

初始时，蛇的位置在 (0,0) 且第一个食物在 (1,2)。

|S| | |
| | |F|

snake.move("R"); -> 函数返回 0

| |S| |
| | |F|

snake.move("D"); -> 函数返回 0

| | | |
| |S|F|

snake.move("R"); -> 函数返回 1 (蛇吃掉了第一个食物，同时第二个食物出现在位置 (0,1))

| |F| |
| |S|S|

snake.move("U"); -> 函数返回 1

| |F|S|
| | |S|

snake.move("L"); -> 函数返回 2 (蛇吃掉了第二个食物)

| |S|S|
| | |S|

snake.move("U"); -> 函数返回 -1 (蛇与边界相撞，游戏结束)


```



## 2、解题思路

-   使用队列保存蛇的身体
-   每次判断前进的步伐是否还在屏幕上面
-   如果还有食物，判断能否吃到食物
-   如果没有食物或不能吃到食物，蛇需要前进，将尾部节点移除，然后判断下一个节点能否撞到身体，撞到则返回`-1`
-   将下一个节点加入蛇的身体

这里判断的关键点在于，先移除蛇的尾部，再判断蛇头会不会撞到

```python
from collections import deque


class SnakeGame:

    def __init__(self, width: int, height: int, food: List[List[int]]):
        """
        Initialize your data structure here.
        @param width - screen width
        @param height - screen height
        @param food - A list of food positions
        E.g food = [[1,1], [1,0]] means the first food is positioned at [1,1], the second is at [1,0].
        """
        self.row = height
        self.col = width
        self.food = food
        self.food_pos = 0
        self.snake = deque([(0, 0)])
        self.snake_set = {(0, 0), }

    def move(self, direction: str) -> int:
        """
        Moves the snake.
        @param direction - 'U' = Up, 'L' = Left, 'R' = Right, 'D' = Down
        @return The game's score after the move. Return -1 if game over.
        Game over when snake crosses the screen boundary or bites its body.
        """

        # 坐标验证
        def available(m, n):
            return 0 <= m < self.row and 0 <= n < self.col

        snake_head = self.snake[-1]
        next_pos = [-1, -1]

        if direction == "U":
            next_pos = [snake_head[0] - 1, snake_head[1]]
        elif direction == "D":
            next_pos = [snake_head[0] + 1, snake_head[1]]
        elif direction == "L":
            next_pos = [snake_head[0], snake_head[1] - 1]
        elif direction == "R":
            next_pos = [snake_head[0], snake_head[1] + 1]

        if not available(*next_pos):
            return -1

        # eat food ?
        if self.food_pos < len(self.food) and next_pos == self.food[self.food_pos]:
            self.food_pos += 1
        else:
            self.snake_set.remove(self.snake.popleft())

        if tuple(next_pos) in self.snake_set:
            return -1

        self.snake.append((next_pos[0], next_pos[1]))
        self.snake_set.add((next_pos[0], next_pos[1]))

        return self.food_pos
# Your SnakeGame object will be instantiated and called as such:
# obj = SnakeGame(width, height, food)
# param_1 = obj.move(direction)
```

