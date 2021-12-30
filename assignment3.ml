(*Shawn Anthony
  ICS 313
  Assignment 3
*)

(*compose function provided*)
let compose f1 f2 = (fun x -> f1 (f2 x));;

(*map function provided*)
let rec map f = function
        | [] -> []
        | first :: rest -> f first :: map f rest;;

(*reduce function provided*)
let rec reduce f init = function
        | [] -> init
        | first :: rest -> f first (reduce f init rest);;

(*mapreduce using compose to combine the provided map and reduce functions into a single function*)
let mapreduce f1 f2 init = compose (reduce f2 init) (map f1);;
	
(*compose2, modified compose function that works on two lists*)
let compose2 f1 f2 = (fun x y -> f1 (f2 x y));;

(*map2, modified map that pattern matches on two lists instead of one*)
let rec map2 f list1 list2 = match (list1, list2) with
	| [],[] -> []
	| first1 :: rest1, first2 :: rest2 -> (f first1 first2) :: (map2 f rest1 rest2)
	| _ -> raise (Invalid_argument "invalid arg for map2");;

(*map2reduce, modified mapreduce that uses copose2 and map2 to reduce on two lists*)
let map2reduce f1 f2 init = compose2 (reduce f2 init) (map2 f1);;

(*WIP mapf that I couldn't quite figure out how to pattern match two seperate lists for, wh*)


(*mappairreduce, Not Implemented
let rec mappairreduce*)

(*test functions*)
let even x = (x mod 2) = 0;; 
let odd x = (x mod 2) = 1;;

let test a b c = c;;

let f = (fun x -> x + 1) ;;


let g = (fun x y -> x + y) ;;


let z = mapreduce f g 0 [1; 2; 3];;

let min x y = if x < y then x else y;;

print_int z;;
