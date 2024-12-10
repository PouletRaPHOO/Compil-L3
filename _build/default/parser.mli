
(* The type of tokens. *)

type token = 
  | VAR
  | VAL
  | TIMES
  | THEN
  | SUP
  | SEMICOLON
  | RPAREN
  | RETURN
  | REQ
  | PLUS
  | OR
  | NEQ
  | MOD
  | MINUS
  | LPAREN
  | LEQ
  | INIT
  | INF
  | INCR
  | IF
  | IDENT of (string)
  | FUN
  | FN
  | EQ
  | EOF
  | END
  | ELSE
  | ELIF
  | DOT
  | DIV
  | CST of (int)
  | COMMA
  | COL of (int)
  | BEGIN
  | ASSIGN
  | ARROW
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
