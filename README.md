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
* 重新用PostScript绘制中大logo
* 继续深度修改使更和谐易用
