#!/usr/bin/env hy

; We start out by ignoring bits and binary.
; Every atomic value (an integer, a character in a string) occupies a single
; register or address no matter how many binary bits it would use in reality
;
; Machine abstraction levels:
; 1. unlimited registers; every atomic value type fits entirely into a register
; 2. limited registers, unlimited ad-hoc memory; every atomic value fits entirely into a memory 'box', arrays are consecutive boxes
; 3. limited registers, unlimited ad-hoc memory; introduce stack vs heap
; 4. limited registers, limited, ordered memory; garbage collection
; 5. limited registers, limited, ordered memory; map values to bytes and words



; 1. Basic math
; Machine abstraction level 1
;
; * draw out the tree
; * evaluate the nodes depth first
; * translate to an instruction representation

(+ 1 1)
(+ 2 3)
(+ (+ 1 1) 2)
(+ 1 (+ 2 3))
(+ (+ 1 1) (+ 2 3))
(* 2 3)
(* (+ 1 2) (+ 2 3))
(- 3 2)
(- (+ 1 (* 4 2)) 3)
(// 10 2)
(// 10 3)
(% 10 3)
(% 10 2)

; 2. Named variables
; Machine abstraction level 2
;
; *

(setv max-age 3)
(setv ruby-age 1)
(setv difference (- max-age ruby-age))
difference

(setv speed-mph 45)
(setv drive-time-hours 3)
(setv distance-driven (* speed-mph drive-time-hours))
distance-driven

; 3. Strings
; Machine abstraction level 2

(+ 3 4)
(+ "3" "4")
(+ "Jon" "athan")
(* "banana" 3)
(setv name (+ "Jon" "athan"))
(setv name (input "What is your name?"))
(print name)
(str 5)
(int "5")
(int "banana")

; 4. Arrays
; Machine abstraction level 2

(setv my-favorite-toys ["bow and arrows"
                        "sword"
                        "rubber chicken"
                        "Lego"
                        "cape"])

(print my-favorite-toys)
(get my-favorite-toys 0)
(get my-favorite-toys 1)
(get my-favorite-toys 2)
(get my-favorite-toys 3)
(get my-favorite-toys 4)

(get my-favorite-toys 5)
(len my-favorite-toys)

(.append my-favorite-toys "armor")
(len my-favorite-toys)

(del (get my-favorite-toys 0))
(print my-favorite-toys)

; 5. Comparisons, booleans
; Machine abstraction level 2

= < > <= >=
and or xor not

; 6. Conditionals
; Machine abstraction level 2

; (if ...)
; (cond ...)

; 7. User-defined functions
; Machine abstraction level 3

; (defn ...)
