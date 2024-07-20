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

(** Unix runtime for YOCaml.

    Allows you to run YOCaml on a Unix system (or source service for more
    complex runtimes). *)

val run :
     ?level:Logs.level
  -> ?custom_error_handler:
       (Format.formatter -> Yocaml.Data.Validation.custom_error -> unit)
  -> (unit -> unit Yocaml.Eff.t)
  -> unit
(** [run ?level ?custom_error_handler program] Runs a Yocaml program in the Unix
    runtime. The log [level] (default: [Debug]) and a [custom_error_handler] can
    be passed as arguments to change the reporting level.*)
