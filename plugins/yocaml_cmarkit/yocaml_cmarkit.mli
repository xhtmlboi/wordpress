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

(** Describing documents using a Markup language is very common in the
    {i Blogosphere} (rather than describing all the formatting of document
    content in HTML, using <p>, <strong> and co).

    [Common Mark] is a specification (see RFC7763/RFC7764) of Markdown since
    2016. As it is a very popular markup language, OCaml has several very good
    libraries for turning Common Mark into HTML. This library is a wrapper
    around {{:https://github.com/dbuenzli/cmarkit} cmarkit}, an excellent Common
    Mark conversion library. *)

(** {1 API} *)

val to_html :
  ?strict:bool -> ?safe:bool -> unit -> (string, string) Yocaml.Task.t
(** [to_html ~strict ~safe ()] is an arrow that produces an HTML (as a String)
    from a String in Common Mark.

    The [strict] argument permits to follow {b only} the Common Mark
    specification. If you attempt to use some extensions (see
    {!val:Cmarkit.Doc.of_string}), you should set it to [false].

    The [safe] argument ensures that any HTML code written in your Common Mark
    document is escaped as an HTML comment. As most of the time, the markdown
    provided comes from the user, this functionnality is disabled by default. If
    you want to activate this feature, you should set it to [true]. *)

val content_to_html :
  ?strict:bool -> ?safe:bool -> unit -> ('a * string, 'a * string) Yocaml.Task.t
(** Since it is pretty common to deal with document and Metadata, which are
    generally a pair of [Metadata] and [the content of the document],
    [content_to_html] is a function that produce an arrow which apply the Common
    Mark conversion on the second element (the content).

    [content_to_html ()] is equivalent of [Yocaml.Task.second to_html]. *)
