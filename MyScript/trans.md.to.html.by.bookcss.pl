#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 00.trans.md.to.html.by.bookcss.pl
#
#        USAGE: ./00.trans.md.to.html.by.bookcss.pl  
#
#  DESCRIPTION: 将指定的markdown文件转换为book.css格式的html
#
#      OPTIONS: -in markdown.file.list
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Guo Changjiang (polaris), guochangjiang1989@gmail.com
# ORGANIZATION: Nanjing University, China
#      VERSION: 1.0
#      CREATED: 2015/7/25 15:48:26
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

my @mdfile=@ARGV;
system("copy \"D:\\Program Files\\Pandoc\\book.css\" book.css") unless -e "book.css";
foreach my $md (@mdfile){
	next unless $md=~/md$/;
	my $out=$md;
	$out=~s/md$/html/;
	print "$md to $out .............";
	system ("pandoc $md -o $out --ascii -c book.css");
	print "\n\n---------------------\n---------------------\n";
	print "Congratulations!\nmd2html Complete!\n\n\n";
	#system exit;
}

#unlink "book.css";
