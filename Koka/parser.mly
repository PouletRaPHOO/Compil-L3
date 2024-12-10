

/* Analyseur syntaxique pour mini-Turtle */

%{
  open Ast

%}

/* Déclaration des tokens */
%token <int> CST
%token <string> IDENT
%token <int> COL
%token SEMICOLON
%token COMMA BEGIN END
%token VAL VAR
%token LPAREN RPAREN
%token PLUS MINUS TIMES DIV MOD INCR
%token INF LEQ SUP REQ EQ NEQ
%token AND OR
%token IF THEN ELSE ELIF
%token ARROW INIT ASSIGN
%token DOT
%token RETURN
%token EOF
%token FUN FN

/* Priorités et associativités des tokens */


/* Point d'entrée de la grammaire */
%start prog

/* Type des valeurs renvoyées par l'analyseur syntaxique */
%type <Ast.program> prog

%%

/* Règles de grammaire */

prog: SEMICOLON*  main = decla* EOF {main}

decla: d=expr SEMICOLON+ {{name = "aaa"; body = {params = []; result = None; body =d}}}

expr:
    | i = IDENT {Eident i }
    | e1 = expr PLUS e2=expr {Ebinop (Add, e1, e2)}
    | i = CST {Eint i}
