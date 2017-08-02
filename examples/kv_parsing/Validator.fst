module Validator

open KeyValue
open PureParser
open Slice

open FStar.Ghost
open FStar.Seq
open FStar.HyperStack
open FStar.HyperStack.ST
// special kremlin support for looping
open C.Loops

module B = FStar.Buffer

module U16 = FStar.UInt16
module U32 = FStar.UInt32
module Cast = FStar.Int.Cast

(*** Stateful validation of input buffer *)

inline_for_extraction
let parser_st_nochk #t (p: erased (parser t)) =
  input:bslice -> Stack (t * off:U32.t{U32.v off <= U32.v input.len})
  (requires (fun h0 -> live h0 input /\
                    (let bs = as_seq h0 input in
                     Some? (reveal p bs))))
  (ensures (fun h0 r h1 -> live h1 input /\
                  modifies_none h0 h1 /\
                  (let bs = B.as_seq h1 input.p in
                    Some? (reveal p bs) /\
                    (let (v, n) = Some?.v (reveal p bs) in
                     let (rv, off) = r in
                       v == rv /\
                       n == U32.v off))))

inline_for_extraction
let parser_st #t (p: erased (parser t)) =
  input:bslice -> Stack (option (t * off:U32.t{U32.v off <= U32.v input.len}))
  (requires (fun h0 -> live h0 input))
  (ensures (fun h0 r h1 -> live h1 input /\
          modifies_none h0 h1 /\
          (let bs = as_seq h1 input in
            match reveal p bs with
            | Some (v, n) -> Some? r /\
              begin
                let (rv, off) = Some?.v r in
                  v == rv /\ n == U32.v off
              end
            | None -> r == None)))

let parse_u8_st_nochk :
    parser_st_nochk (hide parse_u8) = fun input ->
    let b0 = B.index input.p 0ul in
    (b0, 1ul)

let parse_u8_st : parser_st (hide parse_u8) = fun input ->
    if U32.lt input.len 1ul then None
    else (Some (parse_u8_st_nochk input))

let parse_u16_st_nochk :
  parser_st_nochk (hide parse_u16) = fun input ->
  let b0 = B.index input.p 0ul in
      let b1 = B.index input.p 1ul in
      begin
        let h = get() in
        let twobytes = append (create 1 b0) (create 1 b1) in
        lemma_eq_intro twobytes (slice (as_seq h input) 0 2)
      end;
      let n = u16_from_bytes b0 b1 in
      (n, U32.uint_to_t 2)

let parse_u16_st : parser_st (hide parse_u16) = fun input ->
  if U32.lt input.len (U32.uint_to_t 2)
    then None
  else Some (parse_u16_st_nochk input)

let parse_u32_st_nochk :
  parser_st_nochk (hide parse_u32) = fun input ->
  let b0 = B.index input.p (U32.uint_to_t 0) in
  let b1 = B.index input.p (U32.uint_to_t 1) in
  let b2 = B.index input.p (U32.uint_to_t 2) in
  let b3 = B.index input.p (U32.uint_to_t 3) in
  let fourbytes = create 1 b0 `append` create 1 b1 `append` create 1 b2 `append` create 1 b3 in
  let h = get() in
  lemma_eq_intro fourbytes (slice (as_seq h input) 0 4);
  let n = u32_from_be fourbytes in
  (n, U32.uint_to_t 4)

let parse_u32_st : parser_st (hide parse_u32) = fun input ->
  if U32.lt input.len (U32.uint_to_t 4)
    then None
    else Some (parse_u32_st_nochk input)

unfold let validation_checks_parse #t (b: bytes)
  (v: option (off:U32.t{U32.v off <= length b}))
  (p: option (t * n:nat{n <= length b})) : Type0 =
  Some? v ==> (Some? p /\ U32.v (Some?.v v) == snd (Some?.v p))

// TODO: unfold is only for extraction
//unfold
inline_for_extraction
let stateful_validator #t (p: erased (parser t)) = input:bslice -> Stack (option (off:U32.t{U32.v off <= U32.v input.len}))
    (requires (fun h0 -> live h0 input))
    (ensures (fun h0 r h1 -> live h1 input /\
                          modifies_none h0 h1 /\
                          (let bs = as_seq h1 input in
                            validation_checks_parse bs r (reveal p bs))))

#reset-options "--z3rlimit 10"

let validate_u16_array_st : stateful_validator (hide parse_u16_array) = fun input ->
  match parse_u16_st input with
  | Some (n, off) -> begin
      let n: U32.t = Cast.uint16_to_uint32 n in
      // overflow is not possible here, since n < pow2 16 and off == 2
      // (any encodable length would fit in a U32)
      let total_len = U32.add n off in
      if U32.lt input.len total_len then None
      else Some total_len
    end
  | None -> None

