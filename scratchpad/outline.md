# Computation For Kids of All Ages!


---

## Peter's notes:

### Summary
Can we teach computation from both a lambda calculus perspective in a lisp dialect - hy - and a turing-machine equivalency to show how it is evaluated and executed by hardware?

The result of working through everything should be a degree of understanding of types - ints, strings, booleans, lists, dicts and sets; understanding of a high-level notation (lisp) and how to translate/map it to a low-level notation (assembly); basic understanding of machine architecture and how software uses it.

The work should progress to implementing a familiar algorithm that is familiar to children, such as long division.


### Paper exercises
I think this is teachable using paper exercises before moving to actual computer. Syntax and a set of operators can be easily taught and evaluated on paper, especially math.

A paper worksheet session can be immediately followed by a repl session to experiment freely with what was learned.

It would be nice to include access to a limited assembly environment. Suggestions?
* inline asm for python would be nice here


### Worksheet Progression

#### 1a. On paper: Playing with integers
Starting here, with easy math and operators because the math isn't the main point
```
(+ 1 1)
(+ 1 2 3)
(* 2 2)
(+ (* 2 3) 4)
(+ (* 2 3) (* 4 5))
(+ 4 (* 2 3))
```

* Expand each expression into a tree of functions and arguments
* Traverse the tree to evaluate and collapse leaves
* Keep this to a double-sided sheet of expressions with space for working between them?


#### 1b. On paper: Translating to machine instructions
Using an abstract machine ISA with only a handful of instructions and assuming unlimited registers, no memory. Introduce instructions such as `mov`, `add` and `mul` and the register set.

Translate the expressions in 1a to machine code sequences.
```
load 1 reg1
add 2 reg1
add 3 reg1
```

* Following the tree evaluation order in 1a, write sequences of instructions that will calculate the result
* Instructions: load literal, add lit/reg reg, mul lit/reg reg, sub lit/reg reg, div lit/reg reg (integer), copy reg reg
* Registers: reg1...regN
* The result should be in reg1

* Play with hy repl when done!


#### 2a. On paper: Named variables
These I might describe as a box with a label on it with something in the box.
```
(setv my-age 37)
(setv house-number 23)
```
and then the use of variables
```
(setv x 3)
x
(+ x 1)
(setv y 5)
(+ x y)
```


#### 2b. On paper: Memory
This might be the place to introduce memory, given that you can't fit all variables into registers. Memory is a numbered sequence of boxes.


#### 3a. On paper: Playing with the string type
Anything between two double quotes "is a string". A string is a list of characters. Characters include the poop emoji. Maybe surprisingly, digits can be in a string too: "I am 10 years old" - 1 and 0 are individual characters. Digits in a string are not the same as numbers you can do math on.
```
(+ 3 4)
(+ "3" "4")
(+ "Jon" "athan")
(* "banana" 3)
(setv name (+ "Jon" "athan"))
(setv name (input "What is your name?"))
name
(print name)
(str 5)
(int "5")
(int "banana")
```


#### 3b. On paper: Strings in memory
As a sequence of characters, a string is a length integer in a memory slot followed by a sequence of characters. Assume each character fits into a memory slot.

Understand that a register can mean the number of a slot in memory (an address).

* Show the memory representations of the results of the following string manipulations...


#### n. Arrays and Addresses
Building on strings, arrays are mutable and can contain value types other than characters.

#### n. 


#### n. Comparisons and the boolean type
```
(= 2 3)
(= 3 3)
(= "alice" "bob")
(= "bob" "bob")
(= True True)
(= True False)
(and True True)
(and True False)
(or False True)
(and (= 2 3) (= 3 3))
(or (= 2 3) (= 3 3))
```


#### n. Conditionals
```
(setv name (input "What is your name?"))
(if (= name "Jonathan")
    (print "I knew it was you!")
    (print "I wasn't expecting you!"))

(setv my-age 13)
(setv your-age (int (input "How old are you?")))
(if (> my-age your-age)
    (print "I'm older than you!")
    (print "You're at least as old as I am."))
```


