(*Shawn Anthony
  ICS 313
  Biagioni
  HW4
  Super Basic Version that only can accept single operator expressions, but works with all five operators
*)


(*provided string to char function*)
let rec explode = function
    | "" -> []
    | s -> let first = String.get s 0 and
               rest = String.sub s 1 ((String.length s) - 1)
           in first :: explode rest;;

(*provided alpha identifier function*)
let isalpha = function | 'a' .. 'z' -> true | _ -> false;;

(*provided digit indentifier function*)
let isdigit = function | '0' .. '9' -> true | _ -> false;;


(* Unused for expression type definition
type expression = 
	| F of factor | Plus of factor * expression | Minus of factor * expression | Times of factor * expression | Divide of factor * expression;;*)


(*Extremely basic calulator function that only handles expressions of a string with two integers and one math operation, seperated with white space ie. 
  (hw4compute "1 + 2"). Ran into issues attempting to transition into code that could handle variable length expressions with different numbers of white spaces.  This code could
  be adapted to handle any reasonable scenario with enough hard coding to account for every situation and every reasonable length, but that didn't fit the
  intended goal of the assignment so I didn't do that for the few extra points it might give.  Code uses substrings of the input and converts the integers 
  into ints, before matching the operator with the five required math operators to recieve a result. *)
let hw4compute str =
  	let n1 = int_of_string (String.sub str 0 1) in
  	let n2 = int_of_string (String.sub str (String.length str - 1) 1) in
  	let op = (String.sub str 2 1) in match op with
  		| "+" -> n1 + n2
  		| "-" -> n1 - n2
  		| "*" -> n1 * n2
  		| "/" -> n1 / n2
		| "%" -> n1 mod n2 
  		| _ -> raise (Invalid_argument "Unsupported String Supplied");;

