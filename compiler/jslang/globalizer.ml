(*
    Copyright © 2011, 2012 MLstate

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

(**
   Command line wrapper for JsUtils.export_to_global_namespace.

   This is a temporary hack to use the Opa NodeJs runtime as a
   package. It should be removed when the runtime is fully converted.

   @author Arthur Azevedo de Amorim
*)

module List = BaseList

type path = string

let read_cmd_line_args (args : path list) =
  let rec aux files output package_version args =
    match args with
    | [] when List.is_empty files ->
      `ko "No input files"
    | [] -> (
      let package_version = Option.default "0.1.0" package_version in
      match output with
      | Some output -> `ok (files, output, package_version)
      | None -> `ko "No output file given"
    )
    | ["--package-version"] -> `ko "Missing package version argument"
    | "--package-version" :: arg :: args -> (
      match package_version with
      | Some _ -> `ko "Multiple package versions given"
      | None -> aux files output (Some arg) args
    )
    | ["-o"] -> `ko "Missing output argument"
    | "-o" :: arg :: args -> (
      match output with
      | Some _ -> `ko "Multiple outputs given"
      | None -> aux files (Some arg) package_version args
    )
    | arg :: args -> aux (arg :: files) output package_version args
  in
  aux [] None None args

let process formatter (files : (path * JsAst.code) list) =
  List.iter (fun (filename, content) ->
    Format.fprintf formatter "// FILE: %s\n%a\n" filename
      JsPrint.pp_min#code content
  ) files

let die message =
  Printf.eprintf "error: %s\n" message; exit 1


let pp_nodejs filename contents =
  let ppenv =
    let ppenv = Pprocess.fill_with_sysenv Pprocess.empty_env in
    let ppenv = Pprocess.add_env "OPABSL_NODE" "1" ppenv in
    Pprocess.add_env "OPA_CPS_CLIENT" "1" ppenv in
  let ppopt = Pprocess.default_options ppenv in
  let contents = Pprocess.process ~name:filename
    Pplang.js_description ppopt contents in
  contents

let _ =
  let args = List.tl (Array.to_list Sys.argv) in
  match read_cmd_line_args args with
  | `ko error -> die error
  | `ok (files, output, package_version) ->

    (* Read files and reexport their identifiers *)
    let files = List.map (fun filename ->
      let content = File.content filename in
      let content = pp_nodejs  filename content in
      let content =
        try
          JsParse.String.code ~throw_exn:true content
        with
          JsParse.Exception e ->
            OManager.error
              ("Couldn't parse file @{<brigth>%s@}\n"^^
                 "Error : %a")
              filename
              JsParse.pp e
      in
      (filename, JsUtils.export_to_global_namespace content)
    ) files
    in

    (* Output nodejs package *)
    File.remove_rec output;
    if not (File.check_create_path output) then
      die "Couldn't create output path";
    let main_path = Filename.concat output "main.js" in
    let package_json_path = Filename.concat output "package.json" in
    let readme_path = Filename.concat output "README.md" in
    let package_desc = JsUtils.basic_package_json
      ~version:package_version output "main.js" in
    let output_result = File.pp_output package_json_path
      Format.pp_print_string package_desc
    in
    begin match output_result with
    | None -> ()
    | Some error -> OManager.error "Couldn't create package: %s\n" error
    end;
    begin match File.pp_output main_path process files with
    | None -> ()
    | Some error -> OManager.error "Couldn't create package: %s\n" error
    end;
    let oc = open_out readme_path in
    output_string oc "This file is part of Opa. http://opalang.org";
    close_out oc
