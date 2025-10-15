%{
#include <stdio.h>
#include <stdlib.h>

int temp_count = 0;
int yylex(void);
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}

%token NUM EOL
%left '+' '-'
%left '*' '/'

%%

program:
    lines
;

lines:
    lines line
  | line
;

line:
    expr EOL {
        printf("Result: t%d\n", $1);
    }
;

expr:
    NUM {
        $$ = temp_count + 1;
        printf("t%d = %d\n", $$, $1);
        temp_count = $$;
    }
  | '(' expr ')' {
        $$ = $2;
    }
  | expr '+' expr {
        printf("t%d = t%d + t%d\n", ++temp_count, $1, $3);
        $$ = temp_count;
    }
  | expr '-' expr {
        printf("t%d = t%d - t%d\n", ++temp_count, $1, $3);
        $$ = temp_count;
    }
  | expr '*' expr {
        printf("t%d = t%d * t%d\n", ++temp_count, $1, $3);
        $$ = temp_count;
    }
  | expr '/' expr {
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = temp_count + 1;
            printf("t%d = 0\n", $$);
            temp_count = $$;
        } else {
            printf("t%d = t%d / t%d\n", ++temp_count, $1, $3);
            $$ = temp_count;
        }
    }
;

%%

int main() {
    yyparse();
    return 0;
}
