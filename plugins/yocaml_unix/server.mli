(* YOCaml a static blog generator.
   Copyright (C) 2024 The Funkyworkers and The YOCaml's developers

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>. *)

(** A very simple server for locally serving a project built with YOcaml. *)

val run :
     ?custom_error_handler:
       (Format.formatter -> Yocaml.Data.Validation.custom_error -> unit)
  -> Yocaml.Path.t
  -> int
  -> (unit -> unit Yocaml.Eff.t)
  -> Eio_unix.Stdenv.base
  -> 'a
(** [run ?custom_error_handler target port program] describes an EIO program
    that serve statically [target] on listening [port]. *)
