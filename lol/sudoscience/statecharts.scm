(define-module (lol sudoscience statecharts)
  #:use-module (guix packages)
  #:use-module (guix licenses)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune))

(define git-ref (git-reference (url "https://github.com/bhlieberman/scxml.git")
			       (commit "53b6805")))

(define-public statecharts
  (package
   (name "statecharts")
   (version "0.1")
   (source (git-fetch git-ref 'sha256
		      "04wkz7z3d9w9yy59d89abvmswsjdhksw270ia7a61pfdy8w97b2c"))
   (build-system dune-build-system)
   (home-page "https://github.com/bhlieberman/scxml/")
   (synopsis "Implementation of the W3C Statechart XML notation in pure OCaml.")
   (description "Library for building statecharts conforming to a variant of the W3C standard appropriate to a variety of programming tasks for which FSM notation is appropriate. Alpha state, use with caution.")
   (license gpl3)))
