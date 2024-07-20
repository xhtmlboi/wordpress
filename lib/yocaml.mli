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

(** [Yocaml] is the entry point for a YOCaml program. It describes the
    core/engine of the framework. *)

(** {1 Requirements}

    All the interfaces needed to build behaviour. *)

module Required = Required

(** {1 Elements}

    Modules describing the elements {i constituting} YOCaml, for example file
    paths, dependencies set, cache etc. *)

module Nel = Nel
module Path = Path
module Cache = Cache
module Deps = Deps
module Metadata = Metadata

(** {1 Building tasks}

    Modules for describing construction rules. Tasks to be executed, pipelines,
    action etc.

    The logic of modular distribution may seem strange (and a little excessive),
    but it respects this lattice:

    - A {!type:Task.t} is the fundamental building block for building
      {!module:Pipeline}
    - {!module:Pipeline} describes concrete, composable sets of steps
    - {!module:Action} consumes {!module:Pipeline} to build {b artifacts}. *)

module Task = Task
module Pipeline = Pipeline
module Action = Action

(** {1 Effects abstraction}

    Modules relating to the
    {{:https://v2.ocaml.org/releases/5.1/htmlman/effects.html#s%3Aeffect-handlers}
      abstraction and performance of effects}. *)

module Eff = Eff

(** {1 Serialization}

    As the new version of YOCaml uses a cache based on the previous generation,
    it is important to be able to serialise (and deserialise) arbitrary data
    structures. *)

module Sexp = Sexp
module Data = Data
