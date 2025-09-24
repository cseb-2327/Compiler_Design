%{
#include <stdio.h>
#include <stdlib.h>

int COMMENT = 0;
extern FILE *yyin;
%}

/* Regex definitions */
identifier    [a-zA-Z_][a-zA-Z0-9_]*
number        [0-9]+
string        \"([^\\\"]|\\.)*\"
whitespace    [ \t\r\n]+

%%
"/*"                      { COMMENT = 1; }
"*/"                      { COMMENT = 0; }
{whitespace}              { /* skip whitespace */ }

#.*                       { if (!COMMENT) printf("\n%s is a preprocessor directive", yytext); }

"int" |
"float" |
"void" |
"main" |
"if" |
"else" |
"printf" |
"scanf" |
"for" |
"char" |
"getch" |
"while"                  { if (!COMMENT) printf("\n%s is a keyword", yytext); }

{string}                 { if (!COMMENT) printf("\n%s is a string", yytext); }

{number}                 { if (!COMMENT) printf("\n%s is a number", yytext); }

{identifier}[ \t]*\(     { if (!COMMENT) printf("\nFunction: %.*s", (int)(yyleng - 1), yytext); unput('('); }

{identifier}(\[[0-9]+\])? { if (!COMMENT) printf("\n%s is an Identifier", yytext); }

"{"                      { if (!COMMENT) printf("\nBlock begins"); }
"}"                      { if (!COMMENT) printf("\nBlock ends"); }

"="                      { if (!COMMENT) printf("\n= is an Assignment operator"); }

"<=" |
">=" |
"<"  |
"=="                     { if (!COMMENT) printf("\n%s is a relation operator", yytext); }

"("                      { if (!COMMENT) printf("%s", yytext); }
")"                      { if (!COMMENT) printf("%s\n", yytext); }
";"                      { if (!COMMENT) printf("%s\n", yytext); }

.                        { /* ignore unrecognized characters */ }
%%

int main(int argc, char **argv)
{
    if(argc > 1)
    {
        FILE *file = fopen(argv[1], "r");
        if(!file)
        {
            printf("Could not open the file: %s\n", argv[1]);
            exit(1);
        }
        yyin = file;
    }

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
