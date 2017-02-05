#!user/local/bin/perl
$latex = 'platex -interaction=nonstopmode -kanji=utf-8 %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$bibtex = 'pbibtex';
$pdf_mode = 3; # use dvipdf
$pdf_update_method = 2;
$pdf_previewer = "open -a /Applications/Skim.app";
$pdf_update_command = 'open -ga /Applications/Skim.app';
