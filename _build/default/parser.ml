
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
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
    | IDENT of (
# 12 "parser.mly"
       (string)
# 35 "parser.ml"
  )
    | FUN
    | FN
    | EQ
    | EOF
    | END
    | ELSE
    | ELIF
    | DOT
    | DIV
    | CST of (
# 11 "parser.mly"
       (int)
# 49 "parser.ml"
  )
    | COMMA
    | COL of (
# 13 "parser.mly"
       (int)
# 55 "parser.ml"
  )
    | BEGIN
    | ASSIGN
    | ARROW
    | AND
  
end

include MenhirBasics

# 5 "parser.mly"
  
  open Ast


# 71 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_prog) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState01 : (('s, _menhir_box_prog) _menhir_cell1_SEMICOLON, _menhir_box_prog) _menhir_state
    (** State 01.
        Stack shape : SEMICOLON.
        Start symbol: prog. *)

  | MenhirState04 : (('s, _menhir_box_prog) _menhir_cell1_list_SEMICOLON_, _menhir_box_prog) _menhir_state
    (** State 04.
        Stack shape : list(SEMICOLON).
        Start symbol: prog. *)

  | MenhirState09 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 09.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState10 : (('s, _menhir_box_prog) _menhir_cell1_SEMICOLON, _menhir_box_prog) _menhir_state
    (** State 10.
        Stack shape : SEMICOLON.
        Start symbol: prog. *)

  | MenhirState12 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PLUS, _menhir_box_prog) _menhir_state
    (** State 12.
        Stack shape : expr PLUS.
        Start symbol: prog. *)

  | MenhirState13 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PLUS, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 13.
        Stack shape : expr PLUS expr.
        Start symbol: prog. *)

  | MenhirState15 : (('s, _menhir_box_prog) _menhir_cell1_decla, _menhir_box_prog) _menhir_state
    (** State 15.
        Stack shape : decla.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_decla = 
  | MenhirCell1_decla of 's * ('s, 'r) _menhir_state * (Ast.decl)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.exp)

and ('s, 'r) _menhir_cell1_list_SEMICOLON_ = 
  | MenhirCell1_list_SEMICOLON_ of 's * ('s, 'r) _menhir_state * (unit list)

and ('s, 'r) _menhir_cell1_PLUS = 
  | MenhirCell1_PLUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SEMICOLON = 
  | MenhirCell1_SEMICOLON of 's * ('s, 'r) _menhir_state

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.program) [@@unboxed]

let _menhir_action_01 =
  fun d ->
    (
# 43 "parser.mly"
                         ({name = "aaa"; body = {params = []; result = None; body =d}})
# 138 "parser.ml"
     : (Ast.decl))

let _menhir_action_02 =
  fun i ->
    (
# 46 "parser.mly"
                (Eident i )
# 146 "parser.ml"
     : (Ast.exp))

let _menhir_action_03 =
  fun e1 e2 ->
    (
# 47 "parser.mly"
                             (Ebinop (Add, e1, e2))
# 154 "parser.ml"
     : (Ast.exp))

let _menhir_action_04 =
  fun i ->
    (
# 48 "parser.mly"
              (Eint i)
# 162 "parser.ml"
     : (Ast.exp))

let _menhir_action_05 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 170 "parser.ml"
     : (unit list))

let _menhir_action_06 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 178 "parser.ml"
     : (unit list))

let _menhir_action_07 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 186 "parser.ml"
     : (Ast.program))

let _menhir_action_08 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 194 "parser.ml"
     : (Ast.program))

let _menhir_action_09 =
  fun x ->
    (
# 228 "<standard.mly>"
    ( [ x ] )
# 202 "parser.ml"
     : (unit list))

let _menhir_action_10 =
  fun x xs ->
    (
# 231 "<standard.mly>"
    ( x :: xs )
# 210 "parser.ml"
     : (unit list))

