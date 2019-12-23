# Factory工厂模式

[TOC]

## 1、简介

工厂模式`(Factory Pattern)`时最常用的设计模式之一，在创建对象时不会对客户端暴露创建逻辑，并且是通过使用一个共同的接口来指向新创建的对象。

例如，当我们制作一个简单的游戏的时候，有很多种形状需要管理，长方形，圆形，三角形等等，一般的，这些形状可能是散乱的，使用工厂模式，将这些散乱的接口统一起来，形状的创建进行统一的管理，并且避免了对外暴露逻辑，而且对于某种形状的统一操作，例如创建之前的数据库查询，也进行了统一操作



## 2、代码实现

### 2.1 静态方法

```python
import pygame


class Shape:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def draw(self):
        raise NotImplementedError()

    @staticmethod
    def factory(shape_type):
        if shape_type == "circle":
            return Circle(100, 100)
        if shape_type == "square":
            return Square(100, 100)
        assert 0, "Bad shape type: " + shape_type

    def move(self, direction):
        if direction == "up":
            self.y -= 4
        elif direction == "down":
            self.y += 4
        elif direction == "left":
            self.x -= 4
        elif direction == "right":
            self.x += 4


class Square(Shape):
    def draw(self):
        pygame.draw.rect(
            screen,
            (255, 255, 0),
            pygame.Rect(self.x, self.y, 20, 20)
        )


class Circle(Shape):
    def draw(self):
        pygame.draw.circle(
            screen,
            (0, 255, 255),
            (self.x, self.y),
            10
        )


if __name__ == "__main__":
    windows_dimensions = 800, 600
    screen = pygame.display.set_mode(windows_dimensions)
    square = Shape.factory("square")
    obj = square

    player_quits = False
    while not player_quits:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                player_quits = True
        pressed = pygame.key.get_pressed()
        if pressed[pygame.K_UP]:
            obj.move("up")
        if pressed[pygame.K_DOWN]:
            obj.move("down")
        if pressed[pygame.K_LEFT]:
            obj.move("left")
        if pressed[pygame.K_RIGHT]:
            obj.move("right")
        screen.fill((0, 0, 0))
        obj.draw()
        pygame.display.flip()

```

如上所示，创建的时候，通过`Shape`的静态函数来创建，如果新增，则需要在这里加入新的类型



### 2.2 抽象工厂

```python
from abc import ABCMeta, abstractmethod
import pygame


class Shape:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def draw(self):
        raise NotImplementedError()

    def move(self, direction):
        if direction == "up":
            self.y -= 4
        elif direction == "down":
            self.y += 4
        elif direction == "left":
            self.x -= 4
        elif direction == "right":
            self.x += 4


class Square(Shape):
    def draw(self):
        pygame.draw.rect(
            screen,
            (255, 255, 0),
            pygame.Rect(self.x, self.y, 20, 20)
        )


class Circle(Shape):
    def draw(self):
        pygame.draw.circle(
            screen,
            (0, 255, 255),
            (self.x, self.y),
            10
        )


class AbstractFactory(metaclass=ABCMeta):
    @abstractmethod
    def make_object(self):
        return


class CircleFactory(AbstractFactory):
    def make_object(self):
        return Circle(100, 100)


class SquareFactory(AbstractFactory):
    def make_object(self):
        return Square(100, 100)


if __name__ == "__main__":
    windows_dimensions = 800, 600
    screen = pygame.display.set_mode(windows_dimensions)
    square_factory = SquareFactory()
    square = square_factory.make_object()
    obj = square

    player_quits = False
    while not player_quits:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                player_quits = True
        pressed = pygame.key.get_pressed()
        if pressed[pygame.K_UP]:
            obj.move("up")
        if pressed[pygame.K_DOWN]:
            obj.move("down")
        if pressed[pygame.K_LEFT]:
            obj.move("left")
        if pressed[pygame.K_RIGHT]:
            obj.move("right")
        screen.fill((0, 0, 0))
        obj.draw()
        pygame.display.flip()

```

如上所示，将圆形和方形的创建，各自有一个工厂，可以分别对方形进行定制化创建，创建的接口被统一起来。



