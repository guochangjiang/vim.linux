# perl-support 修改说明
==========================
## vim perl-support的修改
在vim下写perl代码肯定离不开的就是perl-support这个插件,
我在前面专门说过这个的安装方法,其实如果读vim熟悉了以后,
完全没有了当时的畏惧和不知所措,按照readme自己解决。
我们今天主要说的是，对perl-support中不爽的地方,进行修改

## Table of Contents
* 1 修改规则
* 2 修改1 \i系列
* 2.1 \ii \io
* 2.1.1 修改/.vim/perl-support/templates/idioms.templates
* 2.2
* 3 修改2 \s系列
* 4 修改 templates中的Templates
* 5 
* 常用perl-support快捷键总结

## 1 修改规则
<CURSOR>：代表，使用hot keys以后光标所在的位置。

两个竖中间加上一个名称 :这个是管道的传递名称

==:包含了名称，快捷键等

## 2 修改1 \i系列
\i也就是hot keys中以\i开头的快捷命令

### 2.1 \ii \io
用过perl support的都知道，这两个命令分别是打开'读入'的句柄文件和打开 输出的'句柄'文件。但是你使用以后会发现，这个足足占了8行的地方，这个里面 有很多重复的废话，我们完全可以进行删减，加上open和close 三行是我可以 容忍的。

#### 2.1.1 修改/.vim/perl-support/templates/idioms.templates
经过查看，总算发现是这个文件来控制。这里一共是一个68行的文件。我们要修改 在36行。我们首先来看一些，有那些内容：

```
1:  my $|FILEPOINTER|_file_name = '<CURSOR>';#input file name
2:  
3:  open my $|FILEPOINTER|,'<',$|FILEPOINTER|_file_name
4:  or die "$0": failed to open input file '$|FILEPOINTER|_file_name' "$!\n";
5:  
6:  <SPLIT>{-continue_here-}
7:  close $|FILEPOINTER|
8:  or warn "$0 " failed to close input file '$|FILEPOINTER|_file_name' "$!\n";
```

上面是慢慢的8行内容，你说打开一个输入文件容易吗？每办法，我们完全可以自己精简：

 1:    第一行,my $|FILEPOINTER|_file_name太长了，后面直接用个in表示，当然后面也要改
 2:    第二行删除
 3:    第三行：open my $|FILEPOINTER|,'<',$|FILEPOINTER|_in or die "failed open\n";
 4:    然后到close一行：
 5:    这个close 后面的warn，却是没有遇到过，所以直接把后面的删除
 6:    close $|FILEPOINTER|;
 7:    具体的内容如下：
 8:  
 ```
13: == Idioms.open input file == map:ii, sc:i ==
my	$|?FILEPOINTER|_in = "<CURSOR>";
open  my $|FILEPOINTER|, '<', $|FILEPOINTER|_in or die "Fail open $|FILEPOINTER|_in file\n";
while(my $line=<$|FILEPOINTER|>)
{
		chomp $line;
}

== Idioms.open output file == map:io, sc:o ==
my	$|?FILEPOINTER|_out = "<CURSOR>";
open  my $|FILEPOINTER|, '>', $|FILEPOINTER|_out or die  "Fail open $|FILEPOINTER|_out\n";
close  $|FILEPOINTER|;
```
这里只是根据我自己的喜好来修改的，大家知道怎么修改了以后完全可以自己折腾。 这样就可以了，不用搞的太复杂。让人看起来头晕。


### 2.2添加开头文件
写一个perl程序，一般开头都要写use strict; 等，我们这里的作用就是在添加一点东西，使这部分内容可以通过快捷键添加；
```
== Idioms.begin == map:ib, sc:b, insert ==
use strict;
use warnings;
use 5.16.3;
```
通过上面的设置，当你\ib的时候就会自动输入三行


## 3 修改2 \s系列
在hot keys 中对应的Statements,对应的是statements.templates 这里的修改纯属个人的编程习惯。
我喜欢大括号单独占一行。在这个文件里修改就可以了。

## 4 Templates 的修改
默认的Templates中含有很多不必要的文件，比如说你的一些信息，当你用命令行生成一个新的perl文件的时候，会在开头生成很多的内容，这部分内容其实没有必要，所以
我们在这里删除。有兴趣的可以进行对比。

## 6 comments.templates 文件的修改
这个文件是控制**注释**的，其中有一项
```
== Comments.file description pl == map:chpl, sc:d, start, noindent ==
```
这一行控制的是当我们用命令行生成一个新的perl程序的时候，自动在开头为
程序添加注释。这部分我们也是认为是没有用的，所以我们进行删除。当然你也可以
自己进行修改以及保留，这里我们还删除了一下一行。
```
use utf8
```

##  常用perl-support快捷键总结
这里面的快捷键都上百了，是在记忆有限，所以还是找了几个常用的，记录下来， 作为参考
### \i 系列:in
```
\ip	# print "\n";
\io # 新建一个输出句柄 
\ii	# 新建一个输入句柄
\ib # 生成头文件 use strict; use warnings;
\it # $ =~ tr///xm
\is # $ =~ s///xm
\im # $ =~ m//xm
\isu # subroutine
```
### \r 系列:run
```
\rs	检查语法错误
\rr	运行程序
```

### \c 系列:comments
```
\cfr #添加注释
```

所有的快捷键都在
```
vim/vimfiles/perl-support/doc/perl-hot-keys.pdf
```
