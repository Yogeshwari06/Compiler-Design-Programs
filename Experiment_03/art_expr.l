//art_expr.l
%{
#include&lt;stdio.h&gt;
#include &quot;art_expr.tab.h&quot;
%}
%%
[a-zA-Z][0-9a-zA-Z]* {return ID;}
[0-9]+ {return DIG;}
[ \t]+ {;}
. {return yytext[0];}
\n {return 0;}
%%
int yywrap() {
return 1;
}
//art_expr.y
%{
#include&lt;stdio.h&gt;
%}
%token ID DIG
%left &#39;+&#39; &#39;-&#39;
%left &#39;*&#39; &#39;/&#39;

%right UMINUS
%%
stmt: expn ;
expn: expn &#39;+&#39; expn | expn &#39;-&#39; expn | expn &#39;*&#39; expn | expn &#39;/&#39; expn | &#39;-&#39; expn %prec UMINUS |
&#39;(&#39; expn &#39;)&#39; | DIG | ID;
%%
int main() {
printf(&quot;Enter the Expression\n&quot;);
yyparse();
printf(&quot;valid Expression\n&quot;);
return 0;
}
int yyerror() {
printf(&quot;Invalid Expression&quot;);
exit(0);
}

OUPUT;
&quot;art_expr.y&quot; 33L, 372C written
[gomathy@rhel5 ~]$ flex art_expr.l
[gomathy@rhel5 ~]$ bison -d art_expr.y
[gomathy@rhel5 ~]$ gcc lex.yy.c art_expr.tab.c -o art_expr -lfl
[gomathy@rhel5 ~]$ ./art_expr
Enter the Expression
a+b*c-d/e
valid Expression
[gomathy@rhel5 ~]$ ./art_expr
Enter the Expression
a=b
Invalid Expression
[gomathy@rhel5 ~]$ _
