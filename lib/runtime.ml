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

module Make (Runtime : Required.RUNTIME) = struct
  let exnc ?custom_error_handler exn =
    let msg =
      Format.asprintf "%a"
        (Diagnostic.exception_to_diagnostic ?custom_error:custom_error_handler
           ~in_exception_handler:true)
        exn
    in
    Runtime.log `Error msg

  let runtimec error =
    let error = Runtime.runtime_error_to_string error in
    let msg =
      Format.asprintf "%a" Diagnostic.runtime_error_to_diagnostic error
    in
    Runtime.log `Error msg

  let run ?custom_error_handler program =
    let exnc = exnc ?custom_error_handler in
    let handler =
      Effect.Deep.
        {
          exnc
        ; retc = (fun () -> Runtime.return ())
        ; effc =
            (fun (type a) (eff : a Effect.t) ->
              match eff with
              | Eff.Yocaml_failwith exn -> Some (fun _k -> exnc exn)
              | Eff.Yocaml_log (level, message) ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind (continue k) (Runtime.log level message))
              | Eff.Yocaml_file_exists (filesystem, path) ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind (continue k)
                        (Runtime.file_exists ~on:filesystem path))
              | Eff.Yocaml_read_file (filesystem, path) ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind
                        (function
                          | Ok x -> continue k x | Error err -> runtimec err)
                        (Runtime.read_file ~on:filesystem path))
              | Eff.Yocaml_get_mtime (filesystem, path) ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind
                        (function
                          | Ok x -> continue k x | Error err -> runtimec err)
                        (Runtime.get_mtime ~on:filesystem path))
              | Eff.Yocaml_hash_content content ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind (continue k) (Runtime.hash_content content))
              | Eff.Yocaml_write_file (filesystem, path, content) ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind
                        (function
                          | Ok x -> continue k x | Error err -> runtimec err)
                        (Runtime.write_file ~on:filesystem path content))
              | Eff.Yocaml_is_directory (filesystem, path) ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind (continue k)
                        (Runtime.is_directory ~on:filesystem path))
              | Eff.Yocaml_read_dir (filesystem, path) ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      Runtime.bind
                        (function
                          | Ok x -> continue k x | Error err -> runtimec err)
                        (Runtime.read_dir ~on:filesystem path))
              | _ -> None)
        }
    in
    Eff.run handler program ()
end
