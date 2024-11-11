module type CONFORMANT = sig
  type t
end

module type M = sig
  type expr (* probably destined to be `val` along with the rest of these *)
  type loc
  type value
  type script
  type var
end

module Make (C : CONFORMANT) : M = struct
  type expr
  type loc
  type value
  type script
  type var
end

module Null = Make (struct
  type t = Null
end)