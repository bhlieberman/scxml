module StateMachine = Elements.El.Make (struct
  type t = Scxml

  type attr =
    [ `Initial of string
    | `Name of string
    | `Xmlns of string
    | `Version of string
    | `DataModel of string
    | `Binding of string ]

  type attrs = {
    initial : attr option;
    name : attr option;
    xmlns : attr;
    version : attr;
    datamodel : attr option;
    binding : attr option;
  }

  type child = [ `State | `Parallel | `Final | `DataModel | `Script ]
end)
