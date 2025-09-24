%{
#include <stdio.h>

int yylex(void);
void yyerror(char *s);
%}

%token ID

%%
statement:
      ID '=' E ';'     { printf("Valid assignment expression\n"); }
    | E ';'           { printf("Valid arithmetic expression\n"); }
    ;

E:
      E '+' ID
    | E '-' ID
    | E '*' ID
    | E '/' ID
    | ID
    ;
%%

extern FILE *yyin;

int main()
{
    if (!yyin) yyin = stdin;
    while(!feof(yyin))
    {
        yyparse();
    }
    return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

