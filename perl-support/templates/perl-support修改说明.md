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
* 4 常用perl-support快捷键总结

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
 9:  = Idioms.open input file == map:ii, sc:i ==
10:  my      $|?FILEPOINTER|_in = "<CURSOR>";
11:  open  my $|FILEPOINTER|, '<', $|FILEPOINTER|_in or die "cannot open\n";
12:  while(my $line = <$in>)
		 {
					chomp $line;
		 }
12:  close  $|FILEPOINTER|;
13:  
14:  == Idioms.open output file == map:io, sc:o ==
15:  my      $|?FILEPOINTER|_out = "<CURSOR>";
16:  open  my $|FILEPOINTER|, '>', $|FILEPOINTER|_out or die  "cannot open$!\n";
17:  close  $|FILEPOINTER|;
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

## 4 常用perl-support快捷键总结
这里面的快捷键都上百了，是在记忆有限，所以还是找了几个常用的，记录下来， 作为参考
```
\cfr	添加注释
\ip	print "\n";
\io \ii	open
\rs	检查语法错误
\rr	运行程序
```
