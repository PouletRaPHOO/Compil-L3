
(* Analyseur lexical pour mini-Koka *)

{
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
}


let lower = ['a' - 'z']
let upper = ['A' - 'Z']| '_'
let digit =  ['0'-'9']
let other = lower | upper | digit | '-'
let ident = lower other* '\''*
let integer = '-'? ('0' | ['1' - '9'] digit*)
let string = '"' [^ '\\' 'n']* '"'

let space = ' ' | '\t'


rule token = parse
    | "//" [^ '\n']* '\n' {new_line lexbuf; column 0 lexbuf}
    | "(*" {comment lexbuf}
    | '\n' {new_line lexbuf; column 0 lexbuf}
    | '\t' {token lexbuf}
    | '+' {PLUS}
    | '-' {MINUS}
    | '*' {TIMES}
    | '/' {DIV}
    | '{' {BEGIN}
    | '}' {END}
    | '(' {LPAREN}
    | ')' {RPAREN}
    | ident as i  {if check_ident i then id_or_kwd i else
        raise (Lexing_error "Erreur de format d'identificateur")}
    | eof  { EOF }
    | _ { assert false }

and column arg = parse
    | '\n' {column 0 lexbuf}
    | space {column (arg+1) lexbuf }
    | _ {COL arg}


and comment = parse
    | "*)" {token lexbuf}
    | '\n' {new_line lexbuf; comment lexbuf }
    | _ {comment lexbuf}
    | eof {raise (Lexing_error ("Commentaire non terminé"))}

{
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

}
