(define-module (statecharts)
  #:use-module (guix packages)
  #:use-module (guix licenses)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune))

(define-public statecharts
  (package
   (name "statecharts")
   (version "0.1")
   (source (origin (method git-fetch)
		   (uri (git-reference (url "https://github.com/bhlieberman/scxml.git")
				       (commit "HEAD")))
		   (hash (content-hash "0wknhyabf525grxshhj87sp4czk3vm5rrnraawmmsahd1piqz2j1"))))
   (build-system dune-build-system)
   (home-page "https://github.com/bhlieberman/scxml/")
   (synopsis "Implementation of the W3C Statechart XML notation in pure OCaml.")
   (description "Library for building statecharts conforming to a variant of the W3C standard appropriate to a variety of programming tasks for which FSM notation is appropriate. Alpha state, use with caution.")
   (license gpl3)))
