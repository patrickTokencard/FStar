open Prims
let tacdbg: Prims.bool FStar_ST.ref = FStar_Util.mk_ref false
let mk_tactic_interpretation_0:
  'a .
    'a FStar_Tactics_Basic.tac ->
      ('a -> FStar_Syntax_Syntax.term) ->
        FStar_Syntax_Syntax.typ ->
          FStar_Ident.lid ->
            FStar_Syntax_Syntax.args ->
              FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun t  ->
    fun embed_a  ->
      fun t_a  ->
        fun nm  ->
          fun args  ->
            match args with
            | (embedded_state,uu____55)::[] ->
                let uu____72 =
                  FStar_Tactics_Embedding.unembed_proofstate embedded_state in
                FStar_Util.bind_opt uu____72
                  (fun ps  ->
                     FStar_Tactics_Basic.log ps
                       (fun uu____84  ->
                          let uu____85 = FStar_Ident.string_of_lid nm in
                          let uu____86 =
                            FStar_Syntax_Print.args_to_string args in
                          FStar_Util.print2 "Reached %s, args are: %s\n"
                            uu____85 uu____86);
                     (let res = FStar_Tactics_Basic.run t ps in
                      let uu____90 =
                        FStar_Tactics_Embedding.embed_result ps res embed_a
                          t_a in
                      FStar_Pervasives_Native.Some uu____90))
            | uu____91 ->
                failwith "Unexpected application of tactic primitive"
let mk_tactic_interpretation_1:
  'a 'r .
    ('a -> 'r FStar_Tactics_Basic.tac) ->
      (FStar_Syntax_Syntax.term -> 'a FStar_Pervasives_Native.option) ->
        ('r -> FStar_Syntax_Syntax.term) ->
          FStar_Syntax_Syntax.typ ->
            FStar_Ident.lid ->
              FStar_Syntax_Syntax.args ->
                FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun t  ->
    fun unembed_a  ->
      fun embed_r  ->
        fun t_r  ->
          fun nm  ->
            fun args  ->
              match args with
              | (a,uu____162)::(embedded_state,uu____164)::[] ->
                  let uu____191 =
                    FStar_Tactics_Embedding.unembed_proofstate embedded_state in
                  FStar_Util.bind_opt uu____191
                    (fun ps  ->
                       FStar_Tactics_Basic.log ps
                         (fun uu____202  ->
                            let uu____203 = FStar_Ident.string_of_lid nm in
                            let uu____204 =
                              FStar_Syntax_Print.term_to_string
                                embedded_state in
                            FStar_Util.print2 "Reached %s, goals are: %s\n"
                              uu____203 uu____204);
                       (let uu____205 = unembed_a a in
                        FStar_Util.bind_opt uu____205
                          (fun a1  ->
                             let res =
                               let uu____215 = t a1 in
                               FStar_Tactics_Basic.run uu____215 ps in
                             let uu____218 =
                               FStar_Tactics_Embedding.embed_result ps res
                                 embed_r t_r in
                             FStar_Pervasives_Native.Some uu____218)))
              | uu____219 ->
                  let uu____220 =
                    let uu____221 = FStar_Ident.string_of_lid nm in
                    let uu____222 = FStar_Syntax_Print.args_to_string args in
                    FStar_Util.format2
                      "Unexpected application of tactic primitive %s %s"
                      uu____221 uu____222 in
                  failwith uu____220
let mk_tactic_interpretation_2:
  'a 'b 'r .
    ('a -> 'b -> 'r FStar_Tactics_Basic.tac) ->
      (FStar_Syntax_Syntax.term -> 'a FStar_Pervasives_Native.option) ->
        (FStar_Syntax_Syntax.term -> 'b FStar_Pervasives_Native.option) ->
          ('r -> FStar_Syntax_Syntax.term) ->
            FStar_Syntax_Syntax.typ ->
              FStar_Ident.lid ->
                FStar_Syntax_Syntax.args ->
                  FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun t  ->
    fun unembed_a  ->
      fun unembed_b  ->
        fun embed_r  ->
          fun t_r  ->
            fun nm  ->
              fun args  ->
                match args with
                | (a,uu____316)::(b,uu____318)::(embedded_state,uu____320)::[]
                    ->
                    let uu____357 =
                      FStar_Tactics_Embedding.unembed_proofstate
                        embedded_state in
                    FStar_Util.bind_opt uu____357
                      (fun ps  ->
                         FStar_Tactics_Basic.log ps
                           (fun uu____368  ->
                              let uu____369 = FStar_Ident.string_of_lid nm in
                              let uu____370 =
                                FStar_Syntax_Print.term_to_string
                                  embedded_state in
                              FStar_Util.print2 "Reached %s, goals are: %s\n"
                                uu____369 uu____370);
                         (let uu____371 = unembed_a a in
                          FStar_Util.bind_opt uu____371
                            (fun a1  ->
                               let uu____377 = unembed_b b in
                               FStar_Util.bind_opt uu____377
                                 (fun b1  ->
                                    let res =
                                      let uu____387 = t a1 b1 in
                                      FStar_Tactics_Basic.run uu____387 ps in
                                    let uu____390 =
                                      FStar_Tactics_Embedding.embed_result ps
                                        res embed_r t_r in
                                    FStar_Pervasives_Native.Some uu____390))))
                | uu____391 ->
                    let uu____392 =
                      let uu____393 = FStar_Ident.string_of_lid nm in
                      let uu____394 = FStar_Syntax_Print.args_to_string args in
                      FStar_Util.format2
                        "Unexpected application of tactic primitive %s %s"
                        uu____393 uu____394 in
                    failwith uu____392
let mk_tactic_interpretation_3:
  'a 'b 'c 'r .
    ('a -> 'b -> 'c -> 'r FStar_Tactics_Basic.tac) ->
      (FStar_Syntax_Syntax.term -> 'a FStar_Pervasives_Native.option) ->
        (FStar_Syntax_Syntax.term -> 'b FStar_Pervasives_Native.option) ->
          (FStar_Syntax_Syntax.term -> 'c FStar_Pervasives_Native.option) ->
            ('r -> FStar_Syntax_Syntax.term) ->
              FStar_Syntax_Syntax.typ ->
                FStar_Ident.lid ->
                  FStar_Syntax_Syntax.args ->
                    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun t  ->
    fun unembed_a  ->
      fun unembed_b  ->
        fun unembed_c  ->
          fun embed_r  ->
            fun t_r  ->
              fun nm  ->
                fun args  ->
                  match args with
                  | (a,uu____511)::(b,uu____513)::(c,uu____515)::(embedded_state,uu____517)::[]
                      ->
                      let uu____564 =
                        FStar_Tactics_Embedding.unembed_proofstate
                          embedded_state in
                      FStar_Util.bind_opt uu____564
                        (fun ps  ->
                           FStar_Tactics_Basic.log ps
                             (fun uu____575  ->
                                let uu____576 = FStar_Ident.string_of_lid nm in
                                let uu____577 =
                                  FStar_Syntax_Print.term_to_string
                                    embedded_state in
                                FStar_Util.print2
                                  "Reached %s, goals are: %s\n" uu____576
                                  uu____577);
                           (let uu____578 = unembed_a a in
                            FStar_Util.bind_opt uu____578
                              (fun a1  ->
                                 let uu____584 = unembed_b b in
                                 FStar_Util.bind_opt uu____584
                                   (fun b1  ->
                                      let uu____590 = unembed_c c in
                                      FStar_Util.bind_opt uu____590
                                        (fun c1  ->
                                           let res =
                                             let uu____600 = t a1 b1 c1 in
                                             FStar_Tactics_Basic.run
                                               uu____600 ps in
                                           let uu____603 =
                                             FStar_Tactics_Embedding.embed_result
                                               ps res embed_r t_r in
                                           FStar_Pervasives_Native.Some
                                             uu____603)))))
                  | uu____604 ->
                      let uu____605 =
                        let uu____606 = FStar_Ident.string_of_lid nm in
                        let uu____607 =
                          FStar_Syntax_Print.args_to_string args in
                        FStar_Util.format2
                          "Unexpected application of tactic primitive %s %s"
                          uu____606 uu____607 in
                      failwith uu____605
let mk_tactic_interpretation_5:
  'a 'b 'c 'd 'e 'r .
    ('a -> 'b -> 'c -> 'd -> 'e -> 'r FStar_Tactics_Basic.tac) ->
      (FStar_Syntax_Syntax.term -> 'a FStar_Pervasives_Native.option) ->
        (FStar_Syntax_Syntax.term -> 'b FStar_Pervasives_Native.option) ->
          (FStar_Syntax_Syntax.term -> 'c FStar_Pervasives_Native.option) ->
            (FStar_Syntax_Syntax.term -> 'd FStar_Pervasives_Native.option)
              ->
              (FStar_Syntax_Syntax.term -> 'e FStar_Pervasives_Native.option)
                ->
                ('r -> FStar_Syntax_Syntax.term) ->
                  FStar_Syntax_Syntax.typ ->
                    FStar_Ident.lid ->
                      FStar_Syntax_Syntax.args ->
                        FStar_Syntax_Syntax.term
                          FStar_Pervasives_Native.option
  =
  fun t  ->
    fun unembed_a  ->
      fun unembed_b  ->
        fun unembed_c  ->
          fun unembed_d  ->
            fun unembed_e  ->
              fun embed_r  ->
                fun t_r  ->
                  fun nm  ->
                    fun args  ->
                      match args with
                      | (a,uu____770)::(b,uu____772)::(c,uu____774)::
                          (d,uu____776)::(e,uu____778)::(embedded_state,uu____780)::[]
                          ->
                          let uu____847 =
                            FStar_Tactics_Embedding.unembed_proofstate
                              embedded_state in
                          FStar_Util.bind_opt uu____847
                            (fun ps  ->
                               FStar_Tactics_Basic.log ps
                                 (fun uu____858  ->
                                    let uu____859 =
                                      FStar_Ident.string_of_lid nm in
                                    let uu____860 =
                                      FStar_Syntax_Print.term_to_string
                                        embedded_state in
                                    FStar_Util.print2
                                      "Reached %s, goals are: %s\n" uu____859
                                      uu____860);
                               (let uu____861 = unembed_a a in
                                FStar_Util.bind_opt uu____861
                                  (fun a1  ->
                                     let uu____867 = unembed_b b in
                                     FStar_Util.bind_opt uu____867
                                       (fun b1  ->
                                          let uu____873 = unembed_c c in
                                          FStar_Util.bind_opt uu____873
                                            (fun c1  ->
                                               let uu____879 = unembed_d d in
                                               FStar_Util.bind_opt uu____879
                                                 (fun d1  ->
                                                    let uu____885 =
                                                      unembed_e e in
                                                    FStar_Util.bind_opt
                                                      uu____885
                                                      (fun e1  ->
                                                         let res =
                                                           let uu____895 =
                                                             t a1 b1 c1 d1 e1 in
                                                           FStar_Tactics_Basic.run
                                                             uu____895 ps in
                                                         let uu____898 =
                                                           FStar_Tactics_Embedding.embed_result
                                                             ps res embed_r
                                                             t_r in
                                                         FStar_Pervasives_Native.Some
                                                           uu____898)))))))
                      | uu____899 ->
                          let uu____900 =
                            let uu____901 = FStar_Ident.string_of_lid nm in
                            let uu____902 =
                              FStar_Syntax_Print.args_to_string args in
                            FStar_Util.format2
                              "Unexpected application of tactic primitive %s %s"
                              uu____901 uu____902 in
                          failwith uu____900
let step_from_native_step:
  FStar_Tactics_Native.native_primitive_step ->
    FStar_TypeChecker_Normalize.primitive_step
  =
  fun s  ->
    {
      FStar_TypeChecker_Normalize.name = (s.FStar_Tactics_Native.name);
      FStar_TypeChecker_Normalize.arity = (s.FStar_Tactics_Native.arity);
      FStar_TypeChecker_Normalize.strong_reduction_ok =
        (s.FStar_Tactics_Native.strong_reduction_ok);
      FStar_TypeChecker_Normalize.interpretation =
        (fun _rng  -> fun args  -> s.FStar_Tactics_Native.tactic args)
    }
let rec primitive_steps:
  Prims.unit -> FStar_TypeChecker_Normalize.primitive_step Prims.list =
  fun uu____953  ->
    let mk1 nm arity interpretation =
      let nm1 = FStar_Tactics_Embedding.fstar_tactics_lid' ["Builtins"; nm] in
      {
        FStar_TypeChecker_Normalize.name = nm1;
        FStar_TypeChecker_Normalize.arity = arity;
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.interpretation =
          (fun _rng  -> fun args  -> interpretation nm1 args)
      } in
    let native_tactics = FStar_Tactics_Native.list_all () in
    let native_tactics_steps =
      FStar_List.map step_from_native_step native_tactics in
    let mktac0 name f e_r tr =
      mk1 name (Prims.parse_int "1") (mk_tactic_interpretation_0 f e_r tr) in
    let mktac1 name f u_a e_r tr =
      mk1 name (Prims.parse_int "2")
        (mk_tactic_interpretation_1 f u_a e_r tr) in
    let mktac2 name f u_a u_b e_r tr =
      mk1 name (Prims.parse_int "3")
        (mk_tactic_interpretation_2 f u_a u_b e_r tr) in
    let mktac3 name f u_a u_b u_c e_r tr =
      mk1 name (Prims.parse_int "4")
        (mk_tactic_interpretation_3 f u_a u_b u_c e_r tr) in
    let mktac5 name f u_a u_b u_c u_d u_e e_r tr =
      mk1 name (Prims.parse_int "6")
        (mk_tactic_interpretation_5 f u_a u_b u_c u_d u_e e_r tr) in
    let decr_depth_interp rng args =
      match args with
      | (ps,uu____1394)::[] ->
          let uu____1411 = FStar_Tactics_Embedding.unembed_proofstate ps in
          FStar_Util.bind_opt uu____1411
            (fun ps1  ->
               let uu____1417 =
                 let uu____1418 = FStar_Tactics_Types.decr_depth ps1 in
                 FStar_Tactics_Embedding.embed_proofstate uu____1418 in
               FStar_Pervasives_Native.Some uu____1417)
      | uu____1419 -> failwith "Unexpected application of decr_depth" in
    let decr_depth_step =
      let uu____1423 =
        FStar_Ident.lid_of_str "FStar.Tactics.Types.decr_depth" in
      {
        FStar_TypeChecker_Normalize.name = uu____1423;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "1");
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.interpretation = decr_depth_interp
      } in
    let incr_depth_interp rng args =
      match args with
      | (ps,uu____1436)::[] ->
          let uu____1453 = FStar_Tactics_Embedding.unembed_proofstate ps in
          FStar_Util.bind_opt uu____1453
            (fun ps1  ->
               let uu____1459 =
                 let uu____1460 = FStar_Tactics_Types.incr_depth ps1 in
                 FStar_Tactics_Embedding.embed_proofstate uu____1460 in
               FStar_Pervasives_Native.Some uu____1459)
      | uu____1461 -> failwith "Unexpected application of incr_depth" in
    let incr_depth_step =
      let uu____1465 =
        FStar_Ident.lid_of_str "FStar.Tactics.Types.incr_depth" in
      {
        FStar_TypeChecker_Normalize.name = uu____1465;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "1");
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.interpretation = incr_depth_interp
      } in
    let tracepoint_interp rng args =
      match args with
      | (ps,uu____1482)::[] ->
          let uu____1499 = FStar_Tactics_Embedding.unembed_proofstate ps in
          FStar_Util.bind_opt uu____1499
            (fun ps1  ->
               FStar_Tactics_Types.tracepoint ps1;
               FStar_Pervasives_Native.Some FStar_Syntax_Util.exp_unit)
      | uu____1510 -> failwith "Unexpected application of tracepoint" in
    let tracepoint_step =
      let nm = FStar_Ident.lid_of_str "FStar.Tactics.Types.tracepoint" in
      {
        FStar_TypeChecker_Normalize.name = nm;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "1");
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.interpretation = tracepoint_interp
      } in
    let uu____1517 =
      let uu____1520 =
        mktac0 "__trivial" FStar_Tactics_Basic.trivial
          FStar_Syntax_Embeddings.embed_unit FStar_Syntax_Syntax.t_unit in
      let uu____1521 =
        let uu____1524 =
          mktac2 "__trytac" (fun uu____1530  -> FStar_Tactics_Basic.trytac)
            (fun _0_65  -> FStar_Pervasives_Native.Some _0_65)
            (unembed_tactic_0'
               (fun _0_66  -> FStar_Pervasives_Native.Some _0_66))
            (FStar_Syntax_Embeddings.embed_option (fun t  -> t)
               FStar_Syntax_Syntax.t_unit) FStar_Syntax_Syntax.t_unit in
        let uu____1533 =
          let uu____1536 =
            mktac0 "__intro" FStar_Tactics_Basic.intro
              FStar_Reflection_Basic.embed_binder
              FStar_Reflection_Data.fstar_refl_binder in
          let uu____1537 =
            let uu____1540 =
              let uu____1541 =
                FStar_Tactics_Embedding.pair_typ
                  FStar_Reflection_Data.fstar_refl_binder
                  FStar_Reflection_Data.fstar_refl_binder in
              mktac0 "__intro_rec" FStar_Tactics_Basic.intro_rec
                (FStar_Syntax_Embeddings.embed_pair
                   FStar_Reflection_Basic.embed_binder
                   FStar_Reflection_Data.fstar_refl_binder
                   FStar_Reflection_Basic.embed_binder
                   FStar_Reflection_Data.fstar_refl_binder) uu____1541 in
            let uu____1546 =
              let uu____1549 =
                mktac1 "__norm" FStar_Tactics_Basic.norm
                  (FStar_Syntax_Embeddings.unembed_list
                     FStar_Syntax_Embeddings.unembed_norm_step)
                  FStar_Syntax_Embeddings.embed_unit
                  FStar_Syntax_Syntax.t_unit in
              let uu____1552 =
                let uu____1555 =
                  mktac3 "__norm_term_env" FStar_Tactics_Basic.norm_term_env
                    FStar_Reflection_Basic.unembed_env
                    (FStar_Syntax_Embeddings.unembed_list
                       FStar_Syntax_Embeddings.unembed_norm_step)
                    FStar_Reflection_Basic.unembed_term
                    FStar_Reflection_Basic.embed_term
                    FStar_Syntax_Syntax.t_term in
                let uu____1558 =
                  let uu____1561 =
                    mktac2 "__rename_to" FStar_Tactics_Basic.rename_to
                      FStar_Reflection_Basic.unembed_binder
                      FStar_Syntax_Embeddings.unembed_string
                      FStar_Syntax_Embeddings.embed_unit
                      FStar_Syntax_Syntax.t_unit in
                  let uu____1562 =
                    let uu____1565 =
                      mktac1 "__binder_retype"
                        FStar_Tactics_Basic.binder_retype
                        FStar_Reflection_Basic.unembed_binder
                        FStar_Syntax_Embeddings.embed_unit
                        FStar_Syntax_Syntax.t_unit in
                    let uu____1566 =
                      let uu____1569 =
                        mktac0 "__revert" FStar_Tactics_Basic.revert
                          FStar_Syntax_Embeddings.embed_unit
                          FStar_Syntax_Syntax.t_unit in
                      let uu____1570 =
                        let uu____1573 =
                          mktac0 "__clear_top" FStar_Tactics_Basic.clear_top
                            FStar_Syntax_Embeddings.embed_unit
                            FStar_Syntax_Syntax.t_unit in
                        let uu____1574 =
                          let uu____1577 =
                            mktac1 "__clear" FStar_Tactics_Basic.clear
                              FStar_Reflection_Basic.unembed_binder
                              FStar_Syntax_Embeddings.embed_unit
                              FStar_Syntax_Syntax.t_unit in
                          let uu____1578 =
                            let uu____1581 =
                              mktac1 "__rewrite" FStar_Tactics_Basic.rewrite
                                FStar_Reflection_Basic.unembed_binder
                                FStar_Syntax_Embeddings.embed_unit
                                FStar_Syntax_Syntax.t_unit in
                            let uu____1582 =
                              let uu____1585 =
                                mktac0 "__smt" FStar_Tactics_Basic.smt
                                  FStar_Syntax_Embeddings.embed_unit
                                  FStar_Syntax_Syntax.t_unit in
                              let uu____1586 =
                                let uu____1589 =
                                  mktac1 "__exact" FStar_Tactics_Basic.exact
                                    FStar_Reflection_Basic.unembed_term
                                    FStar_Syntax_Embeddings.embed_unit
                                    FStar_Syntax_Syntax.t_unit in
                                let uu____1590 =
                                  let uu____1593 =
                                    mktac1 "__apply"
                                      (FStar_Tactics_Basic.apply true)
                                      FStar_Reflection_Basic.unembed_term
                                      FStar_Syntax_Embeddings.embed_unit
                                      FStar_Syntax_Syntax.t_unit in
                                  let uu____1594 =
                                    let uu____1597 =
                                      mktac1 "__apply_raw"
                                        (FStar_Tactics_Basic.apply false)
                                        FStar_Reflection_Basic.unembed_term
                                        FStar_Syntax_Embeddings.embed_unit
                                        FStar_Syntax_Syntax.t_unit in
                                    let uu____1598 =
                                      let uu____1601 =
                                        mktac1 "__apply_lemma"
                                          FStar_Tactics_Basic.apply_lemma
                                          FStar_Reflection_Basic.unembed_term
                                          FStar_Syntax_Embeddings.embed_unit
                                          FStar_Syntax_Syntax.t_unit in
                                      let uu____1602 =
                                        let uu____1605 =
                                          mktac5 "__divide"
                                            (fun uu____1616  ->
                                               fun uu____1617  ->
                                                 FStar_Tactics_Basic.divide)
                                            (fun _0_67  ->
                                               FStar_Pervasives_Native.Some
                                                 _0_67)
                                            (fun _0_68  ->
                                               FStar_Pervasives_Native.Some
                                                 _0_68)
                                            FStar_Syntax_Embeddings.unembed_int
                                            (unembed_tactic_0'
                                               (fun _0_69  ->
                                                  FStar_Pervasives_Native.Some
                                                    _0_69))
                                            (unembed_tactic_0'
                                               (fun _0_70  ->
                                                  FStar_Pervasives_Native.Some
                                                    _0_70))
                                            (FStar_Syntax_Embeddings.embed_pair
                                               (fun t  -> t)
                                               FStar_Syntax_Syntax.t_unit
                                               (fun t  -> t)
                                               FStar_Syntax_Syntax.t_unit)
                                            FStar_Syntax_Syntax.t_unit in
                                        let uu____1622 =
                                          let uu____1625 =
                                            mktac1 "__set_options"
                                              FStar_Tactics_Basic.set_options
                                              FStar_Syntax_Embeddings.unembed_string
                                              FStar_Syntax_Embeddings.embed_unit
                                              FStar_Syntax_Syntax.t_unit in
                                          let uu____1626 =
                                            let uu____1629 =
                                              mktac2 "__seq"
                                                FStar_Tactics_Basic.seq
                                                (unembed_tactic_0'
                                                   FStar_Syntax_Embeddings.unembed_unit)
                                                (unembed_tactic_0'
                                                   FStar_Syntax_Embeddings.unembed_unit)
                                                FStar_Syntax_Embeddings.embed_unit
                                                FStar_Syntax_Syntax.t_unit in
                                            let uu____1634 =
                                              let uu____1637 =
                                                mktac1 "__tc"
                                                  FStar_Tactics_Basic.tc
                                                  FStar_Reflection_Basic.unembed_term
                                                  FStar_Reflection_Basic.embed_term
                                                  FStar_Syntax_Syntax.t_term in
                                              let uu____1638 =
                                                let uu____1641 =
                                                  mktac1 "__unshelve"
                                                    FStar_Tactics_Basic.unshelve
                                                    FStar_Reflection_Basic.unembed_term
                                                    FStar_Syntax_Embeddings.embed_unit
                                                    FStar_Syntax_Syntax.t_unit in
                                                let uu____1642 =
                                                  let uu____1645 =
                                                    mktac2 "__unquote"
                                                      FStar_Tactics_Basic.unquote
                                                      (fun _0_71  ->
                                                         FStar_Pervasives_Native.Some
                                                           _0_71)
                                                      FStar_Reflection_Basic.unembed_term
                                                      (fun t  -> t)
                                                      FStar_Syntax_Syntax.t_unit in
                                                  let uu____1648 =
                                                    let uu____1651 =
                                                      mktac1 "__prune"
                                                        FStar_Tactics_Basic.prune
                                                        FStar_Syntax_Embeddings.unembed_string
                                                        FStar_Syntax_Embeddings.embed_unit
                                                        FStar_Syntax_Syntax.t_unit in
                                                    let uu____1652 =
                                                      let uu____1655 =
                                                        mktac1 "__addns"
                                                          FStar_Tactics_Basic.addns
                                                          FStar_Syntax_Embeddings.unembed_string
                                                          FStar_Syntax_Embeddings.embed_unit
                                                          FStar_Syntax_Syntax.t_unit in
                                                      let uu____1656 =
                                                        let uu____1659 =
                                                          mktac1 "__print"
                                                            (fun x  ->
                                                               FStar_Tactics_Basic.tacprint
                                                                 x;
                                                               FStar_Tactics_Basic.ret
                                                                 ())
                                                            FStar_Syntax_Embeddings.unembed_string
                                                            FStar_Syntax_Embeddings.embed_unit
                                                            FStar_Syntax_Syntax.t_unit in
                                                        let uu____1664 =
                                                          let uu____1667 =
                                                            mktac1 "__dump"
                                                              FStar_Tactics_Basic.print_proof_state
                                                              FStar_Syntax_Embeddings.unembed_string
                                                              FStar_Syntax_Embeddings.embed_unit
                                                              FStar_Syntax_Syntax.t_unit in
                                                          let uu____1668 =
                                                            let uu____1671 =
                                                              mktac1
                                                                "__dump1"
                                                                FStar_Tactics_Basic.print_proof_state1
                                                                FStar_Syntax_Embeddings.unembed_string
                                                                FStar_Syntax_Embeddings.embed_unit
                                                                FStar_Syntax_Syntax.t_unit in
                                                            let uu____1672 =
                                                              let uu____1675
                                                                =
                                                                mktac2
                                                                  "__pointwise"
                                                                  FStar_Tactics_Basic.pointwise
                                                                  FStar_Tactics_Embedding.unembed_direction
                                                                  (unembed_tactic_0'
                                                                    FStar_Syntax_Embeddings.unembed_unit)
                                                                  FStar_Syntax_Embeddings.embed_unit
                                                                  FStar_Syntax_Syntax.t_unit in
                                                              let uu____1678
                                                                =
                                                                let uu____1681
                                                                  =
                                                                  mktac0
                                                                    "__trefl"
                                                                    FStar_Tactics_Basic.trefl
                                                                    FStar_Syntax_Embeddings.embed_unit
                                                                    FStar_Syntax_Syntax.t_unit in
                                                                let uu____1682
                                                                  =
                                                                  let uu____1685
                                                                    =
                                                                    mktac0
                                                                    "__later"
                                                                    FStar_Tactics_Basic.later
                                                                    FStar_Syntax_Embeddings.embed_unit
                                                                    FStar_Syntax_Syntax.t_unit in
                                                                  let uu____1686
                                                                    =
                                                                    let uu____1689
                                                                    =
                                                                    mktac0
                                                                    "__dup"
                                                                    FStar_Tactics_Basic.dup
                                                                    FStar_Syntax_Embeddings.embed_unit
                                                                    FStar_Syntax_Syntax.t_unit in
                                                                    let uu____1690
                                                                    =
                                                                    let uu____1693
                                                                    =
                                                                    mktac0
                                                                    "__flip"
                                                                    FStar_Tactics_Basic.flip
                                                                    FStar_Syntax_Embeddings.embed_unit
                                                                    FStar_Syntax_Syntax.t_unit in
                                                                    let uu____1694
                                                                    =
                                                                    let uu____1697
                                                                    =
                                                                    mktac0
                                                                    "__qed"
                                                                    FStar_Tactics_Basic.qed
                                                                    FStar_Syntax_Embeddings.embed_unit
                                                                    FStar_Syntax_Syntax.t_unit in
                                                                    let uu____1698
                                                                    =
                                                                    let uu____1701
                                                                    =
                                                                    let uu____1702
                                                                    =
                                                                    FStar_Tactics_Embedding.pair_typ
                                                                    FStar_Syntax_Syntax.t_term
                                                                    FStar_Syntax_Syntax.t_term in
                                                                    mktac1
                                                                    "__cases"
                                                                    FStar_Tactics_Basic.cases
                                                                    FStar_Reflection_Basic.unembed_term
                                                                    (FStar_Syntax_Embeddings.embed_pair
                                                                    FStar_Reflection_Basic.embed_term
                                                                    FStar_Syntax_Syntax.t_term
                                                                    FStar_Reflection_Basic.embed_term
                                                                    FStar_Syntax_Syntax.t_term)
                                                                    uu____1702 in
                                                                    let uu____1707
                                                                    =
                                                                    let uu____1710
                                                                    =
                                                                    mktac0
                                                                    "__top_env"
                                                                    FStar_Tactics_Basic.top_env
                                                                    FStar_Reflection_Basic.embed_env
                                                                    FStar_Reflection_Data.fstar_refl_env in
                                                                    let uu____1711
                                                                    =
                                                                    let uu____1714
                                                                    =
                                                                    mktac0
                                                                    "__cur_env"
                                                                    FStar_Tactics_Basic.cur_env
                                                                    FStar_Reflection_Basic.embed_env
                                                                    FStar_Reflection_Data.fstar_refl_env in
                                                                    let uu____1715
                                                                    =
                                                                    let uu____1718
                                                                    =
                                                                    mktac0
                                                                    "__cur_goal"
                                                                    FStar_Tactics_Basic.cur_goal'
                                                                    FStar_Reflection_Basic.embed_term
                                                                    FStar_Syntax_Syntax.t_term in
                                                                    let uu____1719
                                                                    =
                                                                    let uu____1722
                                                                    =
                                                                    mktac0
                                                                    "__cur_witness"
                                                                    FStar_Tactics_Basic.cur_witness
                                                                    FStar_Reflection_Basic.embed_term
                                                                    FStar_Syntax_Syntax.t_term in
                                                                    let uu____1723
                                                                    =
                                                                    let uu____1726
                                                                    =
                                                                    mktac2
                                                                    "__uvar_env"
                                                                    FStar_Tactics_Basic.uvar_env
                                                                    FStar_Reflection_Basic.unembed_env
                                                                    (FStar_Syntax_Embeddings.unembed_option
                                                                    FStar_Reflection_Basic.unembed_term)
                                                                    FStar_Reflection_Basic.embed_term
                                                                    FStar_Syntax_Syntax.t_term in
                                                                    let uu____1729
                                                                    =
                                                                    let uu____1732
                                                                    =
                                                                    mktac2
                                                                    "__unify"
                                                                    FStar_Tactics_Basic.unify
                                                                    FStar_Reflection_Basic.unembed_term
                                                                    FStar_Reflection_Basic.unembed_term
                                                                    FStar_Syntax_Embeddings.embed_bool
                                                                    FStar_Syntax_Syntax.t_bool in
                                                                    let uu____1733
                                                                    =
                                                                    let uu____1736
                                                                    =
                                                                    mktac3
                                                                    "__launch_process"
                                                                    FStar_Tactics_Basic.launch_process
                                                                    FStar_Syntax_Embeddings.unembed_string
                                                                    FStar_Syntax_Embeddings.unembed_string
                                                                    FStar_Syntax_Embeddings.unembed_string
                                                                    FStar_Syntax_Embeddings.embed_string
                                                                    FStar_Syntax_Syntax.t_string in
                                                                    [uu____1736;
                                                                    decr_depth_step;
                                                                    incr_depth_step;
                                                                    tracepoint_step] in
                                                                    uu____1732
                                                                    ::
                                                                    uu____1733 in
                                                                    uu____1726
                                                                    ::
                                                                    uu____1729 in
                                                                    uu____1722
                                                                    ::
                                                                    uu____1723 in
                                                                    uu____1718
                                                                    ::
                                                                    uu____1719 in
                                                                    uu____1714
                                                                    ::
                                                                    uu____1715 in
                                                                    uu____1710
                                                                    ::
                                                                    uu____1711 in
                                                                    uu____1701
                                                                    ::
                                                                    uu____1707 in
                                                                    uu____1697
                                                                    ::
                                                                    uu____1698 in
                                                                    uu____1693
                                                                    ::
                                                                    uu____1694 in
                                                                    uu____1689
                                                                    ::
                                                                    uu____1690 in
                                                                  uu____1685
                                                                    ::
                                                                    uu____1686 in
                                                                uu____1681 ::
                                                                  uu____1682 in
                                                              uu____1675 ::
                                                                uu____1678 in
                                                            uu____1671 ::
                                                              uu____1672 in
                                                          uu____1667 ::
                                                            uu____1668 in
                                                        uu____1659 ::
                                                          uu____1664 in
                                                      uu____1655 ::
                                                        uu____1656 in
                                                    uu____1651 :: uu____1652 in
                                                  uu____1645 :: uu____1648 in
                                                uu____1641 :: uu____1642 in
                                              uu____1637 :: uu____1638 in
                                            uu____1629 :: uu____1634 in
                                          uu____1625 :: uu____1626 in
                                        uu____1605 :: uu____1622 in
                                      uu____1601 :: uu____1602 in
                                    uu____1597 :: uu____1598 in
                                  uu____1593 :: uu____1594 in
                                uu____1589 :: uu____1590 in
                              uu____1585 :: uu____1586 in
                            uu____1581 :: uu____1582 in
                          uu____1577 :: uu____1578 in
                        uu____1573 :: uu____1574 in
                      uu____1569 :: uu____1570 in
                    uu____1565 :: uu____1566 in
                  uu____1561 :: uu____1562 in
                uu____1555 :: uu____1558 in
              uu____1549 :: uu____1552 in
            uu____1540 :: uu____1546 in
          uu____1536 :: uu____1537 in
        uu____1524 :: uu____1533 in
      uu____1520 :: uu____1521 in
    FStar_List.append uu____1517
      (FStar_List.append FStar_Reflection_Interpreter.reflection_primops
         native_tactics_steps)
and unembed_tactic_0:
  'Ab .
    (FStar_Syntax_Syntax.term -> 'Ab FStar_Pervasives_Native.option) ->
      FStar_Syntax_Syntax.term -> 'Ab FStar_Tactics_Basic.tac
  =
  fun unembed_b  ->
    fun embedded_tac_b  ->
      FStar_Tactics_Basic.bind FStar_Tactics_Basic.get
        (fun proof_state  ->
           let tm =
             let uu____1757 =
               let uu____1758 =
                 let uu____1759 =
                   let uu____1760 =
                     FStar_Tactics_Embedding.embed_proofstate proof_state in
                   FStar_Syntax_Syntax.as_arg uu____1760 in
                 [uu____1759] in
               FStar_Syntax_Syntax.mk_Tm_app embedded_tac_b uu____1758 in
             uu____1757 FStar_Pervasives_Native.None FStar_Range.dummyRange in
           let steps =
             [FStar_TypeChecker_Normalize.Reify;
             FStar_TypeChecker_Normalize.UnfoldUntil
               FStar_Syntax_Syntax.Delta_constant;
             FStar_TypeChecker_Normalize.UnfoldTac;
             FStar_TypeChecker_Normalize.Primops] in
           (let uu____1767 = FStar_ST.op_Bang tacdbg in
            if uu____1767
            then
              let uu____1814 = FStar_Syntax_Print.term_to_string tm in
              FStar_Util.print1 "Starting normalizer with %s\n" uu____1814
            else ());
           (let result =
              let uu____1817 = primitive_steps () in
              FStar_TypeChecker_Normalize.normalize_with_primitive_steps
                uu____1817 steps proof_state.FStar_Tactics_Types.main_context
                tm in
            (let uu____1821 = FStar_ST.op_Bang tacdbg in
             if uu____1821
             then
               let uu____1868 = FStar_Syntax_Print.term_to_string result in
               FStar_Util.print1 "Reduced tactic: got %s\n" uu____1868
             else ());
            (let uu____1870 =
               FStar_Tactics_Embedding.unembed_result proof_state result
                 unembed_b in
             match uu____1870 with
             | FStar_Pervasives_Native.Some (FStar_Util.Inl (b,ps)) ->
                 let uu____1909 = FStar_Tactics_Basic.set ps in
                 FStar_Tactics_Basic.bind uu____1909
                   (fun uu____1913  -> FStar_Tactics_Basic.ret b)
             | FStar_Pervasives_Native.Some (FStar_Util.Inr (msg,ps)) ->
                 let uu____1936 = FStar_Tactics_Basic.set ps in
                 FStar_Tactics_Basic.bind uu____1936
                   (fun uu____1940  -> FStar_Tactics_Basic.fail msg)
             | FStar_Pervasives_Native.None  ->
                 let uu____1953 =
                   let uu____1954 =
                     let uu____1959 =
                       let uu____1960 =
                         FStar_Syntax_Print.term_to_string result in
                       FStar_Util.format1
                         "Tactic got stuck! Please file a bug report with a minimal reproduction of this issue.\n%s"
                         uu____1960 in
                     (uu____1959,
                       ((proof_state.FStar_Tactics_Types.main_context).FStar_TypeChecker_Env.range)) in
                   FStar_Errors.Error uu____1954 in
                 FStar_Exn.raise uu____1953)))
and unembed_tactic_0':
  'Ab .
    (FStar_Syntax_Syntax.term -> 'Ab FStar_Pervasives_Native.option) ->
      FStar_Syntax_Syntax.term ->
        'Ab FStar_Tactics_Basic.tac FStar_Pervasives_Native.option
  =
  fun unembed_b  ->
    fun embedded_tac_b  ->
      let uu____1969 = unembed_tactic_0 unembed_b embedded_tac_b in
      FStar_All.pipe_left (fun _0_72  -> FStar_Pervasives_Native.Some _0_72)
        uu____1969
let report_implicits:
  FStar_Tactics_Types.proofstate ->
    FStar_TypeChecker_Env.implicits -> Prims.unit
  =
  fun ps  ->
    fun is  ->
      let errs =
        FStar_List.map
          (fun uu____2019  ->
             match uu____2019 with
             | (r,uu____2037,uv,uu____2039,ty,rng) ->
                 let uu____2042 =
                   let uu____2043 = FStar_Syntax_Print.uvar_to_string uv in
                   let uu____2044 = FStar_Syntax_Print.term_to_string ty in
                   FStar_Util.format3
                     "Tactic left uninstantiated unification variable %s of type %s (reason = \"%s\")"
                     uu____2043 uu____2044 r in
                 (uu____2042, rng)) is in
      match errs with
      | [] -> ()
      | hd1::tl1 ->
          (FStar_Tactics_Basic.dump_proofstate ps
             "failing due to uninstantiated implicits";
           FStar_Errors.add_errors tl1;
           FStar_Exn.raise (FStar_Errors.Error hd1))
let run_tactic_on_typ:
  FStar_Syntax_Syntax.term ->
    FStar_Tactics_Basic.env ->
      FStar_Syntax_Syntax.typ ->
        (FStar_Tactics_Types.goal Prims.list,FStar_Syntax_Syntax.term)
          FStar_Pervasives_Native.tuple2
  =
  fun tactic  ->
    fun env  ->
      fun typ  ->
        (let uu____2092 = FStar_ST.op_Bang tacdbg in
         if uu____2092
         then
           let uu____2139 = FStar_Syntax_Print.term_to_string tactic in
           FStar_Util.print1 "About to reduce uvars on: %s\n" uu____2139
         else ());
        (let tactic1 =
           FStar_TypeChecker_Normalize.reduce_uvar_solutions env tactic in
         (let uu____2143 = FStar_ST.op_Bang tacdbg in
          if uu____2143
          then
            let uu____2190 = FStar_Syntax_Print.term_to_string tactic1 in
            FStar_Util.print1 "About to check tactic term: %s\n" uu____2190
          else ());
         (let uu____2192 =
            FStar_TypeChecker_TcTerm.tc_reified_tactic env tactic1 in
          match uu____2192 with
          | (tactic2,uu____2206,g) ->
              (FStar_TypeChecker_Rel.force_trivial_guard env g;
               FStar_Errors.stop_if_err ();
               (let tau =
                  unembed_tactic_0 FStar_Syntax_Embeddings.unembed_unit
                    tactic2 in
                let uu____2213 = FStar_TypeChecker_Env.clear_expected_typ env in
                match uu____2213 with
                | (env1,uu____2227) ->
                    let env2 =
                      let uu___163_2233 = env1 in
                      {
                        FStar_TypeChecker_Env.solver =
                          (uu___163_2233.FStar_TypeChecker_Env.solver);
                        FStar_TypeChecker_Env.range =
                          (uu___163_2233.FStar_TypeChecker_Env.range);
                        FStar_TypeChecker_Env.curmodule =
                          (uu___163_2233.FStar_TypeChecker_Env.curmodule);
                        FStar_TypeChecker_Env.gamma =
                          (uu___163_2233.FStar_TypeChecker_Env.gamma);
                        FStar_TypeChecker_Env.gamma_cache =
                          (uu___163_2233.FStar_TypeChecker_Env.gamma_cache);
                        FStar_TypeChecker_Env.modules =
                          (uu___163_2233.FStar_TypeChecker_Env.modules);
                        FStar_TypeChecker_Env.expected_typ =
                          (uu___163_2233.FStar_TypeChecker_Env.expected_typ);
                        FStar_TypeChecker_Env.sigtab =
                          (uu___163_2233.FStar_TypeChecker_Env.sigtab);
                        FStar_TypeChecker_Env.is_pattern =
                          (uu___163_2233.FStar_TypeChecker_Env.is_pattern);
                        FStar_TypeChecker_Env.instantiate_imp = false;
                        FStar_TypeChecker_Env.effects =
                          (uu___163_2233.FStar_TypeChecker_Env.effects);
                        FStar_TypeChecker_Env.generalize =
                          (uu___163_2233.FStar_TypeChecker_Env.generalize);
                        FStar_TypeChecker_Env.letrecs =
                          (uu___163_2233.FStar_TypeChecker_Env.letrecs);
                        FStar_TypeChecker_Env.top_level =
                          (uu___163_2233.FStar_TypeChecker_Env.top_level);
                        FStar_TypeChecker_Env.check_uvars =
                          (uu___163_2233.FStar_TypeChecker_Env.check_uvars);
                        FStar_TypeChecker_Env.use_eq =
                          (uu___163_2233.FStar_TypeChecker_Env.use_eq);
                        FStar_TypeChecker_Env.is_iface =
                          (uu___163_2233.FStar_TypeChecker_Env.is_iface);
                        FStar_TypeChecker_Env.admit =
                          (uu___163_2233.FStar_TypeChecker_Env.admit);
                        FStar_TypeChecker_Env.lax =
                          (uu___163_2233.FStar_TypeChecker_Env.lax);
                        FStar_TypeChecker_Env.lax_universes =
                          (uu___163_2233.FStar_TypeChecker_Env.lax_universes);
                        FStar_TypeChecker_Env.failhard =
                          (uu___163_2233.FStar_TypeChecker_Env.failhard);
                        FStar_TypeChecker_Env.nosynth =
                          (uu___163_2233.FStar_TypeChecker_Env.nosynth);
                        FStar_TypeChecker_Env.tc_term =
                          (uu___163_2233.FStar_TypeChecker_Env.tc_term);
                        FStar_TypeChecker_Env.type_of =
                          (uu___163_2233.FStar_TypeChecker_Env.type_of);
                        FStar_TypeChecker_Env.universe_of =
                          (uu___163_2233.FStar_TypeChecker_Env.universe_of);
                        FStar_TypeChecker_Env.use_bv_sorts =
                          (uu___163_2233.FStar_TypeChecker_Env.use_bv_sorts);
                        FStar_TypeChecker_Env.qname_and_index =
                          (uu___163_2233.FStar_TypeChecker_Env.qname_and_index);
                        FStar_TypeChecker_Env.proof_ns =
                          (uu___163_2233.FStar_TypeChecker_Env.proof_ns);
                        FStar_TypeChecker_Env.synth =
                          (uu___163_2233.FStar_TypeChecker_Env.synth);
                        FStar_TypeChecker_Env.is_native_tactic =
                          (uu___163_2233.FStar_TypeChecker_Env.is_native_tactic);
                        FStar_TypeChecker_Env.identifier_info =
                          (uu___163_2233.FStar_TypeChecker_Env.identifier_info);
                        FStar_TypeChecker_Env.tc_hooks =
                          (uu___163_2233.FStar_TypeChecker_Env.tc_hooks);
                        FStar_TypeChecker_Env.dsenv =
                          (uu___163_2233.FStar_TypeChecker_Env.dsenv)
                      } in
                    let uu____2234 =
                      FStar_Tactics_Basic.proofstate_of_goal_ty env2 typ in
                    (match uu____2234 with
                     | (ps,w) ->
                         ((let uu____2248 = FStar_ST.op_Bang tacdbg in
                           if uu____2248
                           then FStar_Util.print_string "Running tactic.\n"
                           else ());
                          (let uu____2296 = FStar_Tactics_Basic.run tau ps in
                           match uu____2296 with
                           | FStar_Tactics_Result.Success (uu____2305,ps1) ->
                               ((let uu____2308 = FStar_ST.op_Bang tacdbg in
                                 if uu____2308
                                 then
                                   let uu____2355 =
                                     FStar_Syntax_Print.term_to_string w in
                                   FStar_Util.print1
                                     "Tactic generated proofterm %s\n"
                                     uu____2355
                                 else ());
                                FStar_List.iter
                                  (fun g1  ->
                                     let uu____2362 =
                                       FStar_Tactics_Basic.is_irrelevant g1 in
                                     if uu____2362
                                     then
                                       let uu____2363 =
                                         FStar_TypeChecker_Rel.teq_nosmt
                                           g1.FStar_Tactics_Types.context
                                           g1.FStar_Tactics_Types.witness
                                           FStar_Syntax_Util.exp_unit in
                                       (if uu____2363
                                        then ()
                                        else
                                          (let uu____2365 =
                                             let uu____2366 =
                                               FStar_Syntax_Print.term_to_string
                                                 g1.FStar_Tactics_Types.witness in
                                             FStar_Util.format1
                                               "Irrelevant tactic witness does not unify with (): %s"
                                               uu____2366 in
                                           failwith uu____2365))
                                     else ())
                                  (FStar_List.append
                                     ps1.FStar_Tactics_Types.goals
                                     ps1.FStar_Tactics_Types.smt_goals);
                                (let g1 =
                                   let uu___164_2369 =
                                     FStar_TypeChecker_Rel.trivial_guard in
                                   {
                                     FStar_TypeChecker_Env.guard_f =
                                       (uu___164_2369.FStar_TypeChecker_Env.guard_f);
                                     FStar_TypeChecker_Env.deferred =
                                       (uu___164_2369.FStar_TypeChecker_Env.deferred);
                                     FStar_TypeChecker_Env.univ_ineqs =
                                       (uu___164_2369.FStar_TypeChecker_Env.univ_ineqs);
                                     FStar_TypeChecker_Env.implicits =
                                       (ps1.FStar_Tactics_Types.all_implicits)
                                   } in
                                 let g2 =
                                   let uu____2371 =
                                     FStar_TypeChecker_Rel.solve_deferred_constraints
                                       env2 g1 in
                                   FStar_All.pipe_right uu____2371
                                     FStar_TypeChecker_Rel.resolve_implicits_tac in
                                 report_implicits ps1
                                   g2.FStar_TypeChecker_Env.implicits;
                                 ((FStar_List.append
                                     ps1.FStar_Tactics_Types.goals
                                     ps1.FStar_Tactics_Types.smt_goals), w)))
                           | FStar_Tactics_Result.Failed (s,ps1) ->
                               (FStar_Tactics_Basic.dump_proofstate ps1
                                  "at the time of failure";
                                (let uu____2378 =
                                   let uu____2379 =
                                     let uu____2384 =
                                       FStar_Util.format1
                                         "user tactic failed: %s" s in
                                     (uu____2384,
                                       (typ.FStar_Syntax_Syntax.pos)) in
                                   FStar_Errors.Error uu____2379 in
                                 FStar_Exn.raise uu____2378)))))))))
type pol =
  | Pos
  | Neg[@@deriving show]
let uu___is_Pos: pol -> Prims.bool =
  fun projectee  -> match projectee with | Pos  -> true | uu____2395 -> false
let uu___is_Neg: pol -> Prims.bool =
  fun projectee  -> match projectee with | Neg  -> true | uu____2400 -> false
let flip: pol -> pol = fun p  -> match p with | Pos  -> Neg | Neg  -> Pos
let by_tactic_interp:
  pol ->
    FStar_TypeChecker_Env.env ->
      FStar_Syntax_Syntax.term ->
        (FStar_Syntax_Syntax.term,FStar_Tactics_Types.goal Prims.list)
          FStar_Pervasives_Native.tuple2
  =
  fun pol  ->
    fun e  ->
      fun t  ->
        let uu____2429 = FStar_Syntax_Util.head_and_args t in
        match uu____2429 with
        | (hd1,args) ->
            let uu____2472 =
              let uu____2485 =
                let uu____2486 = FStar_Syntax_Util.un_uinst hd1 in
                uu____2486.FStar_Syntax_Syntax.n in
              (uu____2485, args) in
            (match uu____2472 with
             | (FStar_Syntax_Syntax.Tm_fvar
                fv,(rett,FStar_Pervasives_Native.Some
                    (FStar_Syntax_Syntax.Implicit uu____2505))::(tactic,FStar_Pervasives_Native.None
                                                                 )::(assertion,FStar_Pervasives_Native.None
                                                                    )::[])
                 when
                 FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.by_tactic_lid
                 ->
                 if pol = Pos
                 then
                   let uu____2574 = run_tactic_on_typ tactic e assertion in
                   (match uu____2574 with
                    | (gs,uu____2588) -> (FStar_Syntax_Util.t_true, gs))
                 else (assertion, [])
             | (FStar_Syntax_Syntax.Tm_fvar
                fv,(assertion,FStar_Pervasives_Native.None )::[]) when
                 FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.spinoff_lid
                 ->
                 if pol = Pos
                 then
                   let uu____2640 =
                     let uu____2643 =
                       let uu____2644 =
                         FStar_Tactics_Basic.goal_of_goal_ty e assertion in
                       FStar_All.pipe_left FStar_Pervasives_Native.fst
                         uu____2644 in
                     [uu____2643] in
                   (FStar_Syntax_Util.t_true, uu____2640)
                 else (assertion, [])
             | uu____2660 -> (t, []))
let rec traverse:
  (pol ->
     FStar_TypeChecker_Env.env ->
       FStar_Syntax_Syntax.term ->
         (FStar_Syntax_Syntax.term,FStar_Tactics_Types.goal Prims.list)
           FStar_Pervasives_Native.tuple2)
    ->
    pol ->
      FStar_TypeChecker_Env.env ->
        FStar_Syntax_Syntax.term ->
          (FStar_Syntax_Syntax.term,FStar_Tactics_Types.goal Prims.list)
            FStar_Pervasives_Native.tuple2
  =
  fun f  ->
    fun pol  ->
      fun e  ->
        fun t  ->
          let uu____2730 =
            let uu____2737 =
              let uu____2738 = FStar_Syntax_Subst.compress t in
              uu____2738.FStar_Syntax_Syntax.n in
            match uu____2737 with
            | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
                let uu____2753 = traverse f pol e t1 in
                (match uu____2753 with
                 | (t',gs) -> ((FStar_Syntax_Syntax.Tm_uinst (t', us)), gs))
            | FStar_Syntax_Syntax.Tm_meta (t1,m) ->
                let uu____2780 = traverse f pol e t1 in
                (match uu____2780 with
                 | (t',gs) -> ((FStar_Syntax_Syntax.Tm_meta (t', m)), gs))
            | FStar_Syntax_Syntax.Tm_app
                ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
                   FStar_Syntax_Syntax.pos = uu____2802;
                   FStar_Syntax_Syntax.vars = uu____2803;_},(p,uu____2805)::
                 (q,uu____2807)::[])
                when
                FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.imp_lid
                ->
                let x =
                  let uu____2847 = FStar_Syntax_Util.mk_squash p in
                  FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                    uu____2847 in
                let uu____2848 = traverse f (flip pol) e p in
                (match uu____2848 with
                 | (p',gs1) ->
                     let uu____2867 =
                       let uu____2874 = FStar_TypeChecker_Env.push_bv e x in
                       traverse f pol uu____2874 q in
                     (match uu____2867 with
                      | (q',gs2) ->
                          let uu____2887 =
                            let uu____2888 = FStar_Syntax_Util.mk_imp p' q' in
                            uu____2888.FStar_Syntax_Syntax.n in
                          (uu____2887, (FStar_List.append gs1 gs2))))
            | FStar_Syntax_Syntax.Tm_app (hd1,args) ->
                let uu____2915 = traverse f pol e hd1 in
                (match uu____2915 with
                 | (hd',gs1) ->
                     let uu____2934 =
                       FStar_List.fold_right
                         (fun uu____2972  ->
                            fun uu____2973  ->
                              match (uu____2972, uu____2973) with
                              | ((a,q),(as',gs)) ->
                                  let uu____3054 = traverse f pol e a in
                                  (match uu____3054 with
                                   | (a',gs') ->
                                       (((a', q) :: as'),
                                         (FStar_List.append gs gs')))) args
                         ([], []) in
                     (match uu____2934 with
                      | (as',gs2) ->
                          ((FStar_Syntax_Syntax.Tm_app (hd', as')),
                            (FStar_List.append gs1 gs2))))
            | FStar_Syntax_Syntax.Tm_abs (bs,t1,k) ->
                let uu____3158 = FStar_Syntax_Subst.open_term bs t1 in
                (match uu____3158 with
                 | (bs1,topen) ->
                     let e' = FStar_TypeChecker_Env.push_binders e bs1 in
                     let uu____3172 =
                       let uu____3187 =
                         FStar_List.map
                           (fun uu____3220  ->
                              match uu____3220 with
                              | (bv,aq) ->
                                  let uu____3237 =
                                    traverse f (flip pol) e
                                      bv.FStar_Syntax_Syntax.sort in
                                  (match uu____3237 with
                                   | (s',gs) ->
                                       (((let uu___165_3267 = bv in
                                          {
                                            FStar_Syntax_Syntax.ppname =
                                              (uu___165_3267.FStar_Syntax_Syntax.ppname);
                                            FStar_Syntax_Syntax.index =
                                              (uu___165_3267.FStar_Syntax_Syntax.index);
                                            FStar_Syntax_Syntax.sort = s'
                                          }), aq), gs))) bs1 in
                       FStar_All.pipe_left FStar_List.unzip uu____3187 in
                     (match uu____3172 with
                      | (bs2,gs1) ->
                          let gs11 = FStar_List.flatten gs1 in
                          let uu____3331 = traverse f pol e' topen in
                          (match uu____3331 with
                           | (topen',gs2) ->
                               let uu____3350 =
                                 let uu____3351 =
                                   FStar_Syntax_Util.abs bs2 topen' k in
                                 uu____3351.FStar_Syntax_Syntax.n in
                               (uu____3350, (FStar_List.append gs11 gs2)))))
            | x -> (x, []) in
          match uu____2730 with
          | (tn',gs) ->
              let t' =
                let uu___166_3374 = t in
                {
                  FStar_Syntax_Syntax.n = tn';
                  FStar_Syntax_Syntax.pos =
                    (uu___166_3374.FStar_Syntax_Syntax.pos);
                  FStar_Syntax_Syntax.vars =
                    (uu___166_3374.FStar_Syntax_Syntax.vars)
                } in
              let uu____3375 = f pol e t' in
              (match uu____3375 with
               | (t'1,gs') -> (t'1, (FStar_List.append gs gs')))
let getprop:
  FStar_Tactics_Basic.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun e  ->
    fun t  ->
      let tn =
        FStar_TypeChecker_Normalize.normalize
          [FStar_TypeChecker_Normalize.WHNF;
          FStar_TypeChecker_Normalize.UnfoldUntil
            FStar_Syntax_Syntax.Delta_constant] e t in
      FStar_Syntax_Util.un_squash tn
let preprocess:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      (FStar_TypeChecker_Env.env,FStar_Syntax_Syntax.term,FStar_Options.optionstate)
        FStar_Pervasives_Native.tuple3 Prims.list
  =
  fun env  ->
    fun goal  ->
      (let uu____3434 =
         FStar_TypeChecker_Env.debug env (FStar_Options.Other "Tac") in
       FStar_ST.op_Colon_Equals tacdbg uu____3434);
      (let uu____3482 = FStar_ST.op_Bang tacdbg in
       if uu____3482
       then
         let uu____3529 =
           let uu____3530 = FStar_TypeChecker_Env.all_binders env in
           FStar_All.pipe_right uu____3530
             (FStar_Syntax_Print.binders_to_string ",") in
         let uu____3531 = FStar_Syntax_Print.term_to_string goal in
         FStar_Util.print2 "About to preprocess %s |= %s\n" uu____3529
           uu____3531
       else ());
      (let initial = ((Prims.parse_int "1"), []) in
       let uu____3560 = traverse by_tactic_interp Pos env goal in
       match uu____3560 with
       | (t',gs) ->
           ((let uu____3582 = FStar_ST.op_Bang tacdbg in
             if uu____3582
             then
               let uu____3629 =
                 let uu____3630 = FStar_TypeChecker_Env.all_binders env in
                 FStar_All.pipe_right uu____3630
                   (FStar_Syntax_Print.binders_to_string ", ") in
               let uu____3631 = FStar_Syntax_Print.term_to_string t' in
               FStar_Util.print2 "Main goal simplified to: %s |- %s\n"
                 uu____3629 uu____3631
             else ());
            (let s = initial in
             let s1 =
               FStar_List.fold_left
                 (fun uu____3678  ->
                    fun g  ->
                      match uu____3678 with
                      | (n1,gs1) ->
                          let phi =
                            let uu____3723 =
                              getprop g.FStar_Tactics_Types.context
                                g.FStar_Tactics_Types.goal_ty in
                            match uu____3723 with
                            | FStar_Pervasives_Native.None  ->
                                let uu____3726 =
                                  let uu____3727 =
                                    FStar_Syntax_Print.term_to_string
                                      g.FStar_Tactics_Types.goal_ty in
                                  FStar_Util.format1
                                    "Tactic returned proof-relevant goal: %s"
                                    uu____3727 in
                                failwith uu____3726
                            | FStar_Pervasives_Native.Some phi -> phi in
                          ((let uu____3730 = FStar_ST.op_Bang tacdbg in
                            if uu____3730
                            then
                              let uu____3777 = FStar_Util.string_of_int n1 in
                              let uu____3778 =
                                FStar_Tactics_Basic.goal_to_string g in
                              FStar_Util.print2 "Got goal #%s: %s\n"
                                uu____3777 uu____3778
                            else ());
                           (let gt' =
                              let uu____3781 =
                                let uu____3782 = FStar_Util.string_of_int n1 in
                                Prims.strcat "Could not prove goal #"
                                  uu____3782 in
                              FStar_TypeChecker_Util.label uu____3781
                                goal.FStar_Syntax_Syntax.pos phi in
                            ((n1 + (Prims.parse_int "1")),
                              (((g.FStar_Tactics_Types.context), gt',
                                 (g.FStar_Tactics_Types.opts)) :: gs1))))) s
                 gs in
             let uu____3797 = s1 in
             match uu____3797 with
             | (uu____3818,gs1) ->
                 let uu____3836 =
                   let uu____3843 = FStar_Options.peek () in
                   (env, t', uu____3843) in
                 uu____3836 :: gs1)))
let reify_tactic: FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun a  ->
    let r =
      let uu____3855 =
        let uu____3856 =
          FStar_Syntax_Syntax.lid_as_fv FStar_Parser_Const.reify_tactic_lid
            FStar_Syntax_Syntax.Delta_equational FStar_Pervasives_Native.None in
        FStar_Syntax_Syntax.fv_to_tm uu____3856 in
      FStar_Syntax_Syntax.mk_Tm_uinst uu____3855 [FStar_Syntax_Syntax.U_zero] in
    let uu____3857 =
      let uu____3858 =
        let uu____3859 = FStar_Syntax_Syntax.iarg FStar_Syntax_Syntax.t_unit in
        let uu____3860 =
          let uu____3863 = FStar_Syntax_Syntax.as_arg a in [uu____3863] in
        uu____3859 :: uu____3860 in
      FStar_Syntax_Syntax.mk_Tm_app r uu____3858 in
    uu____3857 FStar_Pervasives_Native.None a.FStar_Syntax_Syntax.pos
let synth:
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  fun env  ->
    fun typ  ->
      fun tau  ->
        (let uu____3879 =
           FStar_TypeChecker_Env.debug env (FStar_Options.Other "Tac") in
         FStar_ST.op_Colon_Equals tacdbg uu____3879);
        (let uu____3926 =
           let uu____3933 = reify_tactic tau in
           run_tactic_on_typ uu____3933 env typ in
         match uu____3926 with
         | (gs,w) ->
             let uu____3940 =
               FStar_List.existsML
                 (fun g  ->
                    let uu____3944 =
                      let uu____3945 =
                        getprop g.FStar_Tactics_Types.context
                          g.FStar_Tactics_Types.goal_ty in
                      FStar_Option.isSome uu____3945 in
                    Prims.op_Negation uu____3944) gs in
             if uu____3940
             then
               FStar_Exn.raise
                 (FStar_Errors.Error
                    ("synthesis left open goals",
                      (typ.FStar_Syntax_Syntax.pos)))
             else w)