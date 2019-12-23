# 进击的技术

本站主要对一些技术做分享，类目如下

  - 编程语言
  - 计算机
  - 机器学习
  - 项目集锦
  - 算法与数据结构
  - 设计模式
  - 算法题集
  - 常用工具



## 工具

工具主要是基于 [mkdocs.org](https://mkdocs.org)，详情参见具体链接.

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs help` - Print this help message.

## 新建项目

    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.



## Latex公式支持

[Latex公式语法参考](https://en.wikibooks.org/wiki/LaTeX/Mathematics)

[Latex公式在线编辑器](http://latex.codecogs.com/eqneditor/editor.php)



```
$$
\frac{1}{2}
$$
```


$$
\frac{1}{2}
$$

## 时序图支持

相关支持参见[链接](https://facelessuser.github.io/pymdown-extensions/extensions/superfences/)；

```
Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```

```sequence

Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```



## 流程图支持

相关支持参见[链接](https://facelessuser.github.io/pymdown-extensions/extensions/superfences/)；

```
st=>start: Start
op=>operation: Your Operation
cond=>condition: Yes or No?
e=>end

st->op->cond
cond(yes)->e
cond(no)->op
```


```flow
st=>start: Start
op=>operation: Your Operation
cond=>condition: Yes or No?
e=>end

st->op->cond
cond(yes)->e
cond(no)->op
```



## UML支持

​	基于mermaid，参见[相关链接](https://github.com/knsv/mermaid)；


```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