let _menhir_action_11 =
  fun main ->
    (
# 41 "parser.mly"
                                    (main)
# 218 "parser.ml"
     : (Ast.program))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AND ->
        "AND"
    | ARROW ->
        "ARROW"
    | ASSIGN ->
        "ASSIGN"
    | BEGIN ->
        "BEGIN"
    | COL _ ->
        "COL"
    | COMMA ->
        "COMMA"
    | CST _ ->
        "CST"
    | DIV ->
        "DIV"
    | DOT ->
        "DOT"
    | ELIF ->
        "ELIF"
    | ELSE ->
        "ELSE"
    | END ->
        "END"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | FN ->
        "FN"
    | FUN ->
        "FUN"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | INCR ->
        "INCR"
    | INF ->
        "INF"
    | INIT ->
        "INIT"
    | LEQ ->
        "LEQ"
    | LPAREN ->
        "LPAREN"
    | MINUS ->
        "MINUS"
    | MOD ->
        "MOD"
    | NEQ ->
        "NEQ"
    | OR ->
        "OR"
    | PLUS ->
        "PLUS"
    | REQ ->
        "REQ"
    | RETURN ->
        "RETURN"
    | RPAREN ->
        "RPAREN"
    | SEMICOLON ->
        "SEMICOLON"
    | SUP ->
        "SUP"
    | THEN ->
        "THEN"
    | TIMES ->
        "TIMES"
    | VAL ->
        "VAL"
    | VAR ->
        "VAR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_07 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_list_SEMICOLON_ -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let MenhirCell1_list_SEMICOLON_ (_menhir_stack, _, _) = _menhir_stack in
      let main = _v in
      let _v = _menhir_action_11 main in
      MenhirBox_prog _v
  
  let rec _menhir_run_16 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_decla -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let MenhirCell1_decla (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_08 x xs in
      _menhir_goto_list_decla_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_decla_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState15 ->
          _menhir_run_16 _menhir_stack _v
      | MenhirState04 ->
          _menhir_run_07 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let i = _v in
      let _v = _menhir_action_02 i in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState12 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState15 ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_13 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PLUS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | SEMICOLON ->
          let MenhirCell1_PLUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_03 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PLUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState12 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CST _v ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let i = _v in
      let _v = _menhir_action_04 i in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState09
      | PLUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState09
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _menhir_stack = MenhirCell1_SEMICOLON (_menhir_stack, _menhir_s) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState10
      | CST _ | EOF | IDENT _ ->
          let x = () in
          let _v = _menhir_action_09 x in
          _menhir_goto_nonempty_list_SEMICOLON_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_nonempty_list_SEMICOLON_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState09 ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState10 ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_14 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, d) = _menhir_stack in
      let _v = _menhir_action_01 d in
      let _menhir_stack = MenhirCell1_decla (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState15
      | CST _v_1 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState15
      | EOF ->
          let _v_2 = _menhir_action_07 () in
          _menhir_run_16 _menhir_stack _v_2
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_11 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_SEMICOLON -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_SEMICOLON (_menhir_stack, _menhir_s) = _menhir_stack in
      let (xs, x) = (_v, ()) in
      let _v = _menhir_action_10 x xs in
      _menhir_goto_nonempty_list_SEMICOLON_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_SEMICOLON_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState04
      | CST _v_1 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState04
      | EOF ->
          let _v_2 = _menhir_action_07 () in
          _menhir_run_07 _menhir_stack _v_2
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_02 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_SEMICOLON -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_SEMICOLON (_menhir_stack, _menhir_s) = _menhir_stack in
      let (xs, x) = (_v, ()) in
      let _v = _menhir_action_06 x xs in
      _menhir_goto_list_SEMICOLON_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_SEMICOLON_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState01 ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SEMICOLON (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
      | CST _ | EOF | IDENT _ ->
          let _v = _menhir_action_05 () in
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | CST _ | EOF | IDENT _ ->
          let _v = _menhir_action_05 () in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
