module type TAG = sig
  type t
  type attr
end

module El = struct
  module type T = sig
    type el_type
    type child

    val children : child list
  end

  module Make (Tag : TAG) : T = struct
    type el_type = Tag.t
    type child

    let children = []
    (* This will contain the various functions
       for operating on statechart elements
    *)
  end
end

module State = El.Make (struct
  type t = State

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

  type attr = [ `Id of string | `Initial of string ]
  type attrs = { id : attr; initial : attr }
end)

module Parallel = El.Make (struct
  type t = Parallel

  type child =
    [ `OnEntry | `OnExit | `State | `Parallel | `History | `DataModel | `Invoke ]

  type attr = [ `Id of string ]
  type attrs = { id : attr }
end)

module Transition = El.Make (struct
  type t = Transition
  type attr = [ `Event | `Cond of bool | `Target of string | `Type of string ]

  type attrs = {
    event : attr option;
    cond : attr option;
    target : attr option;
    _type : attr option;
  }
end)

module Initial = El.Make (struct
  type t = Initial
  type child = [ `Transition ]
  type attr = [ `Id of string ]
  type attrs = { id : attr option }
end)

module Final = El.Make (struct
  type t = Final
  type child = [ `OnEntry | `OnExit | `DoneData ]
  type attr = [ `Id of string ]
  type attrs = { id : attr option }
end)

module OnEntry = El.Make (struct
  open Executable_content

  type t = OnEntry
  type attr = ExecutableElements
end)

module OnExit = El.Make (struct
  open Executable_content

  type t = OnExit
  type attr = ExecutableElements.t
end)

module Finalize = El.Make (struct
  open Executable_content

  type t = Finalize
  type attr = ExecutableElements.t
end)

module History = El.Make (struct
  type t = History
  type child = [ `Transition ]
  type attr = [ `Id of string | `Type of string ]
  type attrs = { id : attr option; _type : attr option }
end)

module Script = El.Make (struct
  type t = Script
  type child = string option
  type attr = [ `Src of string ] (* mutually exclusive with child elements *)
  type attrs = { src : attr option }
end)

module DataModel = El.Make (struct
  type t = DataModel
  type attr = None
  type child = [ `Data ]

  let children : child list = []
end)

module Data = El.Make (struct
  type t = Data
  type attr = [ `Id | `Src | `Expr ]

  type attrs = { id : attr; src : attr option; expr : attr option }
  (**
  In a conformant SCXML document, 
  a <data> element MAY have either a 'src' or an 'expr' attribute, 
  but MUST NOT have both. Furthermore, if either attribute is present, 
  the element MUST NOT have any children. 
  Thus 'src', 'expr' and children are mutually exclusive 
  in the <data> element.
  *)
end)

module Log = El.Make (struct
  type t = Log
  type attr = [ `Label of string | `Expr ]
  type attrs = { label : attr option; expr : attr option }
end)

module Raise = El.Make (struct
  type t = Raise
  type attr = Event
  type attrs = { event : attr }
end)
