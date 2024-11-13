module State = struct
  type child =
    [ `OnEntry
    | `OnExit
    | `Transition
    | `Initial
    | `State
    | `Parallel
    | `Final
    | `History
    | `DataModel
    | `Invoke ]

  type t = {
    id : string option;
    initial : string option;
    children : child list;
  }

  let is_atomic (t : t) =
    List.find_opt
      (fun child -> child == `Parallel || child == `State || child == `Final)
      t.children
    |> Option.is_some |> Bool.not

  let is_compound (t : t) =
    List.find_opt
      (fun child -> child == `Parallel || child == `State || child == `Final)
      t.children
    |> Option.is_some

  let validate t =
    let count = ref 0 in
    List.iter
      (fun child -> if child == `DataModel then incr count else ())
      t.children;
    !count > 1
end

module Parallel = struct
  type child =
  [ `OnEntry | `OnExit | `State | `Parallel | `History | `DataModel | `Invoke ]

  type t = { id : string; children : child list }

  let validate t =
    let count = ref 0 in
    List.iter
      (fun child -> if child == `DataModel then incr count else ())
      t.children;
    !count > 1
end

module Transition = struct
  type t = {
    event : string option;
    cond : bool option;
    target : string option;
    _type : string option;
  }
end

module Initial = struct
  type t = { id : string option }
  type child = [ `Transition ]
end

module Final = struct
  type t = { id : string option }
  type child = [ `OnEntry | `OnExit | `DoneData ]
end

module OnEntry = struct
  open Executable_content

  type t = OnEntry
  type attr = ExecutableElements
end

module OnExit = struct
  open Executable_content

  type t = OnExit
  type attr = ExecutableElements.t
end

module Finalize = struct
  open Executable_content

  type t = Finalize
  type attr = ExecutableElements.t
end

module History = struct
  type t = { id : string option; _type : string option }
  type child = [ `Transition ]
end

module Script = struct
  type t = { src : string option }
  type child = string option
end

module DataModel = struct
  type child = [ `Data ]
end

module Data = struct
  type t = { id : string; src : string option; expr : string option }
end

module Log = struct
  type t = { label : string option; expr : string option }
end

module Raise = struct
  type t = { event : string }
end
