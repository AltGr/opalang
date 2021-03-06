(*
    Copyright © 2011 MLstate

    This file is part of Opa.

    Opa is free software: you can redistribute it and/or modify it under the
    terms of the GNU Affero General Public License, version 3, as published by
    the Free Software Foundation.

    Opa is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
    more details.

    You should have received a copy of the GNU Affero General Public License
    along with Opa. If not, see <http://www.gnu.org/licenses/>.
*)
(* Generated by mkrp.ml - Wed, 15 Dec 2010 12:31:00 GMT *)
open UserCompatType
exception ParseFail_brow

let brow_scmp s1 s2 m n =
  let p = ref m in
  while !p < n && String.unsafe_get s1 (!p) = String.unsafe_get s2 (!p) do incr p done;
  !p = n

let brow_fail (_:(string -> int -> int -> string -> UserCompatType.renderer_engine) array) (_brow:string) (_browlen:int) = raise ParseFail_brow

let brow_tab = Array.init 52 (fun _ -> Array.make 71 brow_fail)

let browDi rpfn brow browlen =
  if brow_scmp brow "Dillo" 2 5
  then rpfn.(8) brow browlen 5 "Dillo"
  else raise ParseFail_brow
let _ = brow_tab.(0).(54) <- browDi

let browGo rpfn brow browlen =
  if brow_scmp brow "Googlebot" 2 9
  then rpfn.(15) brow browlen 9 "Googlebot"
  else raise ParseFail_brow
let _ = brow_tab.(3).(60) <- browGo

let browHT rpfn brow browlen =
  if brow_scmp brow "HTC" 2 3
  then rpfn.(5) brow browlen 3 "HTC"
  else raise ParseFail_brow
let _ = brow_tab.(4).(33) <- browHT

let browLi rpfn brow browlen =
  if brow_scmp brow "Links" 2 5
  then rpfn.(13) brow browlen 5 "Links"
  else raise ParseFail_brow
let _ = brow_tab.(8).(54) <- browLi

let browLy rpfn brow browlen =
  if brow_scmp brow "Lynx" 2 4
  then rpfn.(12) brow browlen 4 "Lynx"
  else raise ParseFail_brow
let _ = brow_tab.(8).(70) <- browLy

let browMO rpfn brow browlen =
  if brow_scmp brow "MOT" 2 3
  then rpfn.(4) brow browlen 3 "MOT"
  else raise ParseFail_brow
let _ = brow_tab.(9).(28) <- browMO

let browMS rpfn brow browlen =
  if brow_scmp brow "MSNBOT" 2 6
  then rpfn.(17) brow browlen 6 "MSNBOT"
  else raise ParseFail_brow
let _ = brow_tab.(9).(32) <- browMS

let browMi rpfn brow browlen =
  if brow_scmp brow "Microsoft" 2 9
  then rpfn.(3) brow browlen 9 "Microsoft"
  else raise ParseFail_brow
let _ = brow_tab.(9).(54) <- browMi

let browMo rpfn brow browlen =
  if brow_scmp brow "Mozilla" 2 7
  then rpfn.(0) brow browlen 7 "Mozilla"
  else raise ParseFail_brow
let _ = brow_tab.(9).(60) <- browMo

let browNo rpfn brow browlen =
  if brow_scmp brow "Nokia" 2 5
  then rpfn.(1) brow browlen 5 "Nokia"
  else raise ParseFail_brow
let _ = brow_tab.(10).(60) <- browNo

let browOp rpfn brow browlen =
  if brow_scmp brow "Opera" 2 5
  then rpfn.(2) brow browlen 5 "Opera"
  else raise ParseFail_brow
let _ = brow_tab.(11).(61) <- browOp

let browPS rpfn brow browlen =
  if brow_scmp brow "PSP" 2 3
  then rpfn.(9) brow browlen 3 "PSP"
  else raise ParseFail_brow
let _ = brow_tab.(12).(32) <- browPS

let browSe rpfn brow browlen =
  if brow_scmp brow "Seamonkey" 2 9
  then rpfn.(7) brow browlen 9 "Seamonkey"
  else raise ParseFail_brow
let _ = brow_tab.(15).(50) <- browSe

let browWg rpfn brow browlen =
  if brow_scmp brow "Wget" 2 4
  then rpfn.(10) brow browlen 4 "Wget"
  else raise ParseFail_brow
let _ = brow_tab.(19).(52) <- browWg

let browYa rpfn brow browlen =
  if brow_scmp brow "Yahoo! Slurp" 2 12
  then rpfn.(18) brow browlen 12 "Yahoo! Slurp"
  else if brow_scmp brow "YahooSeeker" 2 11
  then rpfn.(19) brow browlen 11 "YahooSeeker"
  else raise ParseFail_brow
let _ = brow_tab.(21).(46) <- browYa

let browam rpfn brow browlen =
  if brow_scmp brow "amaya" 2 5
  then rpfn.(14) brow browlen 5 "amaya"
  else raise ParseFail_brow
let _ = brow_tab.(29).(58) <- browam

let browlw rpfn brow browlen =
  if brow_scmp brow "lwp-trivial" 2 11
  then rpfn.(11) brow browlen 11 "lwp-trivial"
  else raise ParseFail_brow
let _ = brow_tab.(40).(68) <- browlw

let browms rpfn brow browlen =
  if brow_scmp brow "msnbot" 2 6
  then rpfn.(16) brow browlen 6 "msnbot"
  else raise ParseFail_brow
let _ = brow_tab.(41).(64) <- browms

let broww3 rpfn brow browlen =
  if brow_scmp brow "w3m" 2 3
  then rpfn.(6) brow browlen 3 "w3m"
  else raise ParseFail_brow
let _ = brow_tab.(51).(0) <- broww3

let brow_mms = [|('D','w');('3','y')|]

let brow_call rpfn brow browlen =
  let c0 = String.unsafe_get brow 0 in
  let c1 = String.unsafe_get brow 1 in
  if c0 < 'D' || c0 > 'w' then raise ParseFail_brow;
  if c1 < '3' || c1 > 'y' then raise ParseFail_brow;
  brow_tab.((Char.code c0)-68).((Char.code c1)-51) rpfn brow browlen
