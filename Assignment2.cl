;;;Shawn Anthony
;;;ICS 313 Biagioni 
;;;Fall 2021
;;;Assignment 2


;provided compose function
(defun compose (f1 f2) (lambda (x) (funcall f1 (funcall f2 x))))

;provided map function
(defun my-map (f lst)
    (if lst (cons (funcall f (car lst)) (my-map f (cdr lst)))
      nil))  

;provided reduce function
(defun my-reduce (f lst)
    (if (cdr lst) (funcall f (car lst) (my-reduce f (cdr lst)))
        (car lst)))




;non-functional my-map-reduce, which takes two functions and a list and uses compose to combine map and reduce 
(defun my-map-reduce (f1 f2 lst) (funcall (compose (my-reduce f2 lst) (my-map f1 lst)) lst))

;This function should take the compose function and combine the provided map and reduce functions to first call my-map
;and then to finally call my-reduce on the result of the mapped list, this should cause it to have a similar effect as
;the function below that does not use compose in order to combine the functions, even the homework assignment says that
;compose takes two single-argument functions, and the two provided functions are not single-argument functions


;test function to see logic of map-reduce
(defun my-map-reduce-no-compose (f1 f2 lst) (my-reduce f2 (my-map f1 lst)))
;I mostly understand how the implementation of map-reduce would work by passing my-map as a parameter to my-reduce
;but, I haven't figured out how to do that while also using compose with functions that need their own parameters






;non-functional compose2, takes two functions and uses a lambda function to apply the functions to the args
(defun compose2 (f1 f2) (lambda (&rest args)(multiple-value-call f1 (funcall f2 args))))

;I was trying to use funcall on f2 and args in order to apply the function to all lists passed as args and then a multiple-value-call to
;apply f1 to any lists returned from the inner function call, but this doesn't seem quite right and didn't work as expected






;my-map2, a function that takes a function and lists as args and maps over the lists
(defun my-map2 (f &rest lists)
  (cond 
   ((member nil lists) nil)  ;Recursion base case to exit when nil is found   
   ((null (cdr lists))(let ((lst (car lists)))(cons (funcall f (car lst))(my-map2 f (cdr lst))))) ;Case for only 1 list args
   (t (cons (apply f (my-map2 #'car lists))(apply #'my-map2 f (my-map2 #'cdr lists)))))) ;Final recursion line for 2 list args

;my-map2 defines a function that takes a function to map as well as a set of lists to satisfy the &rest parameter, only works 
;with 1 or 2 lists as the assignment specified, but could be adapted for more easily in the last recursion line of the function.
;Uses a cond to control flow of code through several checks to guide the recursion, first by checking for nil in the args to end
;recursion, then checking for a second arg in lists with cdr, and if not found assigning the only list to a new variable lst, before
;recursing down lst,using a cons to create the final list once the recursion has completed.  If neither of those previous cases are T,
;the function enters the last statement in the cond, creating a cons of recursing through the two lists using the map function
;recursively, while also applying function f to them.  This continues until it recurses through the lists and reaches nil before 
;backing out of the recursion, creating the new list and returning it.




;not implemented as I couldn't figure out first my-map-reduce
(defun my-map2-reduce())