%{
#include "ex3c.tab.h"
#include <stdio.h>
%}

%%

"if"        { return IF; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"for"       { return FOR; }
"switch"    { return SWITCH; }
"case"      { return CASE; }
"default"   { return DEFAULT; }
"break"     { return BREAK; }
"("         { return OPEN_BRACKET; }
")"         { return CLOSE_BRACKET; }
"{"         { return OPEN_BRACE; }
"}"         { return CLOSE_BRACE; }
":"         { return COLON; }
";"         { return SEMICOLON; }
[\t\n ]+    ;  /* ignore whitespace */
.           ;  /* ignore any other characters */

%%

int yywrap(void)
{
    return 1;
}
