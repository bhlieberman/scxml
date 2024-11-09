module type Document = sig
  type t

  type attr =
    [ `Initial of string
    | `Name of string
    | `Xmlns of string
    | `Version of string
    | `DataModel of string
    | `Binding of string
    | `Src of string ]

  type attrs = attr list
end

module type Chart = sig
  type elt
end

module Scxml (Elt : Document) : Chart = struct
  type elt = Elt.t
  (** Top-level document element, with children of types:
        - State

        - Parallel

        - Final

        - DataModel

        - Script
  *)
end

module Script = struct
  type elt
  (** Element type of child *)

  type src = string
  (** String containing executable script URL *)

  type t = { src : src option; elt : elt option }
  (** src attribute and children of Script are **MUTUALLY EXCLUSIVE**.
      See create_link and create_raw for type-safe constructors.
  *)

  let create_link (s : string) = { src = Some s; elt = None }
  let create_raw (elt : elt) = { src = None; elt = Some elt }
end

module State (Elt : Document) : Chart = struct
  type elt = { id : string; initial : string }

  let mkState id initial = { id ; initial }
end
