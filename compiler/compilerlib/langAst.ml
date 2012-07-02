(*
    Copyright © 2011 MLstate

    This file is part of OPA.

    OPA is free software: you can redistribute it and/or modify it under the
    terms of the GNU Affero General Public License, version 3, as published by
    the Free Software Foundation.

    OPA is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
    more details.

    You should have received a copy of the GNU Affero General Public License
    along with OPA. If not, see <http://www.gnu.org/licenses/>.
*)
(* cf mli *)

type pos = FilePos.pos

external pos : 'a -> pos = "%field0"
external imp_reset_pos : 'a -> pos -> unit = "%setfield0"
let reset_pos t p =
  let t = Obj.dup (Obj.repr t) in
  imp_reset_pos t p;
  Obj.obj t
let merge_pos t p =
  let p = FilePos.merge_pos p (pos t) in
  reset_pos t p