%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int ival;
    float fval;
    char* sval;
    int type;  // To store type indicator (1: INTEGER, 2: FLOAT, 3: CHAR)
}

%token <ival> INTEGER
%token <fval> FLOAT
%token <sval> CHAR
%token EOL

%type <type> statement

%%

program:
      /* empty */
    | program line
    ;

line:
    statement EOL {
        if ($1 == 1)
            printf("Type: INTEGER\n");
        else if ($1 == 2)
            printf("Type: FLOAT\n");
        else if ($1 == 3)
            printf("Type: CHAR/STRING\n");
        else
            printf("Invalid type\n");
    }
    ;

statement:
      INTEGER { $$ = 1; }
    | FLOAT   { $$ = 2; }
    | CHAR    { $$ = 3; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
