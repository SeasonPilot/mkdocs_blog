# Python文档转换：pandoc

[TOC]



## 1、安装

1.安装pandoc程序

传送门：https://github.com/jgm/pandoc/releases/tag/1.19.2.1



## 2、安装pypandoc

```
pip install pypandoc
```

 

**使用**

-   将md文件转化为html文件：

```python
# -*- coding: utf-8 -*-
#
def trans():
    """
    转化文件的格式。
    convert(source, to, format=None, extra_args=(), encoding='utf-8', outputfile=None, filters=None)
    parameter-
        source：源文件
        to：目标文件的格式，比如html、rst、md等
        format：源文件的格式，比如html、rst、md等。默认为None，则会自动检测
        encoding：指定编码集
        outputfile：目标文件，比如test.html（注意outputfile的后缀要和to一致）
    """
    try:
        import pypandoc
        return pypandoc.convert('README.md', 'html', format='md',outputfile='1.html')
    except (IOError, ImportError):
        with open('README.md') as f:
            return f.read()
trans()
```

-    在cmd中执行

```
python test.py
```

之后在md文件所在目录就会创建一个1.html文件。

实际上，`pypandoc`就是对`pandoc`的一个封装，pandoc的源码是基于`haskell`函数编程的，因此在在使用之前需要安装`pandoc`，因此，通过`shell`脚本也能完成类似的工作



## 3、格式说明

**from：**

```markdown
commonmark (CommonMark Markdown)
creole (Creole 1.0)
docbook (DocBook)
docx (Word docx)
dokuwiki (DokuWiki markup)
epub (EPUB)
fb2 (FictionBook2 e-book)
gfm (GitHub-Flavored Markdown), or the deprecated and less accurate markdown_github; use markdown_github only if you need extensions not supported in gfm.
haddock (Haddock markup)
html (HTML)
ipynb (Jupyter notebook)
jats (JATS XML)
json (JSON version of native AST)
latex (LaTeX)
markdown (Pandoc’s Markdown)
markdown_mmd (MultiMarkdown)
markdown_phpextra (PHP Markdown Extra)
markdown_strict (original unextended Markdown)
mediawiki (MediaWiki markup)
man (roff man)
muse (Muse)
native (native Haskell)
odt (ODT)
opml (OPML)
org (Emacs Org mode)
rst (reStructuredText)
t2t (txt2tags)
textile (Textile)
tikiwiki (TikiWiki markup)
twiki (TWiki markup)
vimwiki (Vimwiki)
```

**to：**

```markdown
asciidoc (AsciiDoc) or asciidoctor (AsciiDoctor)
beamer (LaTeX beamer slide show)
commonmark (CommonMark Markdown)
context (ConTeXt)
docbook or docbook4 (DocBook 4)
docbook5 (DocBook 5)
docx (Word docx)
dokuwiki (DokuWiki markup)
epub or epub3 (EPUB v3 book)
epub2 (EPUB v2)
fb2 (FictionBook2 e-book)
gfm (GitHub-Flavored Markdown), or the deprecated and less accurate markdown_github; use markdown_github only if you need extensions not supported in gfm.
haddock (Haddock markup)
html or html5 (HTML, i.e. HTML5/XHTML polyglot markup)
html4 (XHTML 1.0 Transitional)
icml (InDesign ICML)
ipynb (Jupyter notebook)
jats (JATS XML)
jira (Jira wiki markup)
json (JSON version of native AST)
latex (LaTeX)
man (roff man)
markdown (Pandoc’s Markdown)
markdown_mmd (MultiMarkdown)
markdown_phpextra (PHP Markdown Extra)
markdown_strict (original unextended Markdown)
mediawiki (MediaWiki markup)
ms (roff ms)
muse (Muse),
native (native Haskell),
odt (OpenOffice text document)
opml (OPML)
opendocument (OpenDocument)
org (Emacs Org mode)
plain (plain text),
pptx (PowerPoint slide show)
rst (reStructuredText)
rtf (Rich Text Format)
texinfo (GNU Texinfo)
textile (Textile)
slideous (Slideous HTML and JavaScript slide show)
slidy (Slidy HTML and JavaScript slide show)
dzslides (DZSlides HTML5 + JavaScript slide show),
revealjs (reveal.js HTML5 + JavaScript slide show)
s5 (S5 HTML and JavaScript slide show)
tei (TEI Simple)
xwiki (XWiki markup)
zimwiki (ZimWiki markup)
```



## 4、参考链接

-   https://github.com/bebraw/pypandoc
-   https://github.com/jgm/pandoc

