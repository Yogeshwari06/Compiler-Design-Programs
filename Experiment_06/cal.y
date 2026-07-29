%{
#include <ctype.h> 
#include <stdio.h> 
#define YYSTYPE double
%}
%token NUM
%left '+' '-'
%left '*' '/'
%right UMINUS
%%
Statment: E { printf("Answer: %g \n", $$); }
| Statment '\n'
;
E : E '+' E { $$ = $1 + $3; }
| E '-' E { $$ = $1 - $3; }
| E '*' E { $$ = $1 * $3; }
| E '/' E { $$ = $1 / $3; }
| NUM
;
%%
int main() {
printf("Enter the expression:\n"); 
yyparse();
return 0;
}
int yyerror(char *s) { 
printf("%s\n", s); 
return 0;
} 

OUTPUT:

$ flex cal.l
$ bison -d cal.y
$ gcc lex.yy.c cal.tab.c -o calc -lfl
$ ./calc
Enter the expression:
2+2
Answer: 4
