# 4 "lexer.mll"
 
    open Lexing
    open Parser

    exception Lexing_error of string

    let endcont_tbl =
    [PLUS; MINUS; TIMES;
     DIV; MOD; INCR; INF; LEQ;
     SUP; REQ; EQ; NEQ; AND; OR;
     LPAREN; BEGIN; COMMA
    ]

 let begincont_tbl =
    [PLUS; MINUS; TIMES;
     DIV; MOD; INCR; INF; LEQ;
     SUP; REQ; EQ; NEQ; AND; OR;
     THEN; ELSE; ELIF; RPAREN;
     END; COMMA; ARROW; BEGIN;
     INIT; DOT; ASSIGN
    ]


    let kwd_tbl =
    ["elif", ELIF;
     "else", ELSE;
     "fn", FN;
     "fun", FUN;
     "if", IF;
     "return", RETURN;
     "then", THEN;
     "val", VAL;
     "var", VAR]

    let id_or_kwd =
        let h = Hashtbl.create 9 in
        List.iter (fun (s,t) -> Hashtbl.add h s t) kwd_tbl;
        fun s ->
            try Hashtbl.find h s with _ -> IDENT s


    let is_alpha = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false
    let is_digit = function '0' .. '9' -> true | _ -> false

    let check_ident i =
        let n = String.length i in
        let b = ref true in
        String.iteri (fun j c->
            b :=!b && (
               ( c != '-' || ((is_digit i.[j-1] || is_alpha i.[j-1]) && (j=n-1 || is_alpha i.[j+1])) )
            )
        ) i;
        !b

# 57 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\241\255\242\255\085\000\244\255\246\255\247\255\249\255\
    \250\255\251\255\252\255\253\255\002\000\001\000\001\000\255\255\
    \254\255\000\000\003\000\253\255\254\255\255\255\004\000\252\255\
    \253\255\254\255\008\000\255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\012\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\010\000\007\000\255\255\255\255\
    \255\255\012\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\002\000\255\255";
  Lexing.lex_default =
   "\001\000\000\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\255\255\014\000\000\000\
    \000\000\255\255\019\000\000\000\000\000\000\000\024\000\000\000\
    \000\000\000\000\255\255\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\010\000\011\000\015\000\020\000\021\000\025\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\020\000\000\000\000\000\000\000\017\000\
    \012\000\004\000\007\000\009\000\016\000\008\000\026\000\013\000\
    \014\000\027\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\006\000\017\000\005\000\000\000\000\000\
    \000\000\000\000\003\000\000\000\000\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \000\000\000\000\000\000\000\000\003\000\000\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\255\255\000\000\255\255\023\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\014\000\018\000\018\000\022\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\018\000\255\255\255\255\255\255\017\000\
    \000\000\000\000\000\000\000\000\012\000\000\000\022\000\000\000\
    \013\000\026\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\003\000\000\000\255\255\255\255\
    \255\255\255\255\003\000\255\255\255\255\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \255\255\255\255\255\255\255\255\003\000\255\255\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\014\000\255\255\018\000\022\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec token lexbuf =
   __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 72 "lexer.mll"
                          (new_line lexbuf; column 0 lexbuf)
# 183 "lexer.ml"

  | 1 ->
# 73 "lexer.mll"
           (comment lexbuf)
# 188 "lexer.ml"

  | 2 ->
# 74 "lexer.mll"
           (new_line lexbuf; column 0 lexbuf)
# 193 "lexer.ml"

  | 3 ->
# 75 "lexer.mll"
           (token lexbuf)
# 198 "lexer.ml"

  | 4 ->
# 76 "lexer.mll"
          (PLUS)
# 203 "lexer.ml"

  | 5 ->
# 77 "lexer.mll"
          (MINUS)
# 208 "lexer.ml"

  | 6 ->
# 78 "lexer.mll"
          (TIMES)
# 213 "lexer.ml"

  | 7 ->
# 79 "lexer.mll"
          (DIV)
# 218 "lexer.ml"

  | 8 ->
# 80 "lexer.mll"
          (BEGIN)
# 223 "lexer.ml"

  | 9 ->
# 81 "lexer.mll"
          (END)
# 228 "lexer.ml"

  | 10 ->
# 82 "lexer.mll"
          (LPAREN)
# 233 "lexer.ml"

  | 11 ->
# 83 "lexer.mll"
          (RPAREN)
# 238 "lexer.ml"

  | 12 ->
let
# 84 "lexer.mll"
               i
# 244 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 84 "lexer.mll"
                  (if check_ident i then id_or_kwd i else
        raise (Lexing_error "Erreur de format d'identificateur"))
# 249 "lexer.ml"

  | 13 ->
# 86 "lexer.mll"
           ( EOF )
# 254 "lexer.ml"

  | 14 ->
# 87 "lexer.mll"
        ( assert false )
# 259 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and column arg lexbuf =
   __ocaml_lex_column_rec arg lexbuf 18
and __ocaml_lex_column_rec arg lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 90 "lexer.mll"
           (column 0 lexbuf)
# 271 "lexer.ml"

  | 1 ->
# 91 "lexer.mll"
            (column (arg+1) lexbuf )
# 276 "lexer.ml"

  | 2 ->
# 92 "lexer.mll"
        (COL arg)
# 281 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_column_rec arg lexbuf __ocaml_lex_state

and comment lexbuf =
   __ocaml_lex_comment_rec lexbuf 22
and __ocaml_lex_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 96 "lexer.mll"
           (token lexbuf)
# 293 "lexer.ml"

  | 1 ->
# 97 "lexer.mll"
           (new_line lexbuf; comment lexbuf )
# 298 "lexer.ml"

  | 2 ->
# 98 "lexer.mll"
        (comment lexbuf)
# 303 "lexer.ml"

  | 3 ->
# 99 "lexer.mll"
          (raise (Lexing_error ("Commentaire non terminé")))
# 308 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_comment_rec lexbuf __ocaml_lex_state

;;

# 101 "lexer.mll"
 
 let main_parse  =

    let pile = ref [] in
    let list = ref [] in
    let last_emit = ref None in
    let rec aux lexbuf = match !list with
      | x::t -> list := t; last_emit :=Some x; x
      | [] -> (let next = token lexbuf in match next with

        | COL c -> (match !pile with

            | [] -> failwith "Problème de pile"

            | m::t ->let n = token lexbuf in

              if c>m then (
                if n = RPAREN then list := SEMICOLON::!list;
                list := n::!list;
                if not (List.mem lastendcont_tbl) &&
                   not (List.mem n begincont_tbl) then (
                  list := LPAREN::!list
                ) else if last_emit == LPAREN then (
                  pile := c::!pile
                )
                aux lexbuf

              ) else (
                list := n::!list;
                if not (List.mem last endcont_tbl) && not (List.mem n begincont_tbl) then (
                  list := SEMICOLON::!list
                );
                let m' = ref m in
                while (c < !(m')) do (
                  if not (next=RPAREN) then (list := SEMICOLON::RPAREN::(!list));
                  let x::t = !pile in
                  m' := x;
                  !pile := t;
                ) done;
                if c > !m' then failwith "Colonne non alignée"
              )
            )

        | _ -> last_emit := next; !next
        )
    in
    aux


# 365 "lexer.ml"
