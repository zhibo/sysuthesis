SYSUTHESIS
==========
   
_SYSUTHESIS_ 是基于[PKUTHSS](http://www.ctan.org/pkg/pkuthss "about pkuthss")编写的中山大学论文模板，目前主要是修改了封面，
包括 _本科_ 和 _硕士_ 两个版本，分别在 _bachelor_ 和 _master_ 两个目录。

## 注意 ##

_SYSUTHESIS_ 并不是一个重新实现的模板，因为 _PKUTHSS_ 已经很好的实现了大部分功能。 _SYSUTHESIS_ 针对本校对 `cls` 和 `def` 
文件做了一定的修改以符合学校的要求，这两个修改后的文件也分别放在 _bachelor_ 和 _master_ 中。

## 运行 ##

首先，安装 _pkuthss_:

    tlmgr install pkuthss

然后，在终端执行以下命令可以详细了解 _pkuthss_ :

    texdoc pkuthss
    
获取该 _repo_ :

    git clone git://github.com:zhibo/sysuthesis.git
    
进入需要的版本，如 _bachelor_ :

    cd bachelor
    
修改 **sample.tex** 中的相关个人信息，修改 **chap** 中各章节的内容，然后编译（默认使用 `xelatex` ）:

    make
    
清除中间内容:
   
    make clean

## Tips ##
1. 一些文本内容（如系统输出）可以放入`vervatim`文件夹；
2. 如果不需要每章从奇数页开始（如盲审要求），可以在`pkuthss.cls`中的 **\LoadClass** 参数中添加 _openany_ ：

        \LoadClass[fntef,a4paper,fancyhdr,cs4size,openany]{ctexbook}[2009/10/20]

3. `sample.pdf`文档本身提供了很多帮助（也可通过 _texdoc pkuthss_ 命令查看），可以细读一下，如果仍不能满足要求，可以自定义`pkuthss.cls`和`pkuthss-utf8.def`两个文件；
4. 一个据说不错的[中文LaTeX课程](http://math.ecnu.edu.cn/~latex/ "LaTeX 科技排版")，华东师大出品。
5. 有关中文`biblatex`格式，可参考`pkuthss.bib`中的例子，以及`caspervector`文档（提供了引用 _专利_ 的格式）：
        
        texdoc caspervector


## FAQ ##
1. Windows与Linux某发行版下编译有问题
 * 尚未在 _Win_ 与 _Linux_ 实验过，欢迎补充。目前仅在 _OSX_ 下个人使用，以下提到的问题也是基于 _OSX_。
2. 中文字体有问题
 * [这里](http://kqwd.blog.163.com/blog/static/4122344820117725633776/)提供了中文字体的解决方案，如果需要更多的字体支持（
如：行楷），可以自行下载相关字体安装，并修改相关文件。
3. BEGIN failed--compilation aborted at Biber/Utils.pm line 21
 * 删除相关缓存目录，参考 [这里](http://www.van-porten.de/2012/01/what-to-do-if-biber-stops-working-on-macos-x/ 
"What to do if biber stops working on MacOS X")

## TODO ##
* 重新用PostScript绘制中大logo（已完成，使用了[官方](http://home3.sysu.edu.cn/sysuvi/index.html)矢量图，感谢markh。）
* 继续深度修改使更和谐易用
* 修改论文格式和引用格式使符合[要求](http://graduate.sysu.edu.cn/Item/1880.aspx)
