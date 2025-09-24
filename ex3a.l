%{
#include "ex3a.tab.h"
#include <stdio.h>
%}

%%
"="        { printf("Operator is EQUAL\n"); return '='; }
";"        { return ';'; }
"+"        { printf("Operator is PLUS\n"); return '+'; }
"-"        { printf("Operator is MINUS\n"); return '-'; }
"*"        { printf("Operator is MULTIPLICATION\n"); return '*'; }
"/"        { printf("Operator is DIVISION\n"); return '/'; }
[a-zA-Z][a-zA-Z0-9]*  { printf("Identifier is %s\n", yytext); return ID; }
[ \t\n]+   ;   /* skip whitespace */
.          { return yytext[0]; }
%%

int yywrap()
{
    return 1;
}

