(define-module (lol sudoscience statecharts)
  #:use-module (guix packages))

(define-public statecharts
  (package
   (name "statecharts")
   (version "0.1")
   (source (origin
	    (method url-fetch)
	    (uri "https://github.com/bhlieberman/scxml/")))
   (build-system dune)
   (home-page "https://github.com/bhlieberman/scxml/")
   (synopsis "Implementation of the W3C Statechart XML notation in pure OCaml.")
   (description "Library for building statecharts conforming to a variant of the W3C standard appropriate to a variety of programming tasks for which FSM notation is appropriate. Alpha state, use with caution.")
   (license mit)))
