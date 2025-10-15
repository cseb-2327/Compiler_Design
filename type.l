%{
#include "type.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

[0-9]+\.[0-9]+ {
    yylval.fval = atof(yytext);
    return FLOAT;
}

[0-9]+ {
    yylval.ival = atoi(yytext);
    return INTEGER;
}

[a-zA-Z]+ {
    yylval.sval = strdup(yytext);
    return CHAR;
}

[ \t]+       ; // skip whitespace
\n           { return EOL; }
.            ; // skip other characters

%%

int yywrap() {
    return 1;
}
