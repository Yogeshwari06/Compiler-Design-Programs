CS4501 Compiler Design Lab - Experiment-wise Source Code
===============================================================

The folders contain the source code exactly as present in the uploaded lab manual.

Requirements:
- flex
- bison
- gcc
- libfl

Experiment 1:
  flex symtab.l
  gcc lex.yy.c -o symtab -lfl
  ./symtab input.c

Experiment 2:
  flex lexer.l
  gcc lex.yy.c -o lexer -lfl
  ./lexer iplex.c

Experiments 3-5, 7-10:
  flex <name>.l
  bison -d <name>.y
  gcc lex.yy.c <name>.tab.c -o <executable> -lfl
  ./<executable>

Experiment 6:
  flex cal.l
  bison -d cal.y
  gcc lex.yy.c cal.tab.c -o calc -lfl
  ./calc

Note:
The source files are provided in the exact code format from the lab manual. The generated
lex.yy.c, *.tab.c, *.tab.h, and executable binaries are generated files and are not included.
