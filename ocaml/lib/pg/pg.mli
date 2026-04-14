type pool
type row
type param =
  | Null
  | String of string
  | Int of int
  | Int64 of int64
  | Bool of bool
  | Float of float

val make_pool : ?pool_size:int -> string -> pool
val close_pool : pool -> unit
val query : pool -> string -> params:param list -> row list
val get : row -> int -> string
val get_opt : row -> int -> string option
