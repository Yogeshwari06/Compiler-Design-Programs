%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int line_num = 1;
int token_count = 0;
%}

%option noyywrap

%%

"#include"|"#define"|"#ifdef"|"#ifndef"|"#endif"  {
    printf("Line %d  PREPROCESSOR\t: %s\n", line_num, yytext);
    token_count++;
}

"<"[a-zA-Z0-9_.]+".h"  {
    printf("Line %d  HEADER FILE\t: %s\n", line_num, yytext);
    token_count++;
}

"auto"|"break"|"case"|"char"|"const"|"continue"|
"default"|"do"|"double"|"else"|"enum"|"extern"|
"float"|"for"|"goto"|"if"|"int"|"long"|
"register"|"return"|"short"|"signed"|"sizeof"|
"static"|"struct"|"switch"|"typedef"|"union"|
"unsigned"|"void"|"volatile"|"while"  {
    printf("Line %d  KEYWORD\t\t: %s\n", line_num, yytext);
    token_count++;
}

[a-zA-Z_][a-zA-Z0-9_]*  {
    printf("Line %d  IDENTIFIER\t: %s\n", line_num, yytext);
    token_count++;
}

[0-9]+(\.[0-9]+)?  {
    printf("Line %d  NUMBER\t\t: %s\n", line_num, yytext);
    token_count++;
}

"=="|"!="|"<="|">="  {
    printf("Line %d  RELAT OP\t: %s\n", line_num, yytext);
    token_count++;
}

"="|"+="|"-="|"*="|"/="  {
    printf("Line %d  ASSIGN OP\t: %s\n", line_num, yytext);
    token_count++;
}

"++"|"--"|"+"|"-"|"*"|"/"|"%"  {
    printf("Line %d  ARITH OP\t: %s\n", line_num, yytext);
    token_count++;
}

"<"|">"|"!"  {
    printf("Line %d  RELAT OP\t: %s\n", line_num, yytext);
    token_count++;
}

"&&"|"||"  {
    printf("Line %d  LOGIC OP\t: %s\n", line_num, yytext);
    token_count++;
}

";"|","|"("|")"|"{"|"}"|"["|"]"|":"  {
    printf("Line %d  DELIMITER\t: %s\n", line_num, yytext);
    token_count++;
}

"//"[^\n]*  {
    printf("Line %d  COMMENT\t\t: %s\n", line_num, yytext);
    token_count++;
}

"/*"([^*]|\*+[^*/])*\*+"/"  {
    printf("Line %d  COMMENT\t\t: /* ... */\n", line_num);
    token_count++;
}

\"[^\"\n]*\"  {
    printf("Line %d  STRING\t\t: %s\n", line_num, yytext);
    token_count++;
}

\n  { line_num++; }
[ \t]+  { }
.  { }

%%

int main(int argc, char *argv[]) {
    if(argc < 2) {
        printf("Usage: ./ex2_lexer <filename>\n");
        return 1;
    }
    FILE *fp = fopen(argv[1], "r");
    if(fp == NULL) {
        printf("Cannot open file: %s\n", argv[1]);
        return 1;
    }
    printf("========================================\n");
    printf("      LEXICAL ANALYSIS RESULT\n");
    printf("      Input file: %s\n", argv[1]);
    printf("========================================\n\n");
    yyin = fp;
    yylex();
    fclose(fp);
    printf("\n========================================\n");
    printf("Total tokens found  : %d\n", token_count);
    printf("Total lines scanned : %d\n", line_num - 1);
    printf("========================================\n");
    return 0;
}


OUTPUT:

========================================
      LEXICAL ANALYSIS RESULT
      Input file: sample.c
========================================

Line 1  PREPROCESSOR    : #include
Line 1  HEADER FILE     : <stdio.h>

Line 3  KEYWORD         : int
Line 3  IDENTIFIER      : main
Line 3  DELIMITER       : (
Line 3  DELIMITER       : )
Line 3  DELIMITER       : {

Line 4  KEYWORD         : int
Line 4  IDENTIFIER      : a
Line 4  ASSIGN OP       : =
Line 4  NUMBER          : 10
Line 4  DELIMITER       : ;

Line 5  KEYWORD         : float
Line 5  IDENTIFIER      : b
Line 5  ASSIGN OP       : =
Line 5  NUMBER          : 20.5
Line 5  DELIMITER       : ;

Line 7  KEYWORD         : if
Line 7  DELIMITER       : (
Line 7  IDENTIFIER      : a
Line 7  RELAT OP        : >=
Line 7  IDENTIFIER      : b
Line 7  DELIMITER       : )
Line 7  DELIMITER       : {

Line 9  IDENTIFIER      : a
Line 9  ARITH OP        : ++
Line 9  DELIMITER       : ;

Line 10  DELIMITER      : }

Line 12  COMMENT        : // End of program

Line 13  KEYWORD         : return
Line 13  NUMBER          : 0
Line 13  DELIMITER       : ;

Line 14  DELIMITER       : }

========================================
Total tokens found  : 30
Total lines scanned : 14
========================================


