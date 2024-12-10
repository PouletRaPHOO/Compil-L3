let main =
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



  let main_parse  =

    let pile = ref [] in
    let list = ref [] in
    let last_emit = ref None
    let rec aux lexbuf -> match list with
      | x::t -> list := t; last_emit := x; x
      | [] -> (let next = token lexbuf in match next with
        | COL i -> (match pile with
            | [] -> failwith "Problème de pile"
            | m::t ->let n = token lexbuf in
              if c>m then (
                if n == RPAREN then list := SEMICOLON::!list;
                list := n::!list;
                if not (List.mem last endcont_tbl) &&
                   not (List.mem n begincont_tbl) then (
                  list := LPAREN::SEMICOLON::!list
                ) else if last_emit == LPAREN then (
                  pile := c::!pile
                )
                aux lexbuf
              ) else (
                list := n::!list;
                if not (List.mem last endcont_tbl) &&
                   not (List.mem n begincont_tbl) then (
                  list := SEMICOLON::!list;
                )
                let m' = ref m in
                while c < !m' do
                  if not (next=RPAREN) then list := SEMICOLON::RPAREN::!list
                  let x::t = !pile in
                  m' := x;
                  !pile := t;
                done;
                if c > !m' then failwith "Colonne non alignée"
              )
            )
        | _ -> last_emit := next; !next
        )
    in
    aux
