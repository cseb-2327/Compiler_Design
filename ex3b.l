%{
#include "ex3b.tab.h"
#include <stdio.h>
%}

%%

"int"     { return INT; }
"float"   { return FLOAT; }
"double"  { return DOUBLE; }
[a-zA-Z][a-zA-Z0-9]*  { printf("\nIdentifier is %s", yytext); return ID; }
[ \t]     ;  // Ignore whitespace
\n        ;  // Ignore newlines
.         { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
