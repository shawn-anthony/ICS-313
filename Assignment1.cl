;;;Shawn Anthony
;;;ICS 313 Biagioni 
;;;Fall 2021
;;;Assignment 1

(defvar *db* nil)

;Takes contact parameters and error checks them before creating the plist 
(defun make-contact (first-name last-name address phone)
  (cond 
  ((and (null first-name) (null last-name)) (format t "Contact must have a first or last name~%"))
  ((not (or (stringp first-name) (null first-name))) (format t "First name must be a string or nil~%"))
  ((not (or (stringp last-name) (null last-name))) (format t "Last name must be a string or nil~%"))
  ((not (or (stringp address) (null address))) (format t "Address must be a string~%"))
  ((not (or (stringp phone) (null phone))) (format t "Phone must be a string~%"))       
  (t (list :first-name first-name :last-name last-name :address address :phone phone))))

;takes a contact plist as parameter and pushes it onto *db*, then cleans db head of nil 
(defun add-contacts (contact) (push contact *db*)(clean-db))


;dumps *db* in readable form using format
(defun dump-db ()
  (dolist (contact *db*)
    (format t "~{~a:~10t~a~%~}~%" contact)))

;saves db to specified location and filename
(defun save-db (filename)
  (with-open-file (out filename
                   :direction :output
                   :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))

;loads db from specified filename
(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))


;selects a field matching the value using a selector function
(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

;selector function for first-name
(defun first-selector (first-name)
  #'(lambda (contact) (equal (getf contact :first-name) first-name)))

;selector function for last-name
(defun last-selector (last-name)
  #'(lambda (contact) (equal (getf contact :last-name) last-name)))

;selector function for address
(defun address-selector (address)
  #'(lambda (contact) (equal (getf contact :address) address)))

;selector function for phone
(defun phone-selector (phone)
  #'(lambda (contact) (equal (getf contact :phone) phone)))


;uses select function to filter on all fields in the db
(defun where (&key (first-name nil first-name-p) (last-name nil last-name-p)(address nil address-p)(phone nil phone-p))
  #'(lambda (contact)
      (and
       (if first-name-p   (equal (getf contact :first-name)  first-name)  t)
       (if last-name-p    (equal (getf contact :last-name) last-name) t)
       (if address-p      (equal (getf contact :address) address) t)
       (if phone-p        (equal (getf contact :phone) phone) t))))

;function cleans nil's from db after pushing them if it fails check in make-contact
(defun clean-db () (cond ((null (car *db*)) (pop *db*))(t())))


;  test-add
;  (add-contacts (make-contact "a" "b" "c" "d"))
;  (add-contacts (make-contact "a" "b" "c" nil))
;  (add-contacts (make-contact "a" "b" nil "d"))
;  (add-contacts (make-contact "a" nil "c" "d"))
;  (add-contacts (make-contact nil "b" "c" "d"))
;  (add-contacts (make-contact nil nil "c" "d"))
;  (add-contacts (make-contact "a" "b" 1 "d"))
;  (add-contacts (make-contact "a" "b" "c" 1))
;  (add-contacts (make-contact "a" "b" "c" 1))
;  (add-contacts (make-contact "a" 1 "c" "d"))
;  (add-contacts (make-contact 1 "b" "c" "d"))
;  (add-contacts (make-contact 1 2 "c" "d")))


;test-save
;(save-db "C:\\Users\\shawn\\Documents\\my-cds")

;test-load
;(load-db "C:\\Users\\shawn\\Documents\\my-cds")

;  test-select
;  (select (first-selector "a"))
;  (select (last-selector "b"))
;  (select (address-selector "c"))
;  (select (phone-selector "d"))


;  test-where
;  (select (where :first-name "a"))
;  (select (where :last-name "b"))
;  (select (where :first-name nil))
;  (select (where :last-name nil))
;  (select (where :address nil))
;  (select (where :address "c"))
;  (select (where :phone "d"))
;  (select (where :phone nil))  
;  (select (where :address "c" :phone "d"))
