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
Input

a+b*c

Output

Enter the Expression
valid Expression

Input

a+*b

Output

Enter the Expression
Invalid Expression
