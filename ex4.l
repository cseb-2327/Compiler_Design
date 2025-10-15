%{
#include <stdio.h>
#include <stdlib.h>
#include "ex4.tab.h"
%}

%%

[0-9]+           { yylval = atoi(yytext); return NUM; }
[\t ]            ;  // Ignore whitespace
\n               { return EOL; }
[-+*/()]         { return yytext[0]; }
.                { fprintf(stderr, "Error: Invalid character '%s'\n", yytext); }

%%

int yywrap() {
    return 1;
}
