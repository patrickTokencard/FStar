(*--build-config
    options:--admit_fsi FStar.Set --admit_fsi Wysteria --admit_fsi FStar.OrdSet --admit_fsi FStar.IO --admit_fsi Smciface;
    other-files:ghost.fst ext.fst FStar.Set.fsi FStar.Heap.fst FStar.ST.fst FStar.All.fst FStar.IO.fsti list.fst listTot.fst st2.fst ordset.fsi ../../prins.fst ../ffi.fst ../wysteria.fsi gpspaper.fst
 --*)

module Smciface

open Prins
open FStar.OrdSet

val gps: ps:prins{ps = union (singleton Alice) (union (singleton Bob) (singleton Charlie))} -> p:prin{mem p ps} -> x:int -> Tot prin