inline_for_extraction
let u32_array_bound: U32.t = 4294967291ul

let u32_array_bound_is (_:unit) :
  Lemma (U32.v u32_array_bound = pow2 32 - 4 - 1) = ()

let validate_u32_array_st : stateful_validator (hide parse_u32_array) = fun input ->
  match parse_u32_st input with
  | Some (n, off) -> begin
      // we have to make sure that the total length we compute doesn't overflow
      // a U32.t to correctly check if the input is long enough
      if U32.gte n u32_array_bound then None
      else begin
        assert (U32.v n + U32.v off < pow2 32);
        let total_len = U32.add n off in
        if U32.lt input.len total_len then None
        else Some total_len
      end
    end
  | None -> None

[@"substitute"]
let then_check #t (p: erased (parser t)) (v: stateful_validator p)
               #t' (p': erased (parser t')) (v': stateful_validator p')
               #t'' (f: t -> t' -> t'') :
               stateful_validator (elift2 (fun p p' -> p `and_then` (fun x -> p' `and_then` (fun y -> parse_ret (f x y)))) p p') =
fun input ->
  match v input with
  | Some off -> begin
      match v' (advance_slice input off) with
      | Some off' -> (if u32_add_overflows off off' then None
                   else Some (U32.add off off'))
      | None -> None
    end
  | None -> None

// eta expansion is necessary to get the right subtyping check
let validate_entry_st : stateful_validator (hide parse_entry) = fun input ->
  then_check (hide parse_u16_array) validate_u16_array_st
             (hide parse_u32_array) validate_u32_array_st
             (fun key value -> EncodedEntry key.len16 key.a16 value.len32 value.a32) input

module HH = FStar.Monotonic.HyperHeap

val modifies_one_trans (r:HH.rid) (h0 h1 h2:mem) :
    Lemma (requires (modifies_one r h0 h1 /\
                     modifies_one r h1 h2))
          (ensures (modifies_one r h0 h2))
let modifies_one_trans r h0 h1 h2 = ()

#reset-options "--z3rlimit 25"

val parse_many_parse_one (#t:Type) (p:parser t) (n:nat{n > 0}) (bs:bytes{length bs < pow2 32}) :
    Lemma (requires (Some? (parse_many p n bs)))
          (ensures (Some? (p bs)))
let parse_many_parse_one #t p n bs = ()

// TODO: finish this proof; need to think about the induction more
val validate_n_more (#t:Type) (p:parser t) (n m:nat) (buf:bslice)
    (off:U32.t{U32.v off <= U32.v buf.len}) (off':U32.t) (h:mem) :
    Lemma (requires (live h buf /\
                    U32.v off + U32.v off' <= U32.v buf.len /\
                    begin
                      let bs = as_seq h buf in
                      let bs' = as_seq h (advance_slice buf off) in
                      Some? (parse_many p n bs) /\
                      U32.v off == snd (Some?.v (parse_many p n bs)) /\
                      Some? (parse_many p m bs') /\
                      U32.v off' == snd (Some?.v (parse_many p m bs'))
                    end))
          (ensures (live h buf /\
                   begin
                    let bs = as_seq h buf in
                    Some? (parse_many p (n + m) bs) /\
                    U32.v off + U32.v off' == snd (Some?.v (parse_many p (n + m) bs))
                   end))
    (decreases n)
let rec validate_n_more #t p n m buf off off' h =
    match n with
    | 0 -> ()
    | _ -> let bs = as_seq h buf in
          let bs' = as_seq h (advance_slice buf off) in
          parse_many_parse_one p n bs;
          let off_d = snd (Some?.v (p bs)) in
          let off_d_u32 = U32.uint_to_t off_d in
          admit();
          validate_n_more p (n-1) (m+1) buf (U32.add off off_d_u32) (U32.sub off' off_d_u32) h

val validate_one_more (#t:Type) (p:parser t) (n:nat) (buf:bslice)
    (off:U32.t{U32.v off <= U32.v buf.len}) (off':U32.t) (h:mem) :
    Lemma (requires (live h buf /\
                    U32.v off + U32.v off' <= U32.v buf.len /\
                    begin
                      let bs = as_seq h buf in
                      let bs' = as_seq h (advance_slice buf off) in
                      Some? (parse_many p n bs) /\
                      U32.v off == snd (Some?.v (parse_many p n bs)) /\
                      Some? (p bs') /\
                      U32.v off' == snd (Some?.v (p bs'))
                    end))
          (ensures (live h buf /\
                   begin
                    let bs = as_seq h buf in
                    Some? (parse_many p (n + 1) bs) /\
                    U32.v off + U32.v off' == snd (Some?.v (parse_many p (n + 1) bs))
                   end))
let validate_one_more #t p n buf off off' h =
    let bs' = as_seq h (advance_slice buf off) in
    assert (Some? (parse_many p 1 bs') == Some? (p bs'));
    assert (snd (Some?.v (parse_many p 1 bs')) == snd (Some?.v (p bs')));
    validate_n_more p n 1 buf off off' h

let lemma_modifies_0_unalloc (#a:Type) (b:B.buffer a) h0 h1 h2 :
  Lemma (requires (b `B.unused_in` h0 /\
                   B.frameOf b == h0.tip /\
                   B.modifies_0 h0 h1 /\
                   B.modifies_1 b h1 h2))
        (ensures (B.modifies_0 h0 h2)) =
        B.lemma_reveal_modifies_0 h0 h1;
        B.lemma_reveal_modifies_1 b h1 h2;
        B.lemma_intro_modifies_0 h0 h2

let lemma_modifies_none_1_trans (#a:Type) (b:B.buffer a) h0 h1 h2 :
  Lemma (requires (modifies_none h0 h1 /\
                   B.live h0 b /\
                   B.modifies_1 b h1 h2))
        (ensures (B.modifies_1 b h0 h2)) =
  B.lemma_reveal_modifies_1 b h1 h2;
  B.lemma_intro_modifies_1 b h0 h2

let lemma_modifies_0_none_trans h0 h1 h2 :
  Lemma (requires (B.modifies_0 h0 h1 /\
                   modifies_none h1 h2))
        (ensures (B.modifies_0 h0 h2)) =
  B.lemma_reveal_modifies_0 h0 h1;
  B.lemma_intro_modifies_0 h0 h2

inline_for_extraction [@"substitute"]
val validate_many_st (#t:Type) (p:erased (parser t)) (v:stateful_validator p) (n:U32.t) :
    stateful_validator (elift1 (fun p -> (parse_many p (U32.v n))) p)
let validate_many_st #t p v n = fun buf ->
    // TODO: prove this function correct
    let h0 = get() in
    push_frame();
    let h0' = get() in
    let ptr_off = B.create #(n:U32.t{U32.v n <= U32.v buf.len}) 0ul 1ul in
    assert (ptr_off `B.unused_in` h0' /\
            B.frameOf ptr_off == h0'.tip);
    let (i, failed) = interruptible_for 0ul n
      (fun h i failed ->
        live h buf /\
        B.live h ptr_off /\
        poppable h /\
        B.modifies_0 h0' h /\
        begin
          let bs = as_seq h buf in
          not failed ==>
            validation_checks_parse bs
              (Some (Seq.index (B.as_seq h ptr_off) 0))
              (parse_many (reveal p) i bs)
        end)
      (fun i -> let h0 = get() in
             let off = B.index ptr_off 0ul in
             let buf' = advance_slice buf off in
             match v buf' with
             | Some off' ->
              (let h1 = get() in
               B.upd ptr_off 0ul U32.(off +^ off');
               let h2 = get() in
               lemma_modifies_none_1_trans ptr_off h0 h1 h2;
               lemma_modifies_0_unalloc ptr_off h0' h0 h2;
               validate_one_more (reveal p) (U32.v i) buf off off' h1;
               false)
             | None -> (let h1 = get() in
                      lemma_modifies_0_none_trans h0' h0 h1;
                      true)) in
    let off = B.index ptr_off 0ul in
    let h1 = get() in
    pop_frame();
    let h2 = get() in
    begin
      let bs = as_seq h2 buf in
      assert (not failed ==> validation_checks_parse bs (Some off) (parse_many (reveal p) (U32.v n) bs))
    end;
    B.lemma_modifies_0_push_pop h0 h0' h1 h2;
    if failed then None
    else Some off

[@"substitute"]
let validate_done_st : stateful_validator (hide parsing_done) = fun input ->
  if U32.eq input.len 0ul then Some 0ul else None

let validate_entries_st (num_entries:U32.t) : stateful_validator (hide (parse_entries num_entries)) =
  fun input ->
  then_check _
  (validate_many_st (hide parse_entry) validate_entry_st num_entries)
  (hide parsing_done) validate_done_st
  (fun entries _ -> Store num_entries entries) input

let validate_store_st : stateful_validator (hide parse_abstract_store) = fun input ->
  match parse_u32_st input with
  | Some (num_entries, off) ->
    begin
      let input = advance_slice input off in
      match validate_entries_st num_entries input with
      | Some off' -> if u32_add_overflows off off' then None
                    else Some (U32.add off off')
      | None -> None
    end
  | None -> None