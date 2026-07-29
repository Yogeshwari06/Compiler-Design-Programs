tac.l
%{
#include &quot;tac.tab.h&quot;
#include &lt;string.h&gt;
%}
%%
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }
[0-9]+ { yylval.str = strdup(yytext); return NUM; }
[\t\n ]+ { /* skip spaces */ }
. { return yytext[0]; }
%%
int yywrap() {
return 1;
}
tac.y
%{
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;string.h&gt;
int tempCount = 1;
char temp[10];
%}
%union { char *str; }
%token &lt;str&gt; ID NUM

%type &lt;str&gt; expr
%left &#39;+&#39; &#39;-&#39;
%left &#39;*&#39; &#39;/&#39;
%%
stmt: ID &#39;=&#39; expr { printf(&quot;%s = %s\n&quot;, $1, $3); }
;
expr: expr &#39;+&#39; expr {
sprintf(temp, &quot;t%d&quot;, tempCount++);
printf(&quot;%s = %s + %s\n&quot;, temp, $1, $3);
$$ = strdup(temp);
}
| expr &#39;-&#39; expr {
sprintf(temp, &quot;t%d&quot;, tempCount++);
printf(&quot;%s = %s - %s\n&quot;, temp, $1, $3);
$$ = strdup(temp);
}
| expr &#39;*&#39; expr {
sprintf(temp, &quot;t%d&quot;, tempCount++);
printf(&quot;%s = %s * %s\n&quot;, temp, $1, $3);
$$ = strdup(temp);
}
| expr &#39;/&#39; expr {
sprintf(temp, &quot;t%d&quot;, tempCount++);
printf(&quot;%s = %s / %s\n&quot;, temp, $1, $3);
$$ = strdup(temp);
}
| ID { $$ = $1; }
| NUM { $$ = $1; }
;
%%
int main() {
printf(&quot;Enter the expression:\n&quot;);
yyparse();
return 0;
}
int yyerror(char* s) {
printf(&quot;Error: %s\n&quot;, s);
return 0;
}

OUTPUT:

$ flex tac.l
$ bison -d tac.y
$ gcc tac.tab.c lex.yy.c -o tac -lfl
$ ./tac
Enter the expression:
a = b + c * d
t1 = c * d
t2 = b + t1
a = t2
