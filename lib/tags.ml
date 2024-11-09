module State = struct
  type t = { id : string; initial : string }
end

module type Transition = sig
  type t
  type elt
  type _type

  (* consider whether target belongs here *)
  val target : State.t option

  (* values versus types, consider the trade-offs *)
  val event : 'a option
  val cond : bool option
end

(** I need to actually specify a contract here,
  but what kind of behavior do I need to enforce, in general?
  I suppose it is dependent to a degree on the type of processing
  the event is subject to? One thing to consider is this language
  from the W3C standard: 
  "A conformant SCXML document MUST specify at least one of 'event', 'cond' or 'target'. 3.13 Selecting and Executing Transitions contains more detail on the semantics of transitions."
  *)
module Tag = struct
  module type T = sig
    type t

    val conform : 'a option -> 'b option -> 'c option -> t
  end

  module Make (S : Transition) : T = struct
    type t = string option
    (** Rationale: specifying the target
    state in the functor permits... *)

    let conform event cond target =
      if Option.is_some event || Option.is_some cond || Option.is_some target
      then Some ""
      else None
  end
end

module Transition = Tag.Make (struct
  type t = string
  type elt = string (* TBD, this is for child elements? *)
  type _type = [ `External | `Internal ]

  let target = None
  let event = None
  let cond = None
end)
