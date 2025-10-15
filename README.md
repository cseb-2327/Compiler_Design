# Compiler_Design
COMPILER DESIGN PROGRAMS


## ---5 experimet ---
--------------------
type.l

type.y

comment to run :

 bison -d type.y
 
 flex type.l

 gcc type.tab.c lex.yy.c -o parser -lfl
 
 ./parser

 
sample output :

42

Type: INTEGER

3.14

Type: FLOAT

hello

Type: CHAR/STRING

-------------------------------
