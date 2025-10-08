%{
#include <stdio.h>
void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;
%}

%token ID INT FLOAT DOUBLE

%%

D: T L ';' { printf("\nDeclaration parsed.\n"); }
;

L: L ID
 | ID
;

T: INT
 | FLOAT
 | DOUBLE
;

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("fopen");
            return 1;
        }
    }

    yyparse();

    if (yyin) fclose(yyin);
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
