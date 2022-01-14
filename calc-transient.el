(require 'transient)
;; http://0x0.st/o-cL.png

;; calc-mode-map
;; calc-alg-map                     
;; calc-help-map                     
;; calc-mode-map                     
;; calc-digit-map                     
;; calc-alg-esc-map                     
;; calc-dispatch-map                     
;; calc-trail-mode-map                     
;; calc-fancy-prefix-map 

(transient-define-infix calc-transient-inverse
  :key "I"
  :class transient-lisp-variable
  :prompt "Inverse.."
  :variable calc-option-flag
  :reader (lambda (&rest args) (interactive)
            (setq calc-option-flag (not calc-option-flag))))

(transient-define-infix calc-transient-hyperbolic
  :key "H"
  :class transient-lisp-variable
  :prompt "Hyperbolic.."
  :variable calc-hyperbolic-flag
  :reader (lambda (&rest args) (interactive)
            (setq calc-hyperbolic-flag (not calc-hyperbolic-flag))))

(define-key calc-mode-map (kbd "SPC") #'calc-transient)
(define-key calc-mode-map (kbd "m") #'calc-transient-modes)

;; TODO Handle calc-total-algebraic-mode
(transient-define-prefix calc-transient-modes ()
  "Transient for calc modes"
  [["Input"
    ("a" "part algebraic" calc-algebraic-mode :transient t)
    ("t" "full algebraic" calc-total-algebraic-mode :transient t)
    ("S" "ignore case" calc-shift-prefix :transient t)
    
    "Calculation"
    ("s" "assume symb" calc-symbolic-mode :transient t)
    ;; ("\emt" 'calc-total-algebraic-mode)
    ;; ("\em\et" 'calc-total-algebraic-mode)
    ("v" "assume matrix" calc-matrix-mode :transient t)
    ("C" "auto-recompute" calc-auto-recompute :transient t)
    ("M" "recurse depth" calc-more-recursion-depth :transient t)]
   
   ["Simplify?"
    ("O" "no" calc-no-simplify-mode :transient t)
    ("N" "numbers only" calc-num-simplify-mode :transient t)
    ("I" "basic" calc-basic-simplify-mode :transient t)
    ("D" "default" calc-default-simplify-mode :transient t)
    ("B" "binary" calc-bin-simplify-mode :transient t)
    ("A" "standard" calc-alg-simplify-mode :transient t)
    ("E" "extended" calc-ext-simplify-mode :transient t)
    ("U" "units" calc-units-simplify-mode :transient t)]

   ["Display"
    ("f" "frac/float" calc-frac-mode :transient t)
    ("i" "infinities" calc-infinite-mode :transient t)
    ("w" "working" calc-working :transient t)
    ("p" "polar/rect" calc-polar-mode :transient t)
    
    "Angles"
    ("d" "degrees" calc-degrees-mode :transient t)
    ("r" "radians" calc-radians-mode :transient t)
    ("h" "deg-min-secs" calc-hms-mode :transient t)]
   
   ["State"
    ("m" "save" calc-save-modes :transient t)
    ("g" "load" calc-get-modes :transient t)
    ("x" "eager-load" calc-always-load-extensions :transient t)
    ("X" "load all" calc-load-everything :transient t)
    ("F" "Settings file" calc-settings-file-name :transient t)
    ("e" "save when embed" calc-embedded-preserve-modes
     :transient t
     :if (lambda () calc-embedded-info))
    ("R" "record" calc-mode-record-mode :transient t)]])



(transient-define-prefix calc-transient ()
  "Transient for calc."
  [:class transient-subgroups
          [:class transient-row
                  ("x" "Find command" calc-execute-extended-command)
                  ("t" "Trail" calc-transient-trail)
                  ("j" "Select" calc-transient-select)
                  ("i" "Info" calc-info)
                  ("h" "Help..." calc-transient-help)]
          [:class transient-columns
                  [("I" "Inverse.." calc-inverse)
                   ("H" "Hyperbolic.." calc-hyperbolic)]
                  [("U" "Undo" calc-undo)
                   ("D" "ReDo" calc-redo)]
                  [("d" "Display" calc-transient-display)
                   ("s" "Store" calc-transient-store)]
                  [("m" "Modes" calc-transient-modes)
                   ("c" "Convert" calc-transient-convert)]]]
  
  [["Operate"
    ("S" "Sin" calc-sin)
    ("C" "Cos" calc-cos)
    ("T" "Tan" calc-tan)
    ("E" "Exp" calc-exp)
    ("L" "Ln"  calc-ln)
    ("B" "Log" calc-log)]

   [""
    ("N" "Eval num" calc-eval-num)
    ("n" "Negate" calc-change-sign)
    ("&" "Invert" calc-inv)
    ("F" "⌊Floor⌋" calc-floor)
    ("R" "Round" calc-round)
    ("A" "| Abs |" calc-abs)]
   
   [""
    ("f" "functions" calc-transient-functions)
    ("J" "Conj⋆" calc-conj)
    ("%" "Modulo" calc-mod)
    ("!" "Factorial" calc-factorial)
    ("|" "Concat" calc-concat)]
   
   ["Commands"
    ("a" "Algebra" calc-transient-alg)
    ("b" "Binary/Business" calc-transient-binary/business)
    ("k" "Statistics" calc-transient-statistics)
    ("v" "Arrays" calc-transient-arrays)
    ("u" "Units" calc-transient-units)]

   [""
    ("t" "Time" calc-transient-trail)
    ("g" "Graphing" calc-transient-grahpics)
    ("p" "Precision" calc-precision)
    ("y" "Yank" calc-yank)
    ("w" "Why"  calc-why)
    ("Z" "User" calc-transient-user)]])


(transient-define-prefix calc-transient-statistics () [])
(transient-define-prefix calc-transient-binary/business () [])
(transient-define-prefix calc-transient-convert () [])
(transient-define-prefix calc-transient-display () [])
(transient-define-prefix calc-transient-store () [])
(transient-define-prefix calc-transient-trail () [])
(transient-define-prefix calc-transient-arrays () [])
(transient-define-prefix calc-transient-functions () [])
(transient-define-prefix calc-transient-grahpics () [])
(transient-define-prefix calc-transient-help () [])
(transient-define-prefix calc-transient-select () []) 
(transient-define-prefix calc-transient-user () []) 




(setq calc-transient-alg-entries 
      (let ((entries-alist))
        (cl-loop for (key cmd heading) in calc-transient-alg-map
                 do
                 (let ((entry (alist-get heading entries-alist
                                         nil nil 'equal)))
                   (setf (alist-get heading entries-alist nil nil 'equal)
                         (cons (list (substring key 1)
                                     (substring (symbol-name cmd) 5)
                                     cmd)
                               entry))
                   (message "%s" key))
                 finally return entries-alist)))

(defmacro calc-transient--make-prefix (prefix-name)
  `(transient-define-prefix ,(intern (concat "calc-transient-" prefix-name))
     "calc transient"
     [
      ,@(cl-loop for (heading . entries) in
                (symbol-value (intern (concat "calc-transient-" prefix-name "-entries")))
                collect `[ ,heading ,@entries ])
      ]))

(calc-transient--make-prefix "alg")

(transient-define-prefix calc-transient-alg "calc transient"
  
  [:class transient-row
   ("M-x" "find command" calc-execute-extended-command)
   ("M-i" "open info" calc-info )
   ("r" "rewrite" calc-rewrite)]
  [["Manipulate"
    ("b" "substitute" calc-substitute)
    ("s" "simplify" calc-simplify)
    ("e" "simplify-extended" calc-simplify-extended)
    ("c" "collect" calc-collect)
    ("f" "factor" calc-factor)
    ("x" "expand" calc-expand)
    ("A" "abs" calc-abs :level 5)
    ("v" "alg-evaluate" calc-alg-evaluate :level 5)
    ("n" "normalize-rat" calc-normalize-rat)
    ("a" "apart" calc-apart)
    ("/" "poly-div-rem" calc-poly-div-rem)
    ("%" "poly-rem" calc-poly-rem)
    ("\\" "poly-div" calc-poly-div)
    ("g" "poly-gcd" calc-poly-gcd)
    ]
   ["Calculus"
    ("d" "derivative" calc-derivative)
    ("i" "integral (symb)" calc-integral)
    ("I" "integral (numb)" calc-num-integral)
    ("t" "taylor" calc-taylor)
    
    "Solve"
    ("S" "solve (symb)" calc-solve-for)
    ("R" "solve (numb)" calc-find-root)
    ("P" "solve (poly)" calc-poly-roots)
    ("X" "maximize" calc-find-maximum)
    ("N" "minimize" calc-find-minimum)
    ("\"" "expand-formula" calc-expand-formula)]
   ["Map"
    ("+" " sum" calc-summation)
    ("-" "±sum" calc-alt-summation)
    ("*" "prod" calc-product)
    ("M" "map-equation" calc-map-equation)
    ("m" "match" calc-match)
    ("T" "tabulate" calc-tabulate)
    "Logical"
    (":" "if" calc-logical-if)
    ("!" "not" calc-logical-not)
    ("|" "or" calc-logical-or)
    ("&" "and" calc-logical-and)]
   ["Relation"
    ("{" "∈?" calc-in-set)
    (">" ">" calc-greater-than)
    ("<" "<" calc-less-than)
    ("]" "≥" calc-greater-equal)
    ("[" "≤" calc-less-equal)
    ("#" "≠" calc-not-equal-to)
    ("=" "=" calc-equal-to)
    ("." "remove =" calc-remove-equal)
    ("_" "subscript" calc-subscript)
    "Curve Fit"
    ("F" "curve-fit" calc-curve-fit)
    ("p" "poly-interp" calc-poly-interp)]
])

(define-key calc-mode-map (kbd "a") #'calc-transient-alg)

;; TODO: Enable digits and minus as prefix-arguments in this (and other)
;; transients
;; TODO: Add I | and H | and I v h and H v t and H v k and H v h,  I v s
;;       H v l, I V S, I V G, H V H, H v e, b u, b p, bo, ba, bd, bx, bn
;;       I v R, I v U, H v R, H v U
(transient-define-prefix calc-transient-vector ()
  "A transient for vector arithmetic in calc."
  
  [:class transient-row
   ("M-x" "find command" calc-execute-extended-command)
   ("M-i" "open info" calc-info )
   ("r" "rewrite" calc-rewrite)]
  
  [["Stack"
    ("p" "pack" calc-pack)
    ("u" "unpack" calc-unpack)
    ("M-u" "unpackt" (lambda () (interactive) (calcFunc-unpackt)) :level 5)
    ("|" "concat" calc-concat)
    ("k" "kons" calc-cons)
    "Extract"
    ("r" "row" calc-mrow)
    ("c" "col" calc-mcol)
    ("h" "head" calc-head)
    ("M-t" "tail" calc-tail)
    ("_" "subscript" calc-subscript)
    ("s" "subvec" calc-subvector)]
   ["As Vector"
    ("l" "length" calc-vlength)
    ("f" "find" calc-vector-find)
    ("S" "sort" calc-sort)
    ("v" "reverse" calc-reverse-vector)
    ("m" "mask" calc-mask-vector)
    ("e" "expand" calc-expand-vector)
    "Build"
    ("b" "build" calc-build-vector)
    ("x" "indexed" calc-index)
    ("d" "diag" calc-diag)
    ("i" "identity" calc-ident)]
   
   ["As Matrix"
    ("t" "transpose" calc-transpose)
    ("&" "inverse" calc-inv)
    ("D" "determinant" calc-mdet)
    ("T" "trace" calc-mtrace)
    ("J" "conj trans" calc-conj-transpose)
    ("L" "LU factor" calc-mlud)
    ("a" "reshape" calc-arrange-vector)
    "Multiply"
    ("C" "cross prod" calc-cross)
    ("K" "kron prod" calc-kron)
    ("O" "outer prod" calc-outer-product)
    ("I" "inner prod" calc-inner-product)]

   ["As Set"
    ("+" "dedupe" calc-remove-duplicates)
    ("V" "union" calc-set-union)
    ("^" "intersect" calc-set-intersect)
    ("-" "difference" calc-set-difference)
    ("X" "XOR" calc-set-xor)
    ("~" "complement" calc-set-complement)
    ("F" "floor" calc-set-floor)
    ("E" "enumerate" calc-set-enumerate)
    (":" "to span" calc-set-span)
    ("#" "cardinality" calc-set-cardinality)]
   
   ["Norm"
    ("A" "frob norm" calc-abs)
    ("n" "row norm" calc-rnorm)
    ("N" "col norm" calc-cnorm)
    "Introspect"
    ("G" "grade" calc-grade)
    ("H" "histogram" calc-histogram)
    "Map/Reduce"
    ("A" "apply" calc-apply)
    ("M" "map.." calc-transient-vector-map)
    ("R" "reduce.." calc-transient-vector-reduce)
    ("U" "accumulate" calc-accumulate)
    ]
   
   ])

(transient-define-prefix calc-transient-vector-map ()
  "Transient for mapping operations in calc"
  [("RET" "map" calc-map)
    ("_" "map by row" (lambda () (interactive) (calcFunc-mapr)))
    (":" "map by col" (lambda () (interactive) (calcFunc-mapc)))])

(transient-define-prefix calc-transient-vector-reduce ()
  "Transient for reducing operations in calc"
  [("RET" "reduce" calc-reduce)
    ("_" "reduce each rows" (lambda () (interactive) (calcFunc-reducea)))
    (":" "reduce each cols" (lambda () (interactive) (calcFunc-reduced)))
    ("=" "reduce with rows" (lambda () (interactive) (calcFunc-reducer)))
    ("|" "reduce with cols" (lambda () (interactive) (calcFunc-reducec)))])

(define-key calc-mode-map (kbd "M-v") 'calc-transient-vector)

;; TODO add calc-quick-units support for u-1 through u-0
;; TODO logarithmic units (info "(calc) Logarithmic Units")
;; TODO calc-vector-mean-error 'I u M'
(transient-define-prefix calc-transient-units ()
  "A transient for unit calculations in calc."
  [:class transient-row
          ("M-x" "find command" calc-execute-extended-command)
          ("M-i" "open info" calc-info )
          ("r" "rewrite" calc-rewrite)]
  [:class transient-row
          ("I" "error.." calc-inverse)
          ("H" "median.." calc-hyperbolic)]
  [["Units"
    ("s" "simplify" calc-simplify-units)
    ("u" "convert"  calc-convert-units)
    ("n" "convert exact" calc-convert-exact-units)
    ("b" "convert base" calc-base-units)
    ("t" "temperature" calc-convert-temperature)
    ("r" "remove units" calc-remove-units)
    ("x" "extract units" calc-extract-units)]
   [""
    ("a" "autoranges" calc-autorange-units :transient t)
    ("v" "goto table" calc-enter-units-table)
    ("V" "view table" calc-view-units-table :transient t)
    ("g" "definition" calc-get-unit-definition)
    ("e" "explain"    calc-explain-units)
    ("d" "define"     calc-define-unit)
    ("u" "undefine"   calc-undefine-unit)
    ("p" "permanent"  calc-permanent-units)]
   ["Statistics"
    ("M" "arth mean" calc-vector-mean)
    ("G" "geom mean" calc-vector-geometric-mean)
    ("R" "rms" calc-vector-rms)
    ("S" "stdev" calc-vector-sdev)
    ("C" "covariance" calc-vector-covariance)]
   [""
    ("#" "count" calc-vector-count)
    ("+" "∑ sum" calc-vector-sum)
    ("*" "∏ prod" calc-vector-product)
    ("X" "maximum" calc-vector-max)
    ("N" "minimum" calc-vector-min)
    ("F" "flatten" (lambda () (interactive)
                     (calcFunc-vflat)))]])
