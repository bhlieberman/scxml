open Effect

type _ Effect.t += Invalid_state : string -> string Effect.t

let transition_state s transition_fn =
  (* s : old_state, record type
     transition_fn : (old_state, new_state) continuation
  *)
  None
