module Elements = struct
  type t = string

  let compare a b = String.compare a b
end

module ExecutableElements = Set.Make (Elements)
