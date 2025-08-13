%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_IDENTIFIER_LENGTH 50

typedef struct {
    char name[MAX_IDENTIFIER_LENGTH];
} Symbol;

Symbol symbol_table[100];
int symbol_count = 0;

void addtosymboltable(const char* identifier);
%}

%option noyywrap
%option yylineno

%%
[ \t]+                ; // Ignore whitespace
\n                    ; // Ignore newlines
\/\*([^*]|\*+[^*/])*\*+\/   ; // Match multiline comments
[0-9]+               { printf("Constant: %s\n", yytext); }
=                   { printf("%s is an assignment operator\n", yytext); }
[\+\-\*/]           { printf("%s is an operator\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* {
                        printf("Identifier: %s\n", yytext);
                        addtosymboltable(yytext);
                    }
.                   { printf("Invalid token: %s\n", yytext); }
%%

void addtosymboltable(const char* identifier) {
    if (symbol_count < 100) {
        strncpy(symbol_table[symbol_count].name, identifier, MAX_IDENTIFIER_LENGTH - 1);
        symbol_table[symbol_count].name[MAX_IDENTIFIER_LENGTH - 1] = '\0';
        printf("Identifier %s is entered in the symbol table\n", identifier);
        symbol_count++;
    } else {
        printf("Symbol table is full. Cannot add more identifiers.\n");
        exit(1);
    }
}

int main() {
    yylex();
    return 0;
}