#### n. User defined functions
```
(defn greet [name] (print "Hello" name))
(greet "Jojo")
```

#### n. Addition algorithm

```
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
```

---

### Notes on hy

hy (hylang.org) is an alternative Python syntax that compiles to the Python AST, so it follows Python semantics. It leans towards an expression-based functional style where possible, though that's somewhat limited given it's still Python.

Advantages:

* s-expression syntax is easy to learn when you haven't got a-priori experience in programming languages
* no need to comprehend things like operator precedence rules, significant whitespace, lvalues
* complete set of builtin types with much more intuitive function naming than Common Lisp
* it allows eventual 1:1 comparison and translation of hy to Python syntax, leading to learning Python and the whole universe of python modules and packages available that are easier to get started with than Clojure

---

## Derek's Thoughts:

### Summary
My thoughts are less fully formed as I've been thinking about teaching through scratch and visual feedback - but I think that aside from getting kids (and other people) excited about programming a different approach is needed to go further. As such, my thoughts are going to be more like questions that maybe will be refined over time.

### Computer architecture
We've talked about teaching CPU microarchitecture through an assembly based approach. This sounds cool, but it also sounds harder than the lambda calculus based approach to teaching programming above. My questions are:

* Do we teach lambda calculus and ISA/VMs at the same time?
* How do we teach types while also teaching ISA/VMs that treat all memory as bits/bytes/words/addresses?
* Do we teach completely through code? Do we care about block diagrams?
* I have trouble with levels of abstractions that are all of minimal, accurate, and effective for application - I'll need to reign it in here :-)

(@pete - where'd your notes on my notes go? I liked em)

@derek
* lambda-calc through a lisp and turing-machine through a simple abstract machine at the same time, developing both simultaneously and keeping them tied together
  * lisp gives structure to computations; the machine executes them
* we start out by ignoring bits and binary - every atomic value (an integer, a character in a string) occupies a single register or address no matter how many binary bits it would use in reality
  * machine abstraction 1: unlimited registers; no bits, every atomic value type fits entirely into a register
  * 2: limited registers, unlimited memory; no bits
  * 3: limited registers, unlimited memory; no bits, introduce stack vs heap
  * 3: limited registers, limited memory; garbage collection
  * 4: limited registers, limited memory; mapping values to bytes and words
* what kind of block diagrams? can you link to an example?


### (Minimal?) conceptual model
For a register machine:
* memory
    * addresses
    * registers
* compute
    * instructions
    * pc / jumps

I think we can start here and not need to deal with stack/heap yet. I think register machines are easier to relate to. I don't think we need to talk about function call handling and passing data on the stack as we can store whatever we need in registers and memory. It may be the case that we will need to talk about a stack if we pick a stack based ISA/VM to build on ... but if we can avoid it at first I'd like to.

### Logical operations
Aside from math, we'll need some logic training - do we start with discrete math? Kids already have arithmatic under their belts to some degree, but some adults never learn any logic in a math sense.

Basic(?) logic stuff:
* Operators (AND, OR, XOR, NOT, Impilication, IFF)
* Truth tables (AND, NAND, OR, NOR, XOR, XNOR, Implication, IFF)

@derek - I think the answer to "set theory" applies here, plus of course that at least a subset of boolean logic and their truth tables are necessary to understand (minimally AND, OR and NOT)

### Set theory
Do we care yet?

@derek - I definitely want this all be as concretely and intuitively understandable as possible, which is why I want minimal notation and simplistic language (lisp and abstract machines.) I feel like anybody following along shouldn't have to know they're using discrete math and set theory and what those are and that if we go in a direction of explicitly discussing those things they should be directly relatable back to code and types. I don't know what this looks like yet.

@pete - i totally agree with your model. start with concrete and teach by doing. i suppose what i would like to do is figure out which and what order to move through these concepts - so that we can boil them down to the concrete code layer. there's a temptation to just go through a bunch of examples (i did this with scratch) and loose any cohesive related conceptual continuity. if we can group our stages/lessons conceptually but teach through concrete example. that way we can build on the example and talk about why or what it relates to etc as students are interested and/or able.

@derek - yes!
