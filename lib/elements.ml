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
  type t = OnEntry
  type attr = []
end)

module OnExit = El.Make (struct
  type t = OnExit
  type attr = []
end)

module History = El.Make (struct
  type t = History
  type child = [ `Transition ]
  type attr = [ `Id of string | `Type of string ]
  type attrs = { id : attr option; _type : attr option }
end)
