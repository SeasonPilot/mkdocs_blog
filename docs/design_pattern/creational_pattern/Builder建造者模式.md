# Builder建造者模式

[TOC]

## 1、简介

建造者模式`(Builder Pattern)`，是将一个复杂的对象的**构建**与它的**表示**分离，使同样的构建过程可以创建不同的表示。创建者模式隐藏了复杂对象的创建过程，它把复杂对象的创建过程加以抽象，通过子类继承或者重载的方式，动态的创建具有复合属性的对象。

-   初始化对象参数很多，并且有很多默认值
-   隔离复杂对象的创建和使用，相同的方法，不同执行顺序
-   需要生成的产品对象有复杂的内部结构，这些产品对象具备共性

建造者模式不适合创建差异化很大的对象，如果对象的构造参数很少，或者没有默认值必须显示指定的时候，应避免使用此模式


​    

## 2、模式说明

**背景：**

-   生成`html`页面的表单项，表单可能包含输入框，复选框，按钮等等



### 2.1 简单生成

```python
def generate_web_form(filed_list):
    generated_fields = "\n".join(
        map(
            lambda x: '<br><input type="text" name="{0}"></br>'.format(x),
            filed_list
        )
    )
    return "<form>{fields}</form>".format(fields=generated_fields)


if __name__ == "__main__":
    fields = ["name", "age", "email", "telephone"]
    print(generate_web_form(fields))
    
```

```
<form><br><input type="text" name="name"></br>
<br><input type="text" name="age"></br>
<br><input type="text" name="email"></br>
<br><input type="text" name="telephone"></br></form>
```

如上所示，通过一个生成函数，就能简单的生成输入框，如果想要自定义字段的话，就无法做到

### 2.2 自定义字段输入

上面的代码可以通过添加`checkbox`的代码来增加，但是并不能处理超出默认值和字段名称的任何信息的字段，下面通过添加字段解析来控制

```python
class HtmlFields:
    def __init__(self, **kwargs):
        self.html = ""

        if kwargs["field_type"] == "text_field":
            self.html = self.construct_text_fields(
                kwargs["label"],
                kwargs["field_name"]
            )
        elif kwargs["field_type"] == "checkbox":
            self.html = self.construct_checkbox(
                kwargs["field_id"],
                kwargs["value"],
                kwargs["label"]
            )

    def construct_text_fields(self, label, field_name):
        return '{0}:<br><input type="text" name="{1}"><br>'.format(
            label,
            field_name
        )

    def construct_checkbox(self, field_id, value, label):
        return '<input type="checkbox" id="{0}" value="{1}">{2}<br>'.format(
            field_id,
            value,
            label
        )

    def __str__(self):
        return self.html


def generate_webform(field_dict_list):
    generated_field_list = []
    for fields in field_dict_list:
        try:
            generated_field_list.append(str(HtmlFields(**fields)))
        except Exception as e:
            print("error : {}".format(e))
    generated_fields = "\n".join(generated_field_list)
    return "<form>{fields}</form>".format(fields=generated_fields)


def build_html_form(field_list):
    with open("form_file.html", 'w') as f:
        f.write(
            "<html><body>{}</body></html>".format(generate_webform(field_list))
        )


if __name__ == "__main__":
    field_list = [
        {
            "field_type": "text_field",
            "label": "first text input",
            "field_name": "field one",
        },
        {
            "field_type": "checkbox",
            "field_id": "check_it",
            "value": "1",
            "label": "check on",
        },
        {
            "field_type": "text_field",
            "label": "second text input",
            "field_name": "field two",
        },
    ]
    build_html_form(field_list)

```

```html
<html><body><form>first text input:<br><input type="text" name="field one"><br>
<input type="checkbox" id="check_it" value="1">check on<br>
second text input:<br><input type="text" name="field two"><br></form></body></html>
```

输出如上，不过上面的这种方式对每一个可选参数，都需要另一个构造函数，因此代码会很快的分解为很多的构造函数，这种通常称为**重叠构造函数反模式**

反模式是设计模式的对立面，通常是绕过或者尝试解决特定类型问题的常用方式，是一种错误的解决问题的方式，重叠构造反模式的问题在于，它产生了几个构造函数，每个都有一定的参数，参数委托给一个默认的构造函数；



### 2.3 建造者模式

建造者模式不会有很多构造函数，建造者模式主要有两个角色，`Builder`和`Director`

-   `Builder`是一个抽象类，知道如何苟安最终对象的所有组成部分
-   `Director`控制着构造过程，`Director`会使用`Builder`的实例进行构建，实现一组指令



```python
from abc import ABCMeta, abstractmethod


class Director(metaclass=ABCMeta):
    def __init__(self):
        self._builder = None

    def set_builder(self, builder):
        self._builder = builder

    @abstractmethod
    def construct(self, field_list):
        pass

    def get_construct_object(self):
        return self._builder.constructed_object


class AbstractFormBuilder(metaclass=ABCMeta):
    def __init__(self):
        self.constructed_object = None

    @abstractmethod
    def add_text_field(self, field_dict):
        pass

    @abstractmethod
    def add_checkbox(self, checkbox_dict):
        pass

    @abstractmethod
    def add_button(self, button_dict):
        pass


class HtmlForm:
    def __init__(self):
        self.field_list = []

    def __repr__(self):
        return "<form>{}</form>".format("".join(self.field_list))


class HtmlFormBuilder(AbstractFormBuilder):
    def __init__(self):
        super().__init__()
        self.constructed_object = HtmlForm()

    def add_text_field(self, field_dict):
        self.constructed_object.field_list.append(
            '{0}:<br><input type="text" name="{1}"><br>'.format(
                field_dict["label"],
                field_dict["field_name"],
            )
        )

    def add_checkbox(self, checkbox_dict):
        self.constructed_object.field_list.append(
            '<input type="checkbox" id="{0}" value="{1}">{2}<br>'.format(
                checkbox_dict["field_id"],
                checkbox_dict["value"],
                checkbox_dict["label"],
            )
        )

    def add_button(self, button_dict):
        self.constructed_object.field_list.append(
            '<button type="button">{}</button>'.format(
                button_dict["text"],
            )
        )


class FormDirector(Director):
    def __init__(self):
        super().__init__()

    def construct(self, field_list):
        for field in field_list:
            if field["field_type"] == "text_field":
                self._builder.add_text_field(field)
            elif field["field_type"] == "checkbox":
                self._builder.add_checkbox(field)
            elif field["field_type"] == "button":
                self._builder.add_button(field)


if __name__ == "__main__":
    field_list = [
        {
            "field_type": "text_field",
            "label": "first text input",
            "field_name": "field one",
        },
        {
            "field_type": "checkbox",
            "field_id": "check_it",
            "value": "1",
            "label": "check on",
        },
        {
            "field_type": "text_field",
            "label": "second text input",
            "field_name": "field two",
        },
        {
            "field_type": "button",
            "text": "Done",
        },
    ]
    director = FormDirector()
    html_form_builder = HtmlFormBuilder()
    director.set_builder(html_form_builder)
    director.construct(field_list)
    with open("form_file.html", 'w') as f:
        f.write(
            "<html><body>{}</body></html>".format(director.get_construct_object())
        )

```

```html
<html><body><form>first text input:<br><input type="text" name="field one"><br><input type="checkbox" id="check_it" value="1">check on<br>second text input:<br><input type="text" name="field two"><br><button type="button">Done</button></form></body></html>
```

