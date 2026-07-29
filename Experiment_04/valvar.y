%{
#include<stdio.h>
%}
%token LET DIG
%%
variable: var ;
var: var DIG | var LET | LET ;
%%
int main() {
printf("Enter the variable:\n"); 
yyparse();
printf("Valid variable\n"); 
return 0;
}
int yyerror() { 
printf("Invalid variable\n"); 
exit(0);
}

Output:

&quot;valvar.y&quot; 25L, 246C written
[gomathy@rhel5 ~]$ flex valvar.l
[gomathy@rhel5 ~]$ bison -d valvar.y
[gomathy@rhel5 ~]$ gcc lex.yy.c valvar.tab.c -o valvar -lfl
[gomathy@rhel5 ~]$ ./valvar
Enter the variable:
add
Valid variable
[gomathy@rhel5 ~]$ ./valvar
Enter the variable:
add1
Valid variable
[gomathy@rhel5 ~]$ ./valvar
Enter the variable:
1add
Invalid variable
[gomathy@rhel5 ~]$
