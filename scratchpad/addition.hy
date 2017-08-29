#!/usr/bin/env hy

(setv base 10)

(defn digit-string-to-list [digit-string]
  "Convert a number in a string to a list of the individual digits as ints each"
  (list (map (fn [d] (int d))
             (reversed digit-string))))

(defn list-to-digit-string [digit-list]
  "Convert a list of int digits to a string of the consecutive digits"
  (.join "" (reversed (list (map (fn [d] (str d))
                                 digit-list)))))

(defn get-digit [digit-list index]
  "Get the digit at position 'index' in the 'digits' list,
   returning 0 if index is bigger than the length of the list"
  (if (>= index (len digit-list))
    0
    (get digit-list index)))

(defn more-digits? [as bs carrys index]
  "Return False if we've used up all the numbers and the next carry is a zero"
  (not (and (>= index (len as))
            (>= index (len bs))
            (= 0 (get carrys index)))))

(defn add-with-carry [as bs carrys index]
  "Add the digits at position 'index' in lists as, bs and carrys"
  (+ (get-digit as index)
     (get-digit bs index)
     (get-digit carrys index)))

(defn first-digit [num]
  "Get the ones digit from the number"
  (% num base))

(defn carry-digit [num]
  "Get the carry digit from the number"
  (// num base))

(defn add []
  "Add two numbers and print the result"

  (setv num1 (digit-string-to-list (input "give me a number: ")))
  (setv num2 (digit-string-to-list (input "give me another number: ")))

  (setv index 0)
  (setv result [])
  (setv carrys [0])

  (while (more-digits? num1 num2 carrys index)
    (setv added (add-with-carry num1 num2 carrys index))
    (setv ones (first-digit added))
    (setv carry (carry-digit added))
    (.append result ones)
    (.append carrys carry)
    (setv index (inc index)))

  (print "The answer is" (list-to-digit-string result)))

